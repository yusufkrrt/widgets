import 'package:get/get.dart';
import 'button_controller.dart';

class ButtonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ButtonController>(() => ButtonController());
  }
}
// Seçim Widget'ları:
// ◦
// Checkbox: Onay kutusu.
// ◦
// Radio / RadioListTile: Çoktan tekli seçim.
// ◦
// Switch: Açık/kapalı anahtarı.
// ◦
// Slider: Bir aralıkta değer seçimi.
// 2.
// Liste ve Kaydırma Widget'ları:
// ◦
// ListView: Alt alta sıralı listeler için.
// ◦
// GridView: Izgara görünümü (örneğin galeri gibi).
// ◦
// SingleChildScrollView: Küçük ekranlarda taşmayı önlemek için.
// 3.
// Görsel ve Bilgi Widget'ları:
// ◦
// Image: İnternetten (Image.network) veya yerelden (Image.asset) resim göstermek.
// ◦
// Card: Panel/kart görünümü oluşturmak.
// ◦
// Icon: Hazır sistem ikonlarını kullanmak.
// 4.
// Etkileşim ve Geri Bildirim:
// ◦
// DropdownButton: Açılır liste.
// ◦
// InkWell / GestureDetector: Herhangi bir widget'ı tıklanabilir yapmak.
// ◦
// SnackBar: Ekranın altında kısa süreli bilgi mesajı.
// ◦
// AlertDialog: Onay veya uyarı pencereleri.
// 5.
// Düzen (Layout) Widget'ları:
// ◦
// Stack: Widget'ları üst üste bindirmek.
// ◦
// Container: Dekorasyon, kenarlık ve gölge işlemleri.
// Hangi widget ile devam etmek istersiniz? İsterseniz yeni bir modül (örneğin selection_widgets veya list_example) oluşturup kodlarını beraber yazabiliriz.

/*
  // 1. Örnek: AnimatedContainer (Boyut ve Renk Değişimi)
  Widget _buildImplicitAnimation() => Column(
    children: [
      const Text(
        "1. AnimatedContainer (Tıkla Değişsin)",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      GestureDetector(
        onTap: () => controller.toggleBox(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutBack, // Hareketin ivmesi
          width: controller.isExpanded.value ? 200 : 100,
          height: controller.isExpanded.value ? 100 : 100,
          decoration: BoxDecoration(
            color: controller.isExpanded.value ? Colors.orange : Colors.blue,
            borderRadius: BorderRadius.circular(
              controller.isExpanded.value ? 50 : 10,
            ),
            boxShadow: [
              BoxShadow(
                color: controller.isExpanded.value
                    ? Colors.orange.withOpacity(0.4)
                    : Colors.transparent,
                blurRadius: controller.isExpanded.value ? 10 : 0,
              ),
            ],
          ),
          child: const Center(
            child: Icon(Icons.touch_app, color: Colors.white),
          ),
        ),
      ),
    ],
  );

  // 2. Örnek: AnimatedOpacity (Görünürlük Animasyonu)
  Widget _buildOpacityAnimation() => Column(
    children: [
      const Text(
        "2. AnimatedOpacity",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      AnimatedOpacity(
        opacity: controller.isVisible.value ? 1.0 : 0.0,
        duration: const Duration(seconds: 1),
        child: const Card(
          color: Colors.green,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Yavaşça Kayboluyorum",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      ElevatedButton(
        onPressed: () => controller.toggleVisibility(),
        child: const Text("Göster / Gizle"),
      ),
    ],
  );

  // 3. Örnek: AnimatedAlign (Konum Animasyonu)
  Widget _buildAlignmentAnimation() => Column(
    children: [
      const Text(
        "3. AnimatedAlign",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      Container(
        height: 120,
        width: double.infinity,
        color: Colors.grey.shade200,
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 400),
          alignment: controller.isExpanded.value
              ? Alignment.bottomRight
              : Alignment.topLeft,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(backgroundColor: Colors.red, radius: 20),
          ),
        ),
      ),
      TextButton(
        onPressed: () => controller.toggleBox(),
        child: const Text("Yer Değiştir"),
      ),
    ],
  );

*/