import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internshipapp/categories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? stringresponse;

  List? newlist;
  List? newlist1;
  int c = 0;

  List<dynamic>? Categories1 = [];

  Future apicalling() async {
    http.Response response1;
    response1 =
        await http.get(Uri.parse("https://api.escuelajs.co/api/v1/products"));
    if (response1.statusCode == 200) {
      setState(() {
        newlist = json.decode(response1.body);
      });
    }

    //

    http.Response response2;
    response2 =
        await http.get(Uri.parse("https://api.escuelajs.co/api/v1/categories"));
    if (response1.statusCode == 200) {
      setState(() {
        newlist1 = json.decode(response2.body);
        c = newlist1!.length;
      });
    }
  }

  void fun(int y) {
    y = y + 1;
    Categories1!.clear();
    newlist!.forEach((element) {
      Map obj = element;
      Map categories = obj['category'];
      int id = categories['id'];
      if (id == y) {
        Categories1?.add(element);
      }
    });
    if (Categories1 != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Categories(categorielist: Categories1)));
    }
  }

  @override
  void initState() {
    apicalling();

    super.initState();
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
        body: newlist == null && newlist1 == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
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
                            margin: EdgeInsets.only(left: 5),
                            height: 50,
                            width: 290,
                            child: TextFormField(
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
                    Expanded(
                        child: ListView.builder(
                            itemCount: c,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  fun(index);
                                },
                                child: Container(
                                    margin:
                                        EdgeInsets.only(left: 25, bottom: 180),
                                    width: 280,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          newlist1![index]['image'] ??
                                              "null".toString(),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          newlist1![index]['name'] ??
                                              "null".toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                              );
                            }))
                  ],
                ),
              ));
  }
}
