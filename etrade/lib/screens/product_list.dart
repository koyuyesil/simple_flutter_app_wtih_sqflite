import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:etrade/data/dbHelper.dart';
import 'package:etrade/models/product.dart';
import 'package:etrade/screens/product_add.dart';
import 'package:etrade/screens/product_details.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State {
  var dbHelper = new DbHelper();
  late List<Product> products;
  int productCount = 0;

  @override
  void initState() {
    getProducts();
    //super.initState(); //kalıtılandan gelen asıl metod
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Listesi"),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToProductAdd();
        },
        child: Icon(Icons.add),
        tooltip: "Yeni Ürün Ekle",
      ),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.cyan,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.pinkAccent,
                child: Text("Prd."),
              ),
              title: Text(this.products[position].name),
              subtitle: Text(this.products[position].description),
              onTap: () {
                goToDetail(this.products[position]);
              },
            ),
          );
        });
  }

  void message(String s) {
    Fluttertoast.showToast(
        msg: s,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void getProducts() {
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      setState(() {
        this.products = data;
        productCount = data.length;
      });
    });
  }

  Future<void> goToProductAdd() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductAdd()));
    if (result != null) {
      if (result) {
        getProducts();
        message("Eklendi");
      }
    }
  }

  void goToDetail(Product product) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetails(product)));
    if (result != null) {
      if (result) {
        getProducts();
      }
    }
  }
}
