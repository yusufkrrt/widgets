import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/color.dart';
import '../../core/widgets/app_bar.dart';
import 'controller.dart';
import 'widgets/custom_widgets.dart';

class MapScreen extends GetView<MapWebviewController> {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.ensureLocationPermissionAndShowCurrent();
    });
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBarWidget(
        context: context,
        titleWidget: const Text('Genişletilmiş Map'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Column(
                  children: [
                    const TabBar(
                      tabs: [
                        Tab(text: 'Custom Maps'),
                        Tab(text: 'WebView Maps'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          // 1. Sekme: Map
                          Stack(
                            children: [
                              buildMap(),
                              buildSearchBar(),
                              buildLayerSelector(),
                              buildZoomControls(),
                              buildFavoritesButton(),
                              buildCurrentLocationButton(),
                            ],
                          ),
                          // 2. Sekme: WebView
                          buildWebViewMap(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
