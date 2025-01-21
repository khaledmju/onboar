
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
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text("Favorite Products".tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color.fromARGB(255, 20, 54, 64),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 66, 252, 169),
        elevation: 4,
        shadowColor: const Color.fromARGB(255, 48, 193, 152),
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (favoritesController.favoriteProducts.isEmpty) {
          return Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No favorite products yet!".tr,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              Image.asset("images/noFav.png",height: 240,),
            ],
          ));
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
