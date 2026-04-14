import 'package:flutter/material.dart';
import '../constants.dart';

/// Glassmorphism card used throughout the portfolio.
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? borderColor;
  final double elevation;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 18,
    this.borderColor,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final border = borderColor ??
        (dark ? AppColors.darkBorder : AppColors.lightBorder);
    final bg = dark
        ? AppColors.darkCard.withOpacity(0.75)
        : AppColors.lightCard.withOpacity(0.85);

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: border, width: 1),
        boxShadow: [
          BoxShadow(
            color: dark
                ? Colors.black.withOpacity(0.35)
                : Colors.black.withOpacity(0.07),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }
}

/// Hover-lift card – lifts and glows on mouse-over.
class HoverCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const HoverCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 18,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
        decoration: BoxDecoration(
          color: dark
              ? AppColors.darkCard.withOpacity(_hovered ? 0.9 : 0.75)
              : AppColors.lightCard,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: _hovered
                ? AppColors.teal.withOpacity(0.5)
                : (dark ? AppColors.darkBorder : AppColors.lightBorder),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? AppColors.teal.withOpacity(dark ? 0.2 : 0.12)
                  : Colors.black.withOpacity(dark ? 0.3 : 0.07),
              blurRadius: _hovered ? 32 : 16,
              offset: Offset(0, _hovered ? 12 : 6),
            ),
          ],
        ),
        child: Padding(
          padding: widget.padding ?? const EdgeInsets.all(20),
          child: widget.child,
        ),
      ),
    );
  }
}

/// Gradient text helper
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText(
    this.text, {
    super.key,
    required this.style,
    this.gradient = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

/// Animated gradient CTA button
class GradientButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool outlined;

  const GradientButton({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.outlined = false,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    if (widget.outlined) {
      return MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit:  (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColors.teal, width: 1.5),
            color: _hovered ? AppColors.teal.withOpacity(0.1) : Colors.transparent,
          ),
          child: _buildInner(),
        ),
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_hovered ? 1.04 : 1.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: AppColors.primary,
          borderRadius: BorderRadius.circular(50),
          boxShadow: _hovered
              ? [BoxShadow(color: AppColors.teal.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 8))]
              : [],
        ),
        child: _buildInner(),
      ),
    );
  }

  Widget _buildInner() {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(50),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null) ...[
              Icon(widget.icon,
                  size: 16,
                  color: widget.outlined ? AppColors.teal : Colors.white),
              const SizedBox(width: 8),
            ],
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: widget.outlined ? AppColors.teal : Colors.white,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Section header with gradient accent underline
class SectionHeader extends StatelessWidget {
  final String label;
  final String title;
  final bool dark;

  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    required this.dark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 28,
              height: 2,
              decoration: BoxDecoration(
                gradient: AppColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.teal,
                letterSpacing: 2.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(title, style: AppTextStyles.sectionTitle(dark)),
        const SizedBox(height: 6),
        Container(
          width: 48,
          height: 3,
          decoration: BoxDecoration(
            gradient: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}
