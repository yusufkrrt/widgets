
import 'package:ogrenme/app/core/constants/color.dart';
import 'package:ogrenme/app/core/constants/text_style.dart';
import 'package:ogrenme/app/core/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/services.dart';
import 'controller.dart';
import 'widgets/custom_widget.dart';

class ScanScreen extends GetView<QrCreatorScannerController> {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: ColorConstants.backgroundColor,
    appBar: AppBarWidget(
      context: context,
      leading: IconButton(
        onPressed: controller.goBack,
        icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF6B7280)),
      ),
      titleWidget: Text('Tara', style: TextStyleConstants.heading2.copyWith(color: ColorConstants.textPrimary)),
      actions: [
        IconButton(
          onPressed: controller.toggleFlash,
          icon: const Icon(Icons.flash_on_outlined),
          // color parametresi yok, iconTheme ile AppBar'dan alınır
        ),
        IconButton(
          onPressed: controller.switchCamera,
          icon: const Icon(Icons.flip_camera_ios_outlined),
        ),
      ],
    ),
    body: Stack(
      children: [
        MobileScanner(
          controller: controller.scannerController,
          onDetect: controller.onDetect,
        ),
        const ScannerOverlay(),

        // Sonuç kartı
        Obx(
          () => controller.lastScannedCode.value.isNotEmpty
              ? Positioned(
                  bottom: 40,
                  left: 24,
                  right: 24,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ColorConstants.cardBackground,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstants.primaryLight,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            controller.lastScannedType.value,
                            style: TextStyleConstants.body.copyWith(color: ColorConstants.primary, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            controller.lastScannedCode.value,
                            style: TextStyleConstants.body.copyWith(color: ColorConstants.textPrimary, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy),
                          // color parametresi yok, iconTheme ile alınır
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: controller.lastScannedCode.value));
                            Get.snackbar('Kopyalandı', 'Kod panoya kopyalandı', snackPosition: SnackPosition.BOTTOM);
                          },
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    ),
  );
}