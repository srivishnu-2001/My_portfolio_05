import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Wraps [child] and animates it (fade + slide-up) when it enters the viewport.
class AnimatedReveal extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double slideOffset;

  const AnimatedReveal({
    super.key,
    required this.child,
    this.delay    = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.slideOffset = 40,
  });

  @override
  State<AnimatedReveal> createState() => _AnimatedRevealState();
}

class _AnimatedRevealState extends State<AnimatedReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double>   _opacity;
  late final Animation<double>   _slide;

  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);

    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide   = Tween<double>(begin: widget.slideOffset, end: 0)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onVisibility(VisibilityInfo info) {
    if (!_triggered && info.visibleFraction > 0.08) {
      _triggered = true;
      Future.delayed(widget.delay, () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: widget.key ?? ValueKey(widget.hashCode),
      onVisibilityChanged: _onVisibility,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) => Opacity(
          opacity: _opacity.value,
          child: Transform.translate(
            offset: Offset(0, _slide.value),
            child: child,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
