import 'package:flutter/material.dart';
import 'package:internshipapp/CheckoutPage.dart';
import 'package:internshipapp/Models/ProductModel.dart';

class Categories extends StatefulWidget {
  final List<ProductModel>? categorielist;

  Categories({this.categorielist});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  void check(int id) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CheckPage(
              newmap: widget.categorielist![id],
            )));
  }

  String fun(int i) {
    return widget.categorielist![i].images![0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            "Categories",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.78,
                ),
                itemCount: widget.categorielist!.length,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        check(index);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          child: Column(
                            children: [
                              Image.network(fun(index).toString()),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.categorielist![index].title.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          )),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
