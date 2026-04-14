import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../data.dart';
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

    // Slight delay before animating in
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

  Widget _buildDesktopLayout(bool dark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 6, child: _buildTextBlock(dark)),
        const SizedBox(width: 60),
        Expanded(flex: 4, child: _buildAvatarBlock()),
      ],
    );
  }

  Widget _buildMobileLayout(bool dark) {
    return Column(
      children: [
        _buildAvatarBlock(),
        const SizedBox(height: 40),
        _buildTextBlock(dark),
      ],
    );
  }

  Widget _buildTextBlock(bool dark) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label badge
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
                  Text(
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

            // Typing animation tagline
            Row(
              children: [
                Text(
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
            const SizedBox(height: 36),

            // Contact info row
            _buildContactRow(dark),
            const SizedBox(height: 36),

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
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(bool dark) {
    return Wrap(
      spacing: 20,
      runSpacing: 8,
      children: [
        _contactChip(Icons.email_outlined, PortfolioData.email, dark),
        _contactChip(Icons.phone_outlined, PortfolioData.phone, dark),
        _contactChip(Icons.location_on_outlined, PortfolioData.location, dark),
      ],
    );
  }

  Widget _contactChip(IconData icon, String text, bool dark) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: AppColors.teal),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: dark
                ? AppColors.textMutedOnDark
                : AppColors.textMutedOnLight,
          ),
        ),
      ],
    );
  }

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
              // Glow ring
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
              // Rotating border
              _RotatingBorder(size: 220),
              // Profile picture
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

// Slowly rotating dashed ring around the avatar
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
      final start = dashAngle * i;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        start,
        dashAngle * 0.6,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
