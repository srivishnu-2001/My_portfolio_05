import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../data.dart';
import '../utils/launcher.dart';
import '../widgets/glass_card.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});
  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late final AnimationController _entryCtrl;
  late final AnimationController _floatCtrl;

  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  late final Animation<double> _avatarFade;
  late final Animation<Offset> _avatarSlide;

  @override
  void initState() {
    super.initState();

    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _fade = CurvedAnimation(
      parent: _entryCtrl,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    );
    _slide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _entryCtrl,
            curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
          ),
        );

    _avatarFade = CurvedAnimation(
      parent: _entryCtrl,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
    );
    _avatarSlide = Tween<Offset>(begin: const Offset(0.08, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _entryCtrl,
            curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _entryCtrl.forward();
    });
  }

  @override
  void dispose() {
    _entryCtrl.dispose();
    _floatCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 750;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 60,
        vertical: isMobile ? 50 : 90,
      ),
      child: isMobile ? _buildMobileLayout(dark) : _buildDesktopLayout(dark),
    );
  }

  Widget _buildDesktopLayout(bool dark) => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(flex: 6, child: _buildTextBlock(dark)),
      const SizedBox(width: 60),
      Expanded(flex: 4, child: _buildAvatarBlock()),
    ],
  );

  Widget _buildMobileLayout(bool dark) => Column(
    children: [
      _buildAvatarBlock(),
      const SizedBox(height: 40),
      _buildTextBlock(dark),
    ],
  );

  // ── Text block ────────────────────────────────────────────────────────────
  Widget _buildTextBlock(bool dark) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // "Available for Work" badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.teal.withOpacity(0.15),
                    AppColors.violet.withOpacity(0.10),
                  ],
                ),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: AppColors.teal.withOpacity(0.4),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.teal,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Available for Work',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.teal,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // Name
            Text(
              PortfolioData.name,
              style: AppTextStyles.heroName(dark).copyWith(fontSize: 44),
            ),
            const SizedBox(height: 12),

            // Title
            Text(
              PortfolioData.title.toUpperCase(),
              style: AppTextStyles.heroTitle(dark),
            ),
            const SizedBox(height: 22),

            // Typing tagline
            Row(
              children: [
                const Text(
                  '› ',
                  style: TextStyle(
                    color: AppColors.teal,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: PortfolioData.taglines
                        .map(
                          (t) => TyperAnimatedText(
                            t,
                            textStyle: TextStyle(
                              fontSize: 15,
                              color: dark
                                  ? AppColors.textMutedOnDark
                                  : AppColors.textMutedOnLight,
                              height: 1.4,
                            ),
                            speed: const Duration(milliseconds: 55),
                          ),
                        )
                        .toList(),
                    repeatForever: true,
                    pause: const Duration(seconds: 2),
                    displayFullTextOnTap: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 26),

            // Bio
            Text(PortfolioData.summary, style: AppTextStyles.heroBio(dark)),
            const SizedBox(height: 32),

            // ── Tappable contact chips ────────────────────────────────────
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _ContactChip(
                  icon: Icons.email_outlined,
                  label: PortfolioData.email,
                  tooltip: 'Send Email',
                  onTap: () => launchEmail(context),
                  dark: dark,
                ),
                _ContactChip(
                  icon: Icons.phone_outlined,
                  label: PortfolioData.phone,
                  tooltip: 'Call Me',
                  onTap: () => launchPhone(context),
                  dark: dark,
                ),
                _ContactChip(
                  icon: Icons.location_on_outlined,
                  label: PortfolioData.location,
                  tooltip: 'Location',
                  onTap: null, // location is not tappable
                  dark: dark,
                ),
              ],
            ),
            const SizedBox(height: 28),

            // ── LinkedIn badge ────────────────────────────────────────────
            _LinkedInBadge(onTap: () => launchLinkedIn(context)),
            const SizedBox(height: 32),

            // CTA buttons
            Wrap(
              spacing: 14,
              runSpacing: 12,
              children: [
                GradientButton(
                  label: 'Download CV',
                  icon: Icons.download_rounded,
                  onTap: () {},
                ),
                GradientButton(
                  label: 'Contact Me',
                  icon: Icons.mail_outline_rounded,
                  outlined: true,
                  onTap: () => launchEmail(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Avatar block ──────────────────────────────────────────────────────────
  Widget _buildAvatarBlock() {
    return FadeTransition(
      opacity: _avatarFade,
      child: SlideTransition(
        position: _avatarSlide,
        child: AnimatedBuilder(
          animation: _floatCtrl,
          builder: (ctx, child) => Transform.translate(
            offset: Offset(0, -10 * _floatCtrl.value),
            child: child,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer glow
              Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.teal.withOpacity(0.20),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              // Rotating dashed ring
              _RotatingBorder(size: 220),
              // Profile photo
              Container(
                width: 190,
                height: 190,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.teal, AppColors.violet],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.teal.withOpacity(0.35),
                      blurRadius: 40,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(4),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/Picsart_26-02-02_20-46-02-512.jpg.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tappable contact chip
// ─────────────────────────────────────────────────────────────────────────────
class _ContactChip extends StatefulWidget {
  final IconData icon;
  final String label;
  final String tooltip;
  final VoidCallback? onTap;
  final bool dark;

  const _ContactChip({
    required this.icon,
    required this.label,
    required this.tooltip,
    required this.onTap,
    required this.dark,
  });

  @override
  State<_ContactChip> createState() => __ContactChipState();
}

class __ContactChipState extends State<_ContactChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final canTap = widget.onTap != null;
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: canTap ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: (_) {
          if (canTap) setState(() => _hovered = true);
        },
        onExit: (_) {
          if (canTap) setState(() => _hovered = false);
        },
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: _hovered
                  ? AppColors.teal.withOpacity(0.12)
                  : (widget.dark
                        ? Colors.white.withOpacity(0.05)
                        : Colors.black.withOpacity(0.04)),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: _hovered
                    ? AppColors.teal.withOpacity(0.5)
                    : (widget.dark
                          ? Colors.white24
                          : Colors.black.withOpacity(0.12)),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.icon,
                  size: 14,
                  color: _hovered ? AppColors.teal : AppColors.teal,
                ),
                const SizedBox(width: 7),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 12,
                    color: _hovered
                        ? AppColors.teal
                        : (widget.dark
                              ? AppColors.textMutedOnDark
                              : AppColors.textMutedOnLight),
                    fontWeight: _hovered ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                if (canTap) ...[
                  const SizedBox(width: 4),
                  Icon(
                    Icons.open_in_new_rounded,
                    size: 10,
                    color: _hovered
                        ? AppColors.teal
                        : (widget.dark
                              ? AppColors.textMutedOnDark
                              : AppColors.textMutedOnLight),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// LinkedIn badge
// ─────────────────────────────────────────────────────────────────────────────
class _LinkedInBadge extends StatefulWidget {
  final VoidCallback onTap;
  const _LinkedInBadge({required this.onTap});

  @override
  State<_LinkedInBadge> createState() => __LinkedInBadgeState();
}

class __LinkedInBadgeState extends State<_LinkedInBadge> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered
                ? const Color(0xFF0A66C2).withOpacity(0.15)
                : const Color(0xFF0A66C2).withOpacity(0.08),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: _hovered
                  ? const Color(0xFF0A66C2).withOpacity(0.8)
                  : const Color(0xFF0A66C2).withOpacity(0.35),
              width: 1.3,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: const Color(0xFF0A66C2).withOpacity(0.25),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // LinkedIn "in" logo rendered with text
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: _hovered
                      ? const Color(0xFF0A66C2)
                      : const Color(0xFF0A66C2).withOpacity(0.80),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Center(
                  child: Text(
                    'in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      height: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Connect on LinkedIn',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _hovered
                      ? const Color(0xFF0A66C2)
                      : const Color(0xFF0A66C2).withOpacity(0.80),
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.open_in_new_rounded,
                size: 12,
                color: _hovered
                    ? const Color(0xFF0A66C2)
                    : const Color(0xFF0A66C2).withOpacity(0.60),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Rotating dashed border ring around avatar
// ─────────────────────────────────────────────────────────────────────────────
class _RotatingBorder extends StatefulWidget {
  final double size;
  const _RotatingBorder({required this.size});
  @override
  State<_RotatingBorder> createState() => __RotatingBorderState();
}

class __RotatingBorderState extends State<_RotatingBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Transform.rotate(
        angle: _ctrl.value * 2 * 3.14159,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.teal.withOpacity(0.35),
              width: 1.5,
            ),
          ),
          child: CustomPaint(painter: _DashedCirclePainter()),
        ),
      ),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.violet.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;
    const dashCount = 20;
    const dashAngle = 2 * 3.14159 / dashCount;
    for (int i = 0; i < dashCount; i += 2) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        dashAngle * i,
        dashAngle * 0.6,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
