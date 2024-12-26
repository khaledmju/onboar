import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboar/ProductDetailsPage.dart';
import 'FavoritesController.dart';

class FavoritesPage extends StatelessWidget {
  final FavoritesController favoritesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favorite Products",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 66, 252, 169),
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (favoritesController.favoriteProducts.isEmpty) {
          return const Center(child: Text("No favorite products yet."));
        }
        return GridView.builder(
          itemCount: favoritesController.favoriteProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 220),
          itemBuilder: (context, index) {
            final product = favoritesController.favoriteProducts[index];
            return InkWell(
              onTap: () {
                Get.to(() => ProductDetailsPage(productData: product));
              },
              child: Card(
                child: Column(
                  children: [
                    Image.asset(product["image"], width: 1000, height: 120,fit: BoxFit.cover,),
                    Text(product["title"]),
                    Text(product["subtitle"]),
                    Text(product["price"]),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
