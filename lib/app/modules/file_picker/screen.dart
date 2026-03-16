import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

class FilePickerScreen extends GetView<FilePickerController> {
  const FilePickerScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Dosya Seçici'),
      actions: [
        Obx(
              () => controller.pickedFiles.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.delete_sweep_outlined),
            onPressed: controller.clearFiles,
            tooltip: 'Tümünü Temizle',
          )
              : const SizedBox.shrink(),
        ),
      ],
    ),
    body: Column(
      children: [
        _buildPickerButtons(),
        Expanded(child: _buildFileList()),
      ],
    ),
  );

  Widget _buildPickerButtons() => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        Expanded(
          child: Obx(
                () => ElevatedButton.icon(
              onPressed:
              controller.isLoading.value ? null : controller.pickFiles,
              icon: const Icon(Icons.folder_open_outlined),
              label: const Text('Dosya Seç'),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Obx(
                () => OutlinedButton.icon(
              onPressed: controller.isLoading.value
                  ? null
                  : controller.pickImages,
              icon: const Icon(Icons.image_outlined),
              label: const Text('Görsel Seç'),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildFileList() => Obx(
        () => controller.pickedFiles.isEmpty
        ? _buildEmptyState()
        : ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: controller.pickedFiles.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) =>
          _buildFileCard(controller.pickedFiles[i]),
    ),
  );

  Widget _buildEmptyState() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('📂', style: TextStyle(fontSize: 64)),
        const SizedBox(height: 16),
        Text(
          'Henüz dosya seçilmedi',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Yukarıdaki butonlarla dosya veya görsel seçebilirsiniz',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );

  Widget _buildFileCard(PlatformFile file) => Card(
    child: ListTile(
      leading: Text(
        controller.fileIcon(file.extension),
        style: const TextStyle(fontSize: 28),
      ),
      title: Text(
        file.name,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        controller.formatSize(file.size),
        style: const TextStyle(fontSize: 11),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.open_in_new_outlined, size: 20),
            onPressed: () => controller.openFile(file),
            tooltip: 'Aç',
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: () => controller.removeFile(file),
            tooltip: 'Kaldır',
          ),
        ],
      ),
    ),
  );
}