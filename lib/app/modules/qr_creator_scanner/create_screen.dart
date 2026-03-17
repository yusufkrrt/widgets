import 'dart:io';
import 'dart:ui' as ui;
import 'package:barcode_widget/barcode_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';


import 'package:flutter/material.dart';
import 'package:ogrenme/app/core/constants/color.dart';
import 'package:ogrenme/app/core/constants/text_style.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'controller.dart';
import 'widgets/custom_widget.dart';

enum CreateType { qr, barcode }

class CreateScreen extends GetView<QrCreatorScannerController> {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: ColorConstants.backgroundColor,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: controller.goBack,
        icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF6B7280)),
      ),
      title: Text(
        'Oluştur',
        style: TextStyleConstants.heading2.copyWith(color: ColorConstants.textPrimary),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Ne oluşturmak istersiniz?',
            style: TextStyleConstants.body.copyWith(color: ColorConstants.textSecondary),
          ),
          const SizedBox(height: 24),
          CreateTypeCard(
            icon: Icons.qr_code_2_outlined,
            label: 'QR Kod',
            subtitle: 'URL, metin veya iletişim bilgisi',
            color: ColorConstants.cardSecondary,
            onTap: () => Get.to(() => const QrGeneratorScreen()),
          ),
          const SizedBox(height: 16),
          CreateTypeCard(
            icon: Icons.barcode_reader,
            label: 'Barkod',
            subtitle: 'EAN-13, Code128 formatları',
            color: ColorConstants.cardSecondary,
            onTap: () => Get.to(() => const BarcodeGeneratorScreen()),
          ),
        ],
      ),
    ),
  );
}

class QrGeneratorScreen extends StatefulWidget {
  const QrGeneratorScreen({super.key});

  @override
  State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  final _controller = TextEditingController();
  final _repaintKey = GlobalKey();
  String _qrData = '';

  final _types = ['URL', 'Metin', 'E-posta', 'Telefon'];
  int _selectedType = 0;

  String get _hint => switch (_selectedType) {
    0 => 'https://example.com',
    1 => 'Buraya metin yazın',
    2 => 'ornek@email.com',
    3 => '+90 555 000 00 00',
    _ => ''
  };

  String get _prefix => switch (_selectedType) {
    2 => 'mailto:',
    3 => 'tel:',
    _ => ''
  };

  void _generate() {
    if (_controller.text.trim().isEmpty) return;
    setState(() => _qrData = '$_prefix${_controller.text.trim()}');
    FocusScope.of(context).unfocus();
  }

  Future<void> _saveToGallery() async {
    try {
      final boundary = _repaintKey.currentContext!.findRenderObject()
      as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/qr_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes);

      await ImageGallerySaverPlus.saveFile(file.path);
      Get.snackbar(
        'Kaydedildi',
        'QR kod galeriye kaydedildi',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorConstants.success,
        colorText: ColorConstants.cardBackground,
      );
    } catch (e) {
      Get.snackbar('Hata', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: ColorConstants.backgroundColor,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: Get.back,
        icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF6B7280)),
      ),
      title: Text('QR Kod Oluştur', style: TextStyleConstants.heading2.copyWith(color: ColorConstants.textPrimary)),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Tip seçici
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                _types.length,
                    (i) => GestureDetector(
                  onTap: () => setState(() {
                    _selectedType = i;
                    _controller.clear();
                    _qrData = '';
                  }),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: _selectedType == i
                          ? ColorConstants.cardBackground
                          : ColorConstants.cardBackground.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: ColorConstants.cardBackground.withOpacity(0.2),
                      ),
                    ),
                    child: Text(
                      _types[i],
                      style: TextStyleConstants.body.copyWith(
                        color: _selectedType == i ? ColorConstants.textPrimary : ColorConstants.textSecondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Input
          Container(
            decoration: BoxDecoration(
              color: ColorConstants.cardBackground.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
              border:
              Border.all(color: ColorConstants.cardBackground.withOpacity(0.15)),
            ),
            child: TextField(
              controller: _controller,
              style: TextStyleConstants.body.copyWith(color: ColorConstants.textPrimary),
              decoration: InputDecoration(
                hintText: _hint,
                hintStyle:
                TextStyleConstants.caption.copyWith(color: ColorConstants.textSecondary.withOpacity(0.6)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear,
                      color: ColorConstants.textSecondary.withOpacity(0.6), size: 18),
                  onPressed: () {
                    _controller.clear();
                    setState(() => _qrData = '');
                  },
                ),
              ),
              onSubmitted: (_) => _generate(),
            ),
          ),
          const SizedBox(height: 12),

          // Oluştur butonu
          ElevatedButton(
            onPressed: _generate,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.cardBackground,
              foregroundColor: ColorConstants.textPrimary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text('Oluştur',
                style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 32),

          // QR önizleme
          if (_qrData.isNotEmpty) ...[
            Center(
              child: RepaintBoundary(
                key: _repaintKey,
                  child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: ColorConstants.cardBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: QrImageView(
                    data: _qrData,
                    version: QrVersions.auto,
                    size: 200,
                    backgroundColor: ColorConstants.cardBackground,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: _qrData));
                      Get.snackbar('Kopyalandı', 'Metin panoya kopyalandı',
                          snackPosition: SnackPosition.BOTTOM);
                    },
                    icon: const Icon(Icons.copy_outlined, size: 16),
                    label: const Text('Metni Kopyala'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: ColorConstants.textPrimary,
                              side: BorderSide(
                                  color: ColorConstants.cardBackground.withOpacity(0.3)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _saveToGallery,
                    icon: const Icon(Icons.download_outlined, size: 16),
                    label: const Text('Galeriye Kaydet'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.cardBackground,
                      foregroundColor: ColorConstants.textPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    ),
  );
}

class BarcodeGeneratorScreen extends StatefulWidget {
  const BarcodeGeneratorScreen({super.key});

  @override
  State<BarcodeGeneratorScreen> createState() => _BarcodeGeneratorScreenState();
}

class _BarcodeGeneratorScreenState extends State<BarcodeGeneratorScreen> {
  final _controller = TextEditingController();
  final _repaintKey = GlobalKey();
  String _barcodeData = '';

  final _formats = [
    ('Code 128', Barcode.code128()),
    ('EAN-13', Barcode.ean13()),
    ('EAN-8', Barcode.ean8()),
    ('QR', Barcode.qrCode()),
    ('PDF417', Barcode.pdf417()),
  ];
  int _selectedFormat = 0;

  void _generate() {
    if (_controller.text.trim().isEmpty) return;
    setState(() => _barcodeData = _controller.text.trim());
    FocusScope.of(context).unfocus();
  }

  Future<void> _saveToGallery() async {
    try {
      final boundary = _repaintKey.currentContext!.findRenderObject()
      as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3);
      final byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();

      final dir = await getTemporaryDirectory();
      final file = File(
          '${dir.path}/barcode_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes);

      await ImageGallerySaverPlus.saveFile(file.path);
      Get.snackbar(
        'Kaydedildi',
        'Barkod galeriye kaydedildi',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorConstants.success,
        colorText: ColorConstants.cardBackground,
      );
    } catch (e) {
      Get.snackbar('Hata', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: Get.back,
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
      ),
      title: const Text('Barkod Oluştur',
          style: TextStyle(color: Colors.white)),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                _formats.length,
                    (i) => GestureDetector(
                  onTap: () => setState(() {
                    _selectedFormat = i;
                    _barcodeData = '';
                  }),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: _selectedFormat == i
                          ? ColorConstants.primary
                          : ColorConstants.cardBackground.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: ColorConstants.primary.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      _formats[i].$1,
                      style: TextStyleConstants.body.copyWith(
                        color: _selectedFormat == i ? ColorConstants.cardBackground : ColorConstants.textSecondary.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: ColorConstants.cardBackground.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ColorConstants.cardBackground.withOpacity(0.15)),
            ),
            child: TextField(
              controller: _controller,
              style: TextStyleConstants.body.copyWith(color: ColorConstants.textPrimary),
              keyboardType: _formats[_selectedFormat].$1.contains('EAN')
                  ? TextInputType.number
                  : TextInputType.text,
              decoration: InputDecoration(
                hintText: _formats[_selectedFormat].$1.contains('EAN')
                    ? 'Sadece rakam girin'
                    : 'Barkod içeriğini girin',
                hintStyle:
                TextStyleConstants.caption.copyWith(color: ColorConstants.textSecondary.withOpacity(0.6)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear,
                      color: ColorConstants.textSecondary.withOpacity(0.6), size: 18),
                  onPressed: () {
                    _controller.clear();
                    setState(() => _barcodeData = '');
                  },
                ),
              ),
              onSubmitted: (_) => _generate(),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _generate,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.primary,
              foregroundColor: ColorConstants.cardBackground,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text('Oluştur',
                style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 32),
          if (_barcodeData.isNotEmpty) ...[
            Center(
              child: RepaintBoundary(
                key: _repaintKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                    color: ColorConstants.cardBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: BarcodeWidget(
                    barcode: _formats[_selectedFormat].$2,
                    data: _barcodeData,
                    width: 240,
                    height: 100,
                    color: ColorConstants.textPrimary,
                    backgroundColor: ColorConstants.cardBackground,
                    errorBuilder: (_, error) => Text(
                      'Geçersiz veri: $error',
                      style: TextStyleConstants.caption.copyWith(color: ColorConstants.error, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _saveToGallery,
              icon: const Icon(Icons.download_outlined, size: 16),
              label: const Text('Galeriye Kaydet'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.primary,
                foregroundColor: ColorConstants.cardBackground,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ],
      ),
    ),
  );
}