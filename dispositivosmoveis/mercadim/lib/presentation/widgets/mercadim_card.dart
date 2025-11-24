// presentation/widgets/mercadim_card.dart
import 'package:flutter/material.dart';

class MercadimCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color? color;
  final double elevation;
  final VoidCallback? onTap;

  const MercadimCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.margin = const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
    this.color,
    this.elevation = 2,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material(
        color: color ?? Colors.white,
        elevation: elevation,
        surfaceTintColor: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
