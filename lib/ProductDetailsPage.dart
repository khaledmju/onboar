import 'package:flutter/material.dart';

import 'ProductsPage.dart';

class ProductDetailsPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final productData;

  const ProductDetailsPage({super.key, this.productData});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPage();
}

class _ProductDetailsPage extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: Text("${widget.productData['title']}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromARGB(255, 20, 54, 64),
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal)),
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 66, 252, 169),
              elevation: 4,
              shadowColor: const Color.fromARGB(255, 48, 193, 152),
              actions: [
                IconButton(
                    onPressed: () {
                      showSearch(context: context, delegate: SearchCustom());
                    },
                    icon: const Icon(Icons.search)),
              ]),
          body: Container(
              color: Colors.white,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 30,),
                      Image.asset(
                        "${widget.productData['image']}",
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.fitHeight,
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        // decoration: BoxDecoration(
                        //   color : const Color.fromARGB(255, 66, 252, 169),
                        //   border: Border.all(width: 2),
                        //   borderRadius: BorderRadius.circular(10),
                        // ),
                        child: Text(
                          "${widget.productData['title']}",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 20, 54, 64)),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "${widget.productData['subtitle']}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 48, 193, 152)),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Quantity : ${widget.productData['quantity']}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Price : ${widget.productData['price']}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 20, 54, 64),
                            padding: EdgeInsets.symmetric(horizontal: 40)),
                        child: Text("Add to Cart",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: Color.fromARGB(255, 66, 252, 169),
                            ))),
                  )
                ],
              )),
        ));
  }
}
