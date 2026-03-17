import 'package:flutter/material.dart';
import 'package:ogrenme/app/core/constants/color.dart';
import 'package:ogrenme/app/core/constants/text_style.dart';

class ScannerOverlay extends StatefulWidget {
  const ScannerOverlay({super.key});

  @override
  State<ScannerOverlay> createState() => _ScannerOverlayState();
}

class _ScannerOverlayState extends State<ScannerOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const boxSize = 260.0;
    const cornerLength = 28.0;
    const cornerWidth = 4.0;
    const cornerRadius = 10.0;
    final cornerColor = ColorConstants.cardBackground;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Karartma katmanı (tarama kutusu dışı)
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.55),
            BlendMode.srcOut,
          ),
          child: Stack(
            children: [
              Container(decoration: BoxDecoration(color: ColorConstants.textPrimary.withOpacity(0.02))),
              Center(
                child: Container(
                  width: boxSize,
                  height: boxSize,
                  decoration: BoxDecoration(
                    color: ColorConstants.cardBackground,
                    borderRadius: BorderRadius.circular(cornerRadius),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Köşe çerçeveleri
        SizedBox(
          width: boxSize,
          height: boxSize,
          child: CustomPaint(
            painter: _CornerPainter(
              cornerLength: cornerLength,
              cornerWidth: cornerWidth,
              cornerRadius: cornerRadius,
              color: cornerColor,
            ),
          ),
        ),

        // Tarama çizgisi
        SizedBox(
          width: boxSize - 24,
          height: boxSize,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (_, __) => Align(
              alignment: Alignment(0, (_animation.value * 2) - 1),
                  child: Container(
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      ColorConstants.primary,
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),

        // Alt yazı
        Positioned(
          bottom: MediaQuery.of(context).size.height / 2 - boxSize / 2 - 48,
          child: Text(
            'QR kod veya barkodu çerçeve içine alın',
            style: TextStyleConstants.caption.copyWith(color: ColorConstants.textSecondary),
          ),
        ),
      ],
    );
  }
}

class _CornerPainter extends CustomPainter {
  final double cornerLength;
  final double cornerWidth;
  final double cornerRadius;
  final Color color;

  const _CornerPainter({
    required this.cornerLength,
    required this.cornerWidth,
    required this.cornerRadius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = cornerWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final corners = [
      // Sol üst
      [Offset(0, cornerLength), Offset.zero, Offset(cornerLength, 0)],
      // Sağ üst
      [
        Offset(size.width - cornerLength, 0),
        Offset(size.width, 0),
        Offset(size.width, cornerLength),
      ],
      // Sol alt
      [
        Offset(0, size.height - cornerLength),
        Offset(0, size.height),
        Offset(cornerLength, size.height),
      ],
      // Sağ alt
      [
        Offset(size.width - cornerLength, size.height),
        Offset(size.width, size.height),
        Offset(size.width, size.height - cornerLength),
      ],
    ];

    for (final corner in corners) {
      final path = Path()
        ..moveTo(corner[0].dx, corner[0].dy)
        ..lineTo(corner[1].dx, corner[1].dy)
        ..lineTo(corner[2].dx, corner[2].dy);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_CornerPainter old) => false;
}

class CreateTypeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const CreateTypeCard({super.key, required this.icon, required this.label, required this.subtitle, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(20),
        color: color.withOpacity(0.08),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: color.withOpacity(0.55),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: color.withOpacity(0.4),
            size: 16,
          ),
        ],
      ),
    ),
  );
}