import 'package:flutter/material.dart';
import 'dart:math';

class WaterFlowAnimation extends StatefulWidget {
  const WaterFlowAnimation({Key? key}) : super(key: key);

  @override
  State<WaterFlowAnimation> createState() => _WaterFlowAnimationState();
}

class _WaterFlowAnimationState extends State<WaterFlowAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    // _animation build içinde oluşturulacak
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    _animation ??= Tween<double>(begin: -100, end: screenWidth + 100).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    return SizedBox(
      height: 80,
      child: AnimatedBuilder(
        animation: _animation ?? _controller,
        builder: (context, child) {
          final left = _animation?.value ?? -100;
          final radians = left / 80;
          final wave = 20 * (sin(radians));
          final top = 20 + wave;
          return Stack(
            children: [
              Positioned(
                left: left,
                top: top,
                child: SizedBox(
                  width: 100,
                  height: 40,
                  child: CustomPaint(
                    painter: _WaterWavePainter(radians: radians),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
class _WaterWavePainter extends CustomPainter {
  final double radians;
  _WaterWavePainter({required this.radians});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.blue.shade300, Colors.blue.shade700],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();

    // Üst kenar dalgası
    path.moveTo(0, 10 * sin(radians)); // Başlangıç noktası
    for (double x = 0; x <= size.width; x += 2) {
      final y = 10 * sin(radians + x / 15);
      path.lineTo(x, y);
    }

    // Sağ kenardan aşağı in (Kıvrımlı alt sınıra geçiş)
    // size.height ekleyerek dalgayı aşağıya taşıyoruz
    path.lineTo(size.width, size.height + 10 * sin(radians + size.width / 15));

    // Alt kenar dalgası (Geriye doğru çiziyoruz)
    for (double x = size.width; x >= 0; x -= 2) {
      final y = size.height + 10 * sin(radians + x / 15);
      path.lineTo(x, y);
    }

    path.close(); // Yolu kapat (Sol kenarı otomatik birleştirir)

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WaterWavePainter oldDelegate) {
    return oldDelegate.radians != radians;
  }
}
