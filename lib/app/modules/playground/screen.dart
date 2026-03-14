import 'package:ogrenme/app/core/core.dart';
import 'package:ogrenme/app/modules/modules.dart';import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaygroundScreen extends GetView<PlaygroundController> {
  const PlaygroundScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: ColorConstants.backgroundColor,
    // Not: SliverAppBar kullandığımız için buradaki appBar'ı
    // daha temiz bir görüntü için null yapabilir veya sadece SliverAppBar kullanabilirsin.
    appBar: AppBarWidget(
      context: context,
      titleWidget: const Text('Playground'),
    ),
    body: Obx(
          () => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView( // <-- BURADAKİ 'Center' KALDIRILDI
        physics: const BouncingScrollPhysics(), // Daha akıcı bir kaydırma
        slivers: [
          // 1. Esnek bir başlık (SliverAppBar)
          SliverAppBar(
            expandedHeight: 200.0,
            collapsedHeight: 60.0,
            floating: false,
            pinned: true,
            backgroundColor: ColorConstants.primary,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text("Sliver Dünyası"),
              background: FlutterLogo(style: FlutterLogoStyle.markOnly,textColor: Colors.grey,),
              centerTitle: true,
            ),
          ),

          // 2. Bir liste (SliverList)
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => ListTile(
                title: Text("Eleman $index"),
                leading: CircleAvatar(child: Text("${index + 1}")),
              ),
              childCount: 10,
            ),
          ),

          // 3. Doğru Paddingli Izgara (SliverPadding + SliverGrid)
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: SizeConfig.isTablet(context) ? 3 : SizeConfig.isMobile(context) ? 2 : 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.0,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) => Card(
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      Get.snackbar("Bilgi", "Grid $index tıklandı!");
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.grid_view_rounded, color: Colors.blue),
                          const SizedBox(height: 8),
                          Text("Grid $index"),
                        ],
                      ),
                    ),
                  ),
                ),
                childCount: 12,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}