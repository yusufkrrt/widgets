import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controller.dart';
import 'package:flutter/material.dart';

final MapWebviewController controller = Get.find();

// ------------------ MAP (LOCAL) ------------------
Widget buildMap() {
  return Obx(() {
    final center = controller.center.value;
    final zoom = controller.zoom.value;
    final selectedLayer = controller.selectedLayerIndex.value;

    final baseLayers = [
      {
        'name': 'OSM',
        'url': 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
        'subdomains': ['a', 'b', 'c']
      },
      {
        'name': 'CartoDB',
        'url': 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
        'subdomains': ['a', 'b', 'c']
      },
      {
        'name': 'CyclOSM',
        'url': 'https://{s}.tile-cyclosm.openstreetmap.fr/cyclosm/{z}/{x}/{y}.png',
        'subdomains': ['a', 'b', 'c']
      },
      {
        'name': 'Shortbread',
        'url': 'https://tiles.stadiamaps.com/tiles/stamen_shortbread/{z}/{x}/{y}.png',
        'subdomains': ['a', 'b', 'c']
      },
      {
        'name': 'Tracestrack',
        'url': 'https://tile.tracestrack.com/carto/{z}/{x}/{y}.png',
        'subdomains': ['a', 'b', 'c']
      }
    ];

    return FlutterMap(
      options: MapOptions(
        initialCenter: center,
        initialZoom: zoom,
        onTap: (tapPosition, point) {
          controller.addMarker(point);
        },
      ),
      children: [
        TileLayer(
          urlTemplate: baseLayers[selectedLayer]['url'] as String,
          subdomains: baseLayers[selectedLayer]['subdomains'] as List<String>,
          userAgentPackageName: 'com.example.ogrenme',
        ),
        MarkerLayer(
          markers: controller.markers
              .map(
                (m) => Marker(
                  point: m.position,
                  width: 80,
                  height: 80,
                  child: GestureDetector(
                    onTap: () => controller.onMarkerTap(m),
                    child: Icon(
                      m.icon ?? Icons.location_on,
                      color: m.color ?? Colors.red,
                      size: 40,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        PolylineLayer(
          polylines: controller.polylines,
        ),
      ],
    );
  });
}

// ------------------ MAP (WEBVIEW) ------------------
Widget buildWebViewMap() {
  return Obx(() {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }
    // WebViewController'ın yüklediği sayfa gösterilecek
    return WebViewWidget(controller: controller.webViewController);
  });
}

// ------------------ ARAMA ------------------
Widget buildSearchBar() {
  return Positioned(
    top: 16,
    left: 16,
    right: 16,
    child: Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller.searchController,
                decoration: const InputDecoration(
                  hintText: 'Adres veya yer ara',
                  border: InputBorder.none,
                  isDense: true,
                ),
                onSubmitted: (value) async => controller.searchAndGo(value),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () =>
                  controller.searchAndGo(controller.searchController!.text),
            ),
          ],
        ),
      ),
    ),
  );
}

// ------------------ KATMAN SEÇİCİ ------------------
Widget buildLayerSelector() {
  return Positioned(
    top: 80,
    right: 16,
    child: Card(
      elevation: 4,
      child: Obx(() {
        final selectedLayer = controller.selectedLayerIndex.value;
        final baseLayers = ['OSM', 'CartoDB','CyclOSM','Shortbread','Tracestrack'];
        return DropdownButton<int>(
          value: selectedLayer,
          underline: const SizedBox(),
          items: List.generate(
            baseLayers.length,
            (i) => DropdownMenuItem(value: i, child: Text(baseLayers[i])),
          ),
          onChanged: (i) {
            if (i != null) controller.selectedLayerIndex.value = i;
          },
        );
      }),
    ),
  );
}

// ------------------ ZOOM KONTROLLERİ ------------------
Widget buildZoomControls() {
  return Positioned(
    bottom: 32,
    right: 16,
    child: Column(
      children: [
        FloatingActionButton(
          heroTag: 'zoom_in',
          mini: true,
          child: const Icon(Icons.add),
          onPressed: () => controller.zoom.value += 1,
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          heroTag: 'zoom_out',
          mini: true,
          child: const Icon(Icons.remove),
          onPressed: () => controller.zoom.value -= 1,
        ),
      ],
    ),
  );
}

// ------------------ FAVORİ MARKER BUTONU ------------------
Widget buildFavoritesButton() {
  return Positioned(
    bottom: 32,
    left: 16,
    child: FloatingActionButton(
      heroTag: 'favorites',
      mini: true,
      child: const Icon(Icons.star),
      onPressed: () => controller.openFavoritesPanel(),
    ),
  );
}

// ------------------ MEVCUT KONUMA GİT BUTONU ------------------
Widget buildCurrentLocationButton() {
  return Positioned(
    bottom: 100,
    right: 80, // Zoom butonlarından sola kaydırıldı
    child: FloatingActionButton(
      heroTag: 'current_location',
      mini: true,
      child: const Icon(Icons.my_location),
      onPressed: () {
         //controller.ensureLocationPermissionAndShowCurrent(force: true);
         Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((pos) {
           final lat = pos.latitude;
           final lon = pos.longitude;
           if (lat != null && lon != null) {
             controller.center.value = LatLng(lat, lon);
             controller.zoom.value = 16.0;
             controller.addMarker(LatLng(lat, lon));
           }
         }).catchError((e) {
           Get.snackbar('Hata', 'Konum alınırken hata oluştu: $e');
         });
         },
      tooltip: 'Mevcut Konuma Git',
    ),
  );
}
