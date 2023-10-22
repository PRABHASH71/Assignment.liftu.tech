import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internshipapp/CheckoutPage.dart';
import 'package:internshipapp/Models/ProductModel.dart';
import 'package:internshipapp/categories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> productList = [];

  Future<List<ProductModel>> getApi() async {
    productList.clear();
    final response =
        await http.get(Uri.parse("https://api.escuelajs.co/api/v1/products"));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        productList.add(ProductModel.fromJson(i));
      }
      return productList;
    } else {
      return productList;
    }
  }

  List<Category> categoriesList = [];

  Future<List<Category>> getCategoryApi() async {
    categoriesList.clear();
    final response =
        await http.get(Uri.parse("https://api.escuelajs.co/api/v1/categories"));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        categoriesList.add(Category.fromJson(i));
      }
      return categoriesList;
    } else {
      return categoriesList;
    }
  }

  List<ProductModel> categorieslist2 = [];

  void fun(int y) {
    y = y + 1;
    categorieslist2.clear();
    for (int i = 0; i < productList.length; i++) {
      if (productList[i].category!.id == y) {
        categorieslist2.add(productList[i]);
      }
    }

    if (categoriesList != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Categories(
                    categorielist: categorieslist2,
                  )));
    }
  }

  TextEditingController search = TextEditingController();

  List<ProductModel> searchList = [];
  void searchProduct(String value) {
    searchList = productList
        .where((element) =>
            element.title!.toLowerCase().contains(value.toLowerCase()))
        .toList();

    setState(() {});
  }

  void check(int y) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CheckPage(
                  newmap: productList[y],
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            "MyCart",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
            backgroundColor: Colors.amber,
            child: Column(
              children: [
                DrawerHeader(
                    child: Image.network(
                        "https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png")),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Divider(
                    color: Colors.grey[800],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Home',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    title: Text(
                      'About',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Orders',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Settings',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )),
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 50,
                      width: 290,
                      child: TextFormField(
                        controller: search,
                        onChanged: (String value) {
                          searchProduct(value);
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.search),
                          border: InputBorder.none,
                          hintText: "Search here...",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Flexible(
                  fit: FlexFit.loose,
                  flex: 1,
                  child: FutureBuilder(
                      future: getCategoryApi(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                            itemCount: categoriesList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  fun(index);
                                },
                                child: Container(
                                    width: 180,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.network(
                                          categoriesList[index]
                                              .image
                                              .toString(),
                                          height: 30,
                                          width: 30,
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Text(
                                          categoriesList[index].name.toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                              );
                            });
                      })),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Text(
                      "Best Selling",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              Flexible(
                  flex: 7,
                  fit: FlexFit.loose,
                  child: FutureBuilder(
                      future: getApi(),
                      builder: (context, snapshot) {
                        return search.text.isNotEmpty && searchList.isEmpty
                            ? Center(child: Text("No Product Found"))
                            : searchList.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, right: 20),
                                    child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.78,
                                        ),
                                        itemCount: searchList.length,
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              check(index);
                                            },
                                            child: Container(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                width: 80,
                                                child: Column(
                                                  children: [
                                                    Image.network(
                                                      searchList[index]
                                                          .images![0]
                                                          .toString(),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      searchList[index]
                                                          .title
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                )),
                                          );
                                        }),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, right: 20),
                                    child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.78,
                                        ),
                                        itemCount: productList.length,
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              check(index);
                                            },
                                            child: Container(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                width: 80,
                                                child: Column(
                                                  children: [
                                                    Image.network(
                                                      productList[index]
                                                          .images![0]
                                                          .toString(),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      productList[index]
                                                          .title
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                )),
                                          );
                                        }),
                                  );
                      })),
            ],
          ),
        ));
  }
}
