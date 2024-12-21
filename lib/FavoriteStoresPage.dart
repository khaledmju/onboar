// ignore_for_file: file_names, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ProductsPage.dart';
import 'local/local_controller.dart';

class FavoriteStoresPage extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteStores;

  const FavoriteStoresPage({super.key, required this.favoriteStores});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Stores".tr),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 66, 252, 169),
      ),
      body: favoriteStores.isEmpty
          ? Center(
            child: Text(
              "No favorite stores yet!".tr,
              style: const TextStyle(fontSize: 18, color: Colors.red),
            ),
          )
          : ListView.builder(
              itemCount: favoriteStores.length,
              itemBuilder: (context, index) {
                final store = favoriteStores[index];
                return InkWell(
                  onTap: () => Get.to(const ProductsPage()),
                  child: Card(
                    child: ListTile(
                      leading: Image.asset(
                        store['image'],
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(store['title']),
                      subtitle: Text(store['subtitle']),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
