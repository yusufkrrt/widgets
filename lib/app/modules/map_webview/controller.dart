import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class MapWebviewController extends GetxController {
  final isLoading = false.obs;
  final center = const LatLng(39.925533, 32.866287).obs;
  var polylines = <Polyline>[].obs;
  final zoom = 13.0.obs;
  final selectedLayerIndex = 0.obs;
  final searchController = TextEditingController();
  var markers = <CustomMarker>[].obs;

  // Değişkeni doğrudan başlatıyoruz (Late initialization hatasını önler)
  final WebViewController webViewController = WebViewController();

  @override
  void onInit() {
    super.onInit();
    _setupWebView();
    _load();
  }

  void _setupWebView() {
    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse('https://www.openstreetmap.org'));
  }

  Future<void> searchAndGo(String query) async {
    if (query.trim().isEmpty) return;
    
    final url = Uri.parse('https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(query)}&format=json&limit=1');
    try {
      final response = await http.get(url, headers: {'User-Agent': 'ogrenme-app'});
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        if (data.isNotEmpty) {
          final lat = double.tryParse(data[0]['lat'] ?? '');
          final lon = double.tryParse(data[0]['lon'] ?? '');
          if (lat != null && lon != null) {
            center.value = LatLng(lat, lon);
            zoom.value = 15.0;
            
            webViewController.loadRequest(
              Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lon')
            );
          }
        }
      }
    } catch (e) {
      print("Search error: $e");
    }
  }

  Future<void> _load() async {
    try {
      isLoading.value = true;
      await Future<void>.delayed(const Duration(milliseconds: 200));
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void openFavoritesPanel() {}
  void onMarkerTap(m) {}
  void addMarker(LatLng point) {
    markers.add(CustomMarker(position: point));
  }
}

class CustomMarker {
  final LatLng position;
  final IconData? icon;
  final Color? color;
  CustomMarker({required this.position, this.icon, this.color});
}
