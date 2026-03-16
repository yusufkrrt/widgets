import 'package:ogrenme/app/core/core.dart';
import 'package:ogrenme/app/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/line_chart_widget.dart';
import 'widgets/bar_chart_widget.dart';
import 'widgets/pie_chart_widget.dart';

class GraphsStaticsScreen extends GetView<GraphsStaticsController> {
  const GraphsStaticsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        appBar: AppBarWidget(
          context: context,
          titleWidget: const Text('İstatistikler ve Grafikler'),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: const [
                    LineChartWidget(),
                    SizedBox(height: 20),
                    BarChartWidget(),
                    SizedBox(height: 20),
                    PieChartWidget(),
                    SizedBox(height: 20),
                  ],
                ),
        ),
      );
}
