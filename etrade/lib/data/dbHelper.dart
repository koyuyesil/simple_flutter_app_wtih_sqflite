import 'package:etrade/models/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static const String dname = 'database.db';
  static const String tprod = 'products';

  // Use a single reference to the db.
  static Database? _db;
  // Use this getter to use the database.
  Future<Database?> get db async {
    if (_db != null) return _db;
    // Instantiate db the first time it is accessed
    _db = await initailizeDb();
    return _db;
  }

  Future<Database> initailizeDb() async {
    //String dbPath = join(await getDatabasesPath(), dname);
    String dbPath =
        join("data/data/com.koyuyesil.simplesqliteapp/databases", dname);
    var eTradeDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return eTradeDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table products(id integer primary key, name text, description text, unitPrice decimal)");
  }

  Future<List<Product>> getProducts() async {
    Database? db = await this.db;
    var result = await db?.query(tprod);
    var len = result?.length;
    var last =
        List.generate(len!, (index) => Product.fromObject(result![index]));
    return last;
  }

  Future<int> insert(Product product) async {
    Database? db = await this.db;
    var result = await db?.insert(tprod, product.toMap());
    return result!;
  }

  Future<int> delete(int id) async {
    Database? db = await this.db;
    var result = await db?.rawDelete("delete from products where id= $id");
    return result!;
  }

  Future<int> update(Product product) async {
    Database? db = await this.db;
    var result = await db?.update(tprod, product.toMap(),
        where: "id=?", whereArgs: [product.id]);
    return result!;
  }
}
