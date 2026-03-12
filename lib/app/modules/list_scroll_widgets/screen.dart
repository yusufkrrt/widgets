import 'package:ogrenme/app/core/core.dart';
import 'package:ogrenme/app/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListScrollWidgetsScreen extends GetView<ListScrollWidgetsController> {
  const ListScrollWidgetsScreen({super.key});

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: ColorConstants.backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text('Liste ve Kaydırma'),
            bottom: const TabBar(
              labelColor: ColorConstants.primary,
              unselectedLabelColor: ColorConstants.textSecondary,
              indicatorColor: ColorConstants.primary,
              tabs: [
                Tab(icon: Icon(Icons.list), text: 'ListView'),
                Tab(icon: Icon(Icons.grid_view), text: 'GridView'),
                Tab(icon: Icon(Icons.swap_vert), text: 'ScrollView'),
              ],
            ),
          ),
          body: Obx(
            () => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                    children: [
                      _ListViewTab(controller: controller),
                      _GridViewTab(controller: controller),
                      const _SingleChildScrollViewTab(),
                    ],
                  ),
          ),
        ),
      );
}

// ─── ListView Tab ────────────────────────────────────────────────────────────
class _ListViewTab extends StatelessWidget {
  const _ListViewTab({required this.controller});
  final ListScrollWidgetsController controller;

  @override
  Widget build(BuildContext context) => Obx(
        () => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.listItems.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final item = controller.listItems[index];
            return Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: ColorConstants.primary.withOpacity(0.1),
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: ColorConstants.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(item, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text('Alt başlık – sıra $index'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Get.snackbar(
                    item,
                    '$item seçildi',
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 1),
                  );
                },
              ),
            );
          },
        ),
      );
}

// ─── GridView Tab ────────────────────────────────────────────────────────────
class _GridViewTab extends StatelessWidget {
  const _GridViewTab({required this.controller});
  final ListScrollWidgetsController controller;

  @override
  Widget build(BuildContext context) => Obx(
        () => GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.0,
          ),
          itemCount: controller.gridItems.length,
          itemBuilder: (context, index) {
            final item = controller.gridItems[index];
            final colors = [
              const Color(0xFF6366F1),
              const Color(0xFF10B981),
              const Color(0xFFF59E0B),
              const Color(0xFFEC4899),
              const Color(0xFF3B82F6),
              const Color(0xFF8B5CF6),
            ];
            final color = colors[index % colors.length];

            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Get.snackbar(
                    item,
                    '$item tıklandı',
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 1),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.image_rounded, color: color, size: 32),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
}

// ─── SingleChildScrollView Tab ───────────────────────────────────────────────
class _SingleChildScrollViewTab extends StatelessWidget {
  const _SingleChildScrollViewTab();

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _infoCard(
              'SingleChildScrollView',
              'Küçük ekranlarda taşmayı önlemek için kullanılır. '
                  'İçerik ekrandan büyükse kaydırılabilir hale gelir.',
              Icons.swap_vert_rounded,
              const Color(0xFF3B82F6),
            ),
            const SizedBox(height: 16),
            _infoCard(
              'ListView',
              'Alt alta sıralı listeler oluşturmak için kullanılır. '
                  'Büyük listelerde lazy loading ile performanslı çalışır.',
              Icons.list_rounded,
              const Color(0xFF10B981),
            ),
            const SizedBox(height: 16),
            _infoCard(
              'GridView',
              'Öğeleri ızgara (grid) düzeninde görüntüler. '
                  'Fotoğraf galerisi gibi yapılar için idealdir.',
              Icons.grid_view_rounded,
              const Color(0xFFF59E0B),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorConstants.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ne Zaman Hangisi?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _bulletPoint('Basit, az öğeli içerik → SingleChildScrollView'),
                  _bulletPoint('Uzun, dinamik listeler → ListView.builder'),
                  _bulletPoint('Galeri / kart grid → GridView.builder'),
                  _bulletPoint('Karışık layout → CustomScrollView + Slivers'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorConstants.primary.withOpacity(0.8),
                    ColorConstants.primary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  'Bu alan kaydırma alanının\nsonunu gösterir 👇',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _infoCard(String title, String desc, IconData icon, Color color) =>
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: const TextStyle(
                      fontSize: 13,
                      color: ColorConstants.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _bulletPoint(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('• ', style: TextStyle(fontSize: 16, color: ColorConstants.primary)),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  color: ColorConstants.textPrimary,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      );
}
