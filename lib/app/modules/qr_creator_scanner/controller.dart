import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

enum ScannerMode { none, scan, create }

class QrCreatorScannerController extends GetxController {
  final scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
  );

  final mode = ScannerMode.none.obs;
  final lastScannedCode = ''.obs;
  final lastScannedType = ''.obs;
  final isScanned = false.obs;
  final isLoading = false.obs;


  void goScan() => mode.value = ScannerMode.scan;
  void goCreate() => mode.value = ScannerMode.create;
  void goBack() => mode.value = ScannerMode.none;

  void onDetect(BarcodeCapture capture) {
    if (isScanned.value) return;
    final barcode = capture.barcodes.firstOrNull;
    if (barcode == null || barcode.rawValue == null) return;

    isScanned.value = true;
    lastScannedCode.value = barcode.rawValue!;
    lastScannedType.value = barcode.format.name.toUpperCase();

    HapticFeedback.mediumImpact();

    Future.delayed(const Duration(seconds: 3), () {
      isScanned.value = false;
    });
  }

  void toggleFlash() => scannerController.toggleTorch();
  void switchCamera() => scannerController.switchCamera();

  @override
  void onClose() {
    scannerController.dispose();
    super.onClose();
  }
}