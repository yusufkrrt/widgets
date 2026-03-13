import 'package:ogrenme/app/core/core.dart';
import 'widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

class AnimationsScreen extends GetView<AnimationsController> {
  const AnimationsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: ColorConstants.backgroundColor,
    appBar: AppBarWidget(
      context: context,
      titleWidget: const Text('Animasyon Örnekleri'),
    ),
    body: Obx(
      () => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  //_buildImplicitAnimation(),
                  //const Divider(height: 40),
                  //_buildOpacityAnimation(),
                  //const Divider(height: 40),
                  //_buildAlignmentAnimation(),
                  _myAnimation(),
                  const Divider(height: 40),
                  CustomAnimationWidget(),
                  const Divider(height: 40),
                  const WaterFlowAnimation(),
                  const Divider(height: 40),
                  const BouncingBallAnimation(),
                  const Divider(height: 40),
                  const Text("Sürüklenebilir ve Zıplayan Top", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 220, // Hareket alanı için geniş bir alan tanıyalım
                    child: DraggableBouncingBall(),
                  ),
                  const Divider(height: 40),

                ],
              ),
            ),
    ),
  );
  Widget _myAnimation() => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Animated Container"),
      SizedBox(height: 8),
      GestureDetector(
        onTap: () => controller.toggleBox(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          width: controller.isExpanded.value?220:100,
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
}
