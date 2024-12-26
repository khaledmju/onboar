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

        return ListView.builder(
          itemCount: favoritesController.favoriteProducts.length,
          itemBuilder: (context, index) {
            final product = favoritesController.favoriteProducts[index];
            return ListTile(
              leading: Image.asset(product["image"], width: 50, height: 50),
              title: Text(product["title"]),
              subtitle: Text(product["subtitle"]),
              trailing: Text(product["price"]),
              onTap: () {
                // Navigate to product details page or perform other actions
                Get.to(() => ProductDetailsPage(productData: product));
              },
            );
          },
        );
      }),
    );
  }
}
