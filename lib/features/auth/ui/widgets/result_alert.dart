import 'package:flutter/material.dart';

void showResultAlert(
  BuildContext context, {
  required IconData icon,
  required Color iconColor,
  required String title,
  required String subtitle,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Cerrar',
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 150),
    pageBuilder: (_, __, ___) => ResultAlert(
      icon: icon,
      iconColor: iconColor,
      title: title,
      subtitle: subtitle,
    ),
    transitionBuilder: (_, animation, __, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutBack,
      );
      return ScaleTransition(
        scale: curved,
        child: FadeTransition(opacity: animation, child: child),
      );
    },
  );
}

class ResultAlert extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const ResultAlert({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  State<ResultAlert> createState() => _ResultAlertState();
}

class _ResultAlertState extends State<ResultAlert>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.iconColor;

    return GestureDetector(
      onTap: () {},
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 300,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.18),
                  blurRadius: 40,
                  spreadRadius: 2,
                  offset: const Offset(0, 12),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Ícono animado
                AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) => Opacity(
                    opacity: _opacity.value,
                    child: Transform.scale(
                      scale: _scale.value,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: color.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Icon(widget.icon, color: color, size: 44),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Título
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 10),

                // Subtítulo
                Text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
