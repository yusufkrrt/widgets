import 'package:flutter/material.dart';

class GraphData {
  static final List<SalesData> lineChartData = [
    SalesData('Oca', 35),
    SalesData('Şub', 28),
    SalesData('Mar', 45),
    SalesData('Nis', 32),
    SalesData('May', 48),
    SalesData('Haz', 40),
  ];

  static final List<SalesData> barChartData = [
    SalesData('Pzt', 12),
    SalesData('Sal', 18),
    SalesData('Çar', 25),
    SalesData('Per', 15),
    SalesData('Cum', 22),
    SalesData('Cmt', 30),
    SalesData('Paz', 10),
  ];

  static final List<PieData> pieChartData = [
    PieData('Gıda', 40, Colors.blue),
    PieData('Ulaşım', 20, Colors.red),
    PieData('Eğlence', 15, Colors.green),
    PieData('Kira', 25, Colors.orange),
  ];
}

class SalesData {
  final String label;
  final double value;
  SalesData(this.label, this.value);
}

class PieData {
  final String category;
  final double percentage;
  final Color color;
  PieData(this.category, this.percentage, this.color);
}
