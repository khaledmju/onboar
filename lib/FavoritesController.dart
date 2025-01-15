import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'main.dart';

class FavoritesController extends GetxController {
  var favoriteProducts = <Map<String, dynamic>>[].obs;

  Future<Uint8List?> fetchProductImage(int productId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token'); // Retrieve the token

      if (token == null) {
        print("Token not found");
        return null;
      }

      final response = await get(
        Uri.parse('http://127.0.0.1:8000/api/getproductimage/$productId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return response.bodyBytes; // Ensure this returns Uint8List?
      } else {
        print('Failed to load image for product $productId: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching image: $e');
      return null;
    }
  }


  void toggleFavorite(Map<String, dynamic> product) async {
    if (isFavorite(product)) {
      favoriteProducts.removeWhere((fav) => mapEquals(fav, product));
    } else {
      favoriteProducts.add(product);
    }
    await saveFavorites();
  }

  bool isFavorite(Map<String, dynamic> product) {
    return favoriteProducts.any((fav) => mapEquals(fav, product));
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteList = favoriteProducts.map((product) => jsonEncode(product)).toList();
    await prefs.setStringList('favorites', favoriteList);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getStringList('favorites');
    if (savedData != null) {
      favoriteProducts.value = savedData.map((item) => jsonDecode(item) as Map<String, dynamic>).toList();
    }
  }
  Future<void> clearFavorites() async {
    favoriteProducts.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('favorites');
  }
}
