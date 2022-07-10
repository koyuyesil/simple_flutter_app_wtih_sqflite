import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:etrade/data/dbHelper.dart';
import 'package:etrade/models/product.dart';

class ProductDetails extends StatefulWidget {
  Product product;
  ProductDetails(this.product);
  @override
  State<StatefulWidget> createState() {
    return _ProductDetailsState(product);
  }
}

enum Options { delete, update }

class _ProductDetailsState extends State {
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();
  Product product;
  //constructor
  _ProductDetailsState(this.product);

  @override
  void initState() {
    txtName = TextEditingController(text: product.name);
    //txtName.text =product.name;
    txtDescription = TextEditingController(text: product.description);
    txtUnitPrice = TextEditingController(text: product.unitPrice.toString());
    //super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Detayları :${product.name}"),
        actions: <Widget>[
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Sil"),
              ),
              PopupMenuItem<Options>(
                value: Options.update,
                child: Text("Güncelle"),
              )
            ],
          )
        ],
      ),
      body: buildProductDetails(),
    );
  }

  void selectProcess(Options value) async {
    print(value);
    switch (value) {
      case Options.delete:
        await dbHelper.delete(product.id);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.update(Product.withId(
            id: product.id,
            name: txtName.text,
            description: txtDescription.text,
            unitPrice: double.tryParse(txtUnitPrice.text)!));
        Navigator.pop(context, true);
        break;
      default:
        print(value);
    }
  }

  buildProductDetails() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          buildNameField(),
          buildDescriptionField(),
          buildUnitPriceField()
        ],
      ),
    );
  }

  buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Adı:"),
      controller: txtName,
    );
  }

  buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Açıklaması:"),
      controller: txtDescription,
    );
  }

  buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: "Birim Fİyatı:"),
      controller: txtUnitPrice,
    );
  }
}
