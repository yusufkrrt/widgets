import 'package:ogrenme/app/core/core.dart';
import 'package:ogrenme/app/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogrenme/app/routes/app_paths.dart';

import '../../core/widgets/action_card.dart';

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
                      const SizedBox(height: 16),
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
                  'Oluşturulan Widgetler',
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
            crossAxisCount: SizeConfig.isTablet(context) ? 3 : SizeConfig.isMobile(context)?2:4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.0,
            children: [
              ActionCard(
                icon: Icons.smart_button_rounded,
                label: 'Butonlar',
                color: const Color(0xFF6366F1),
                description: 'Çeşitli buton tipleri',
                onTap: () => Get.toNamed(AppPaths.button),
              ),
              ActionCard(
                icon: Icons.text_fields_rounded,
                label: 'Metinler',
                color: const Color(0xFF287E5F),
                description: 'Yazı stilleri',
                onTap: () => Get.toNamed(AppPaths.text),
              ),
              ActionCard(
                icon: Icons.edit_note_rounded,
                label: 'Giriş Alanları',
                color: const Color(0xFFF59E0B),
                description: 'Veri giriş formları',
                onTap: () => Get.toNamed(AppPaths.textfield),
              ),
              ActionCard(
                icon: Icons.checklist_rtl_rounded,
                label: 'Seçimler',
                color: const Color(0xFFEC4899),
                description: 'Checkbox ve Switch',
                onTap: () => Get.toNamed(AppPaths.choose_wigdets),
              ),
              ActionCard(
                icon: Icons.view_list_rounded,
                label: 'Liste & Kaydırma',
                color: const Color(0xFF3B82F6),
                description: 'ListView, GridView, Scroll',
                onTap: () => Get.toNamed(AppPaths.list_scroll_widgets),
              ),
              ActionCard(
                  icon: Icons.visibility_rounded,
                  label: 'Görsel & Bilgi',
                  color: const Color(0xFFFA3663),
                  description: "Image, card, icon, avatar",
                  onTap: () => Get.toNamed(AppPaths.visual_info_widgets),
              ),
              ActionCard(
                icon: Icons.animation,
                label: 'Animasyon',
                color: const Color(0xFF2FAE88),
                description: 'Animasyon denemeleri',
                onTap: () => Get.toNamed(AppPaths.animations),
              ),
              ActionCard(
                icon: Icons.twenty_three_mp_rounded,
                label: 'Playground',
                color: const Color(0xFF29C34F),
                description: 'Widgets of the week denemeleri',
                onTap:()=>Get.toNamed(AppPaths.playground)
              ),
              ActionCard(
                  icon: Icons.bar_chart,
                  label: 'Data visualation',
                  color: const Color(0xFF9F30ED),
                  description: 'Veri görselleştirme chat grafik',
                  onTap:()=>Get.toNamed(AppPaths.graphs_statics)
              ),
              ActionCard(
                  icon: Icons.calendar_month,
                  label: 'Days Weeks',
                  color: const Color(0xFF317B91),
                  description: 'Tarih seçici ve takvim',
                  onTap:()=>Get.toNamed(AppPaths.datepicker_calendar)
              ),
              ActionCard(
                  icon: Icons.map_sharp,
                  label: 'Maps&WebView',
                  color: const Color(0xFF7EE4FF),
                  description: 'Mapler ve webview kullanımı',
                  onTap:()=>Get.toNamed(AppPaths.map_webview)
              ),
              ActionCard(
                  icon: Icons.folder,
                  label: 'File Picker',
                  color: const Color(0xFFAF8D3A),
                  description: 'Dosya fotoğraf vs seçme',
                  onTap:()=>Get.toNamed(AppPaths.file_picker)
              ),
              ActionCard(
                  icon: Icons.qr_code,
                  label: 'Scanner',
                  color: const Color(0xFF423595),
                  description: 'QR/Barkod oluştur ve okut.',
                  onTap:()=>Get.toNamed(AppPaths.qr_creator_scanner)
              ),
            ],
          ),
        ],
      );
}


