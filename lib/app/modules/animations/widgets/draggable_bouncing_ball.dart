import 'package:flutter/material.dart';

class DraggableBouncingBall extends StatefulWidget {
  const DraggableBouncingBall({Key? key}) : super(key: key);

  @override
  State<DraggableBouncingBall> createState() => _DraggableBouncingBallState();
}

class _DraggableBouncingBallState extends State<DraggableBouncingBall>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  Offset _dragOffset = const Offset(100, 50);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
    _bounceAnimation = Tween<double>(begin: 0, end: 120).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              _dragOffset += details.delta;
            });
          },
          child: Stack(
            children: [
              Positioned(
                left: _dragOffset.dx,
                top: _dragOffset.dy + _bounceAnimation.value,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [Colors.redAccent, Colors.red.shade900],
                          center: const Alignment(-0.3, -0.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.drag_indicator,
                          color: Colors.white70,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Tut ve Çek",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}