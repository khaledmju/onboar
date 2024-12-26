import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoritesController extends GetxController {
  var favoriteProducts = <Map<String, dynamic>>[].obs;

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
}
