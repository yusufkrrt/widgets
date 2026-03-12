import 'package:ogrenme/app/core/core.dart';
import 'package:ogrenme/app/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CanonScreen extends GetView<CanonController> {
  const CanonScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        appBar: AppBarWidget(
          context: context,
          titleWidget: const Text('Canon'),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : const Center(child: Text('Canon')),
        ),
      );
}
