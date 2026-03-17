import 'package:flutter/material.dart';
import 'package:ogrenme/app/core/constants/color.dart';
import 'package:ogrenme/app/core/constants/text_style.dart';
import 'package:get/get.dart';

import '../../core/widgets/app_bar.dart';
import 'controller.dart';
import 'create_screen.dart';
import 'scan_screen.dart';

class QrCreatorScannerScreen extends GetView<QrCreatorScannerController> {
  const QrCreatorScannerScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Obx(() {
      switch (controller.mode.value) {
        case ScannerMode.scan:
          return const ScanScreen();
        case ScannerMode.create:
          return const CreateScreen();
        case ScannerMode.none:
          return _buildHome(context);
      }
    }),
  );

  Widget _buildHome(BuildContext context) => Scaffold(
    backgroundColor: ColorConstants.backgroundColor,

    appBar: AppBarWidget(
      context: context,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF6B7280)),
      ),
      titleWidget: Text("Scanner - Create"),
    ),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),

            // Logo / başlık
            const Icon(
              Icons.qr_code_scanner_outlined,
              color: ColorConstants.cardPrimary,
              size: 72,
            ),
            const SizedBox(height: 24),
            Text(
              'QR & Barkod',
              textAlign: TextAlign.center,
              style: TextStyleConstants.heading1.copyWith(color: ColorConstants.textPrimary),
            ),
            const SizedBox(height: 8),
            Text(
              'Ne yapmak istersiniz?',
              textAlign: TextAlign.center,
              style: TextStyleConstants.body.copyWith(color: ColorConstants.textSecondary),
            ),

            const Spacer(),

            // Okut butonu
              _ModeButton(
              icon: Icons.document_scanner_outlined,
              label: 'Okut',
              subtitle: 'QR kod veya barkod tara',
              color:  ColorConstants.primary,
              onTap: controller.goScan,
            ),
            const SizedBox(height: 16),

            // Oluştur butonu
              _ModeButton(
              icon: Icons.add_box_outlined,
              label: 'Oluştur',
              subtitle: 'QR kod veya barkod oluştur',
              color: ColorConstants.primary,
              onTap: controller.goCreate,
            ),

            const Spacer(),
          ],
        ),
      ),
    ),
  );
}

class _ModeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ModeButton({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
    this.color = ColorConstants.cardBackground,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(20),
        color: color.withOpacity(0.08),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyleConstants.heading2.copyWith(color: color, fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyleConstants.caption.copyWith(color: color.withOpacity(0.55), fontSize: 13),
              ),
            ],
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: color.withOpacity(0.4),
            size: 16,
          ),
        ],
      ),
    ),
  );
}