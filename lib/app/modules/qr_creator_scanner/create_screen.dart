import 'dart:io';
import 'dart:ui' as ui;
import 'package:barcode_widget/barcode_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';


import 'package:flutter/material.dart';
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
    backgroundColor: Colors.black,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: controller.goBack,
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
      ),
      title: const Text(
        'Oluştur',
        style: TextStyle(color: Colors.white),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Ne oluşturmak istersiniz?',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 24),
          CreateTypeCard(
            icon: Icons.qr_code_2_outlined,
            label: 'QR Kod',
            subtitle: 'URL, metin veya iletişim bilgisi',
            color: Colors.white,
            onTap: () => Get.to(() => const QrGeneratorScreen()),
          ),
          const SizedBox(height: 16),
          CreateTypeCard(
            icon: Icons.barcode_reader,
            label: 'Barkod',
            subtitle: 'EAN-13, Code128 formatları',
            color: Colors.blue.shade400,
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
        backgroundColor: Colors.green.shade400,
        colorText: Colors.white,
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
      title: const Text('QR Kod Oluştur',
          style: TextStyle(color: Colors.white)),
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
                          ? Colors.white
                          : Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    child: Text(
                      _types[i],
                      style: TextStyle(
                        color: _selectedType == i
                            ? Colors.black
                            : Colors.white,
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
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
              border:
              Border.all(color: Colors.white.withOpacity(0.15)),
            ),
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: _hint,
                hintStyle:
                TextStyle(color: Colors.white.withOpacity(0.3)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear,
                      color: Colors.white.withOpacity(0.4), size: 18),
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
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: QrImageView(
                    data: _qrData,
                    version: QrVersions.auto,
                    size: 200,
                    backgroundColor: Colors.white,
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
                      foregroundColor: Colors.white,
                      side: BorderSide(
                          color: Colors.white.withOpacity(0.3)),
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
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
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
        backgroundColor: Colors.green.shade400,
        colorText: Colors.white,
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
                          ? Colors.blue.shade400
                          : Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.blue.shade400.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      _formats[i].$1,
                      style: TextStyle(
                        color: _selectedFormat == i
                            ? Colors.white
                            : Colors.white.withOpacity(0.7),
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
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.15)),
            ),
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              keyboardType: _formats[_selectedFormat].$1.contains('EAN')
                  ? TextInputType.number
                  : TextInputType.text,
              decoration: InputDecoration(
                hintText: _formats[_selectedFormat].$1.contains('EAN')
                    ? 'Sadece rakam girin'
                    : 'Barkod içeriğini girin',
                hintStyle:
                TextStyle(color: Colors.white.withOpacity(0.3)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear,
                      color: Colors.white.withOpacity(0.4), size: 18),
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
              backgroundColor: Colors.blue.shade400,
              foregroundColor: Colors.white,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: BarcodeWidget(
                    barcode: _formats[_selectedFormat].$2,
                    data: _barcodeData,
                    width: 240,
                    height: 100,
                    color: Colors.black,
                    backgroundColor: Colors.white,
                    errorBuilder: (_, error) => Text(
                      'Geçersiz veri: $error',
                      style: const TextStyle(
                          color: Colors.red, fontSize: 12),
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
                backgroundColor: Colors.blue.shade400,
                foregroundColor: Colors.white,
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