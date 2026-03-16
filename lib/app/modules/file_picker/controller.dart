import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

class FilePickerController extends GetxController {
  final isLoading = false.obs;
  final pickedFiles = <PlatformFile>[].obs;
  final selectedFileIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  Future<void> openFile(PlatformFile file) async {
    if (file.path == null) return;
    await OpenFile.open(file.path!);
  }

  Future<void> pickFiles() async {
    try {
      isLoading.value=true;
      final result = await FilePicker.platform.pickFiles(allowMultiple: true,type: FileType.any);
      if(result!=null){
        pickedFiles.value=result.files;
      }
    }on Exception catch(e){
      Get.snackbar("HATA", "Dosya seçme sırasında hata oluştu",snackPosition: SnackPosition.BOTTOM);
    }
    finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImages() async {
    try {
      isLoading.value = true;
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
      );
      if (result != null) {
        pickedFiles.addAll(result.files);
      }
    } on Exception catch (e) {
      Get.snackbar('Hata', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void removeFile(PlatformFile file) => pickedFiles.remove(file);

  void clearFiles() => pickedFiles.clear();

  Future<void> _load() async {
    try {
      isLoading.value = true;
      // TODO: load data
    } on Exception catch (_) {
      // handle error
    } finally {
      isLoading.value = false;
    }
  }

  String formatSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  String fileIcon(String? extension) {
    switch (extension?.toLowerCase()) {
      case 'pdf': return '📄';
      case 'jpg': case 'jpeg': case 'png': case 'gif': return '🖼️';
      case 'mp4': case 'mov': case 'avi': return '🎬';
      case 'mp3': case 'wav': case 'aac': return '🎵';
      case 'doc': case 'docx': return '📝';
      case 'xls': case 'xlsx': return '📊';
      case 'zip': case 'rar': return '🗜️';
      default: return '📁';
    }
  }
}
