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
          return  Center(child: Text("No favorite products yet!".tr));
        }
        return GridView.builder(
          itemCount: favoritesController.favoriteProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 220),
          itemBuilder: (context, index) {
            final product = favoritesController.favoriteProducts[index];
            final image = product["image"] ?? 'images/prod.png';
            final name = product["name"] ?? 'Unnamed Product';
            final price = product["price"]?.toString() ?? 'N/A';

            return InkWell(
              onTap: () {
                Get.to(() => ProductDetailsPage(productData: product));
              },
              child: Card(
                child: Column(
                  children: [
                    // Image.asset(product["image"], width: 1000, height: 120,fit: BoxFit.cover,),
                   SizedBox(height: 10,),
                    Image.asset(
                      image,
                      width: 1000,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'images/prod.png',
                          width: 1000,
                          height: 120,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    Text(name),
                    Text(price),
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
