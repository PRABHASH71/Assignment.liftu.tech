import 'package:flutter/material.dart';

class CheckPage extends StatefulWidget {
  final Map? newmap;

  const CheckPage({this.newmap, super.key});

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  int qty = 1;
  bool fav = false;

  List fun() {
    return widget.newmap!['images'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            "Product",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: (widget.newmap == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 5,
                        child: ListView.builder(
                            itemCount: 2,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index1) {
                              return buildCard(index1);
                            })),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.newmap!['title'].toString(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (fav) {
                                  fav = !fav;
                                } else {
                                  fav = !fav;
                                }
                              });
                            },
                            icon: Icon(
                              (fav)
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: Colors.red,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                      child: Text(
                        "\₹" + widget.newmap!['price'].toString(),
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.newmap!['description'].toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 41, 41, 41),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (qty > 1) {
                                qty--;
                              }
                            });
                          },
                          child: CircleAvatar(
                            radius: 17,
                            child: Icon(
                              Icons.remove,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          qty.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              qty++;
                            });
                          },
                          child: CircleAvatar(
                            radius: 17,
                            child: Icon(
                              Icons.add,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        OutlinedButton(
                            onPressed: () {}, child: Text("ADD TO CART")),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 35,
                          width: 130,
                          child: ElevatedButton(
                              onPressed: () {}, child: Text("BUY")),
                        )
                      ],
                    ),
                  ],
                ),
              ));
  }

  Widget buildCard(int index1) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Image.network(
              fun()[index1].toString(),
              height: 350,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
