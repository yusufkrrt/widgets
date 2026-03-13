import 'package:flutter/material.dart';

class BouncingBallAnimation extends StatefulWidget {
  const BouncingBallAnimation({Key? key}) : super(key: key);

  @override
  State<BouncingBallAnimation> createState() => _BouncingBallAnimationState();
}

class _BouncingBallAnimationState extends State<BouncingBallAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _shadowSize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800), // Hızı biraz artırdık
      vsync: this,
    )..repeat(reverse: true);

    // Topun yüksekliği (0 ile 100 arası gidip gelir)
    _animation = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(
        parent: _controller,
        // Yer çekimi hissi için inişte hızlanan, çıkışta yavaşlayan bir eğri
        curve: Curves.easeInOutSine,
      ),
    );

    // Top yere yaklaştıkça gölgenin büyümesini sağlar
    _shadowSize = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180, // Yüksekliği artırdık ki top ve gölge rahat sığsın
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Yerdeki Gölge
              Positioned(
                bottom: 20,
                child: Opacity(
                  opacity: _shadowSize.value / 2, // Uzaklaştıkça şeffaflaşır
                  child: Container(
                    width: 40 * _shadowSize.value, // Uzaklaştıkça küçülür
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
                ),
              ),
              // Zıplayan Top
              Positioned(
                top: _animation.value, // Sadece 0-100 arası hareket eder
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Colors.redAccent, Colors.red.shade900],
                      center: const Alignment(-0.3, -0.3),
                    ),
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