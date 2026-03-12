import 'package:ogrenme/app/core/core.dart';
import 'package:ogrenme/app/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogrenme/app/routes/app_paths.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        appBar: AppBarWidget(
          context: context,
          titleWidget: const Text('Ana Sayfa'),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {},
            ),
          ],
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.primary,
                  ),
                )
              : RefreshIndicator(
                  color: ColorConstants.primary,
                  onRefresh: controller.refresh,
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      _buildWelcomeCard(),
                      const SizedBox(height: 32),
                      const _QuickActionsGrid(),
                    ],
                  ),
                ),
        ),
      );

  Widget _buildWelcomeCard() => Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorConstants.primary,
                  ColorConstants.primary.withBlue(200),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.primary.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white24, width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person_rounded, color: ColorConstants.primary, size: 32),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hoş geldiniz 👋',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Obx(
                        () => Text(
                          controller.username.value,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -20,
            top: -20,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white.withOpacity(0.05),
            ),
          ),
        ],
      );
}

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid();

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 20),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: ColorConstants.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Hızlı İşlemler',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.textPrimary,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.0,
            children: [
              _ActionCard(
                icon: Icons.smart_button_rounded,
                label: 'Butonlar',
                color: const Color(0xFF6366F1),
                description: 'Çeşitli buton tipleri',
                onTap: () => Get.toNamed(AppPaths.button),
              ),
              _ActionCard(
                icon: Icons.text_fields_rounded,
                label: 'Metinler',
                color: const Color(0xFF10B981),
                description: 'Yazı stilleri',
                onTap: () => Get.toNamed(AppPaths.text),
              ),
              _ActionCard(
                icon: Icons.edit_note_rounded,
                label: 'Giriş Alanları',
                color: const Color(0xFFF59E0B),
                description: 'Veri giriş formları',
                onTap: () => Get.toNamed(AppPaths.textfield),
              ),
              _ActionCard(
                icon: Icons.checklist_rtl_rounded,
                label: 'Seçimler',
                color: const Color(0xFFEC4899),
                description: 'Checkbox ve Switch',
                onTap: () => Get.toNamed(AppPaths.choose_wigdets),
              ),
              _ActionCard(
                icon: Icons.view_list_rounded,
                label: 'Liste & Kaydırma',
                color: const Color(0xFF3B82F6),
                description: 'ListView, GridView, Scroll',
                onTap: () => Get.toNamed(AppPaths.list_scroll_widgets),
              ),
            ],
          ),
        ],
      );
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.description,
    this.onTap,
  });

  final VoidCallback? onTap;
  final IconData icon;
  final String label;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: color.withOpacity(0.1),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 32),
                ),
                const SizedBox(height: 12),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: ColorConstants.textPrimary.withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
