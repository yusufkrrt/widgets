import 'package:ogrenme/app/core/core.dart';
import 'package:ogrenme/app/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisualInfoWidgetsScreen extends GetView<VisualInfoWidgetsController> {
  const VisualInfoWidgetsScreen({super.key});

  @override
    Widget build(BuildContext context) => Scaffold(
          backgroundColor: ColorConstants.backgroundColor,
          appBar: AppBarWidget(
            context: context,
            titleWidget: const Text('Görsel ve Bilgi Widgetları'),
          ),
          body: Obx(
            () => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Image.network (internet resmi):'),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            spacing: 24, // Her resim arasına 12 piksel boşluk ekler
                            children: [
                              Image.network(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUNW8dW07JGbshEXik-2NFrPh97nydfal7vQ&s',
                                height: 100,
                              ),
                              Image.network(
                                'https://img.freepik.com/free-photo/fuji-mountain-kawaguchiko-lake-morning-autumn-seasons-fuji-mountain-yamanachi-japan_335224-102.jpg?semt=ais_rp_progressive&w=740&q=80',
                                height: 100,
                              ),
                              Image.network(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_U85omYQhhV3gBPSVlLd52e3IIIyU5NHyJA&s',
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text('Image.asset (yerel resim):'),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal, // Yatayda kaydırmayı sağlar
                          child: Row(
                            spacing: 24,
                            children: [
                              Image.asset(
                                'assets/images/sample.jpg',
                                height: 100,
                              ),
                              Image.asset(
                                'assets/images/sample2.jpg',
                                height: 100,
                              ),
                              Image.asset(
                                'assets/images/sample3.jpg',
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text('Card Örnekleri (Yatay Kaydırılabilir):'),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal, // Yatayda kaydırmayı sağlar
                          child: Row(
                            spacing: 16, // Kartlar arasındaki boşluk
                            children: [
                              SizedBox(
                                width: 150,
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      Image.network('https://picsum.photos/200', height: 100, width: double.infinity, fit: BoxFit.cover),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Resimli Kart", style: TextStyle(fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // 2. Basit Card
                              Card(
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text('Basit Card'),
                                ),
                              ),
                              // 3. Outlined Card
                              SizedBox(
                                width: 150,
                                child: Card(
                                  elevation: 0,
                                  margin: EdgeInsets.all(4),
                                  color: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.blue, width: 1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Text("Modern Outlined", textAlign: TextAlign.center),
                                  ),
                                ),
                              ),
                              // 4. Tıklanabilir Card
                              Card(
                                elevation: 3,
                                color: Colors.orange.shade50,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(4),
                                  onTap: () => Get.snackbar("Bilgi", "Karta tıklandı!"),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                    child: Text("Tıklanabilir\nInkWell"),
                                  ),
                                ),
                              ),
                              // 5. Renkli Card
                              Card(
                                elevation: 2,
                                color: const Color(0xffac6868),
                                child: const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Text("data", style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              // 6. Vurgulu Card
                              Card(
                                clipBehavior: Clip.antiAlias,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.red, width: 5)),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: const Text("Vurgulu Kart"),
                                ),
                              ),
                              SizedBox(
                                width: 300, // veya uygun bir genişlik
                                child: Card(
                                  elevation: 4,
                                  child: ListTile(
                                    leading: Icon(Icons.info, color: Colors.blue),
                                    title: Text("Bilgi Kartı"),
                                    subtitle: Text("Bu kartta ikon ve açıklama var."),
                                  ),
                                ),
                              ),
                              // 7. Yuvarlak/Dairemsi Card
                              Card(
                                elevation: 4,
                                shape: const CircleBorder(), // Daha temiz bir yuvarlak için
                                clipBehavior: Clip.antiAlias,
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  alignment: Alignment.center,
                                  color: Colors.blueAccent,
                                  child: const Text(
                                    "Daire",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: Card(
                                  elevation: 2,// 1. Köşeleri yuvarlatıyoruz
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  // 2. İçerideki gradient'ın bu köşelere uyması için kesiyoruz
                                  clipBehavior: Clip.antiAlias,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.purple, Colors.deepPurpleAccent],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: const Center(
                                      child: Text(
                                          "Gradient Card",
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: Card(
                                  elevation: 4,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage('https://randomuser.me/api/portraits/women/44.jpg'),
                                    ),
                                    title: Text("Avatar Kartı"),
                                    subtitle: Text("Profil resmi ile kart."),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text('Icon örneği:'),
                        const SizedBox(height: 8),
                        Row(
                          children: const [
                            Icon(Icons.star, color: Colors.amber, size: 32),
                            SizedBox(width: 8),
                            Icon(Icons.favorite, color: Colors.red, size: 32),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text('CircleAvatar örneği:'),
                        const SizedBox(height: 8),
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: NetworkImage(
                            'https://randomuser.me/api/portraits/men/1.jpg',
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
}
