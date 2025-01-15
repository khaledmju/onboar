
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onboar/ProductDetailsPage.dart';
import 'FavoritesController.dart';

class FavoritesPage extends StatelessWidget {
  final FavoritesController favoritesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite Products".tr,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 66, 252, 169),
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (favoritesController.favoriteProducts.isEmpty) {
          return Center(child: Text("No favorite products yet!".tr));
        }
        return GridView.builder(
          itemCount: favoritesController.favoriteProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 220),
          itemBuilder: (context, index) {
            final product = favoritesController.favoriteProducts[index];
            final productId = product["id"];

            return FutureBuilder<Uint8List?>(
              future: favoritesController.fetchProductImage(productId), // Future<Uint8List?>
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Loading state
                }
                if (snapshot.hasError) {
                  return Image.asset(
                    'images/prod.png',
                    width: 100,
                    height: 120,
                    fit: BoxFit.cover,
                  ); // Error fallback image
                }

                Uint8List? imageBytes = snapshot.data;

                return InkWell(
                  onTap: () {
                    Get.to(() => ProductDetailsPage(
                      productData: favoritesController.favoriteProducts[index],
                      productImage: imageBytes,
                    ));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        imageBytes != null
                            ? Image.memory(
                          imageBytes,
                          height: 150,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'images/prod.png',
                              width: 100,
                              height: 120,
                              fit: BoxFit.cover,
                            );
                          },
                        )
                            : Image.asset(
                          'images/prod.png',
                          width: 1000,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          favoritesController.favoriteProducts[index]["name"] ?? "Unnamed",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}
