class Product {
  late int id;
  late String name;
  late String description;
  late double unitPrice;

  Product(
      {required this.name, required this.description, required this.unitPrice});
  Product.withId(
      {required this.id,
      required this.name,
      required this.description,
      required this.unitPrice});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = this.name;
    map["description"] = this.description;
    map["unitPrice"] = this.unitPrice;
    if (map["id"] != null) {
      map["id"] = this.id;
    }
    return map;
  }

  Product.fromObject(dynamic o) {
    this.id = o["id"];
    this.name = o["name"];
    this.description = o["description"];
    this.unitPrice = double.tryParse(o["unitPrice"].toString())!;
  }

  void a() {
    var urun = Product(name: "name", description: "desc", unitPrice: 500);
    var urunmap = urun.toMap();
  }
}
