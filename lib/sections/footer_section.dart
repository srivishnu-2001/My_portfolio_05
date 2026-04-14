import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../constants.dart';
import '../data.dart';
import '../widgets/animated_reveal.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 750;

    return Column(
      children: [
        // CTA banner
        AnimatedReveal(
          child: _CtaBanner(dark: dark, isMobile: isMobile),
        ),
        // Footer body
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 60,
            vertical: 48,
          ),
          decoration: BoxDecoration(
            color: dark ? const Color(0xFF0A0A0A) : const Color(0xFF1A202C),
          ),
          child: Column(
            children: [
              isMobile ? _buildMobileFooter(dark) : _buildDesktopFooter(dark),
              const SizedBox(height: 40),
              const Divider(color: Colors.white12),
              const SizedBox(height: 20),
              _buildBottomBar(),
            ],
          ),
        ),
        // Scrolling marquee strip
        _MarqueeStrip(),
      ],
    );
  }

  Widget _buildDesktopFooter(bool dark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _buildBrandCol()),
        const SizedBox(width: 60),
        Expanded(flex: 2, child: _buildQuickLinks()),
        const SizedBox(width: 40),
        Expanded(flex: 3, child: _buildContactCol()),
      ],
    );
  }

  Widget _buildMobileFooter(bool dark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBrandCol(),
        const SizedBox(height: 36),
        _buildContactCol(),
      ],
    );
  }

  Widget _buildBrandCol() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo / name
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (b) => AppColors.primary.createShader(
            Rect.fromLTWH(0, 0, b.width, b.height),
          ),
          child: const Text(
            'Srivishnu\nThiriveedhi',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              height: 1.2,
              letterSpacing: -0.5,
            ),
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Flutter Developer crafting high-performance\nmobile experiences with clean, elegant code.',
          style: TextStyle(color: Colors.white60, fontSize: 13, height: 1.7),
        ),
        const SizedBox(height: 24),
        // Social icons
        Row(
          children: [
            _SocialIcon(icon: Icons.code, tooltip: 'GitHub', onTap: () {}),
            const SizedBox(width: 12),
            _SocialIcon(
              icon: Icons.work_outline,
              tooltip: 'LinkedIn',
              onTap: () {},
            ),
            const SizedBox(width: 12),
            _SocialIcon(
              icon: Icons.email_outlined,
              tooltip: 'Email',
              onTap: () {},
            ),
            const SizedBox(width: 12),
            _SocialIcon(
              icon: Icons.phone_outlined,
              tooltip: 'Phone',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickLinks() {
    const links = ['Home', 'About', 'Skills', 'Experience', 'Projects'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Links',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 18),
        ...links.map(
          (l) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _FooterLink(label: l),
          ),
        ),
      ],
    );
  }

  Widget _buildContactCol() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 18),
        _contactRow(Icons.email_outlined, PortfolioData.email),
        const SizedBox(height: 12),
        _contactRow(Icons.phone_outlined, PortfolioData.phone),
        const SizedBox(height: 12),
        _contactRow(Icons.location_on_outlined, PortfolioData.location),
      ],
    );
  }

  Widget _contactRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.teal),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white60, fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      runSpacing: 4,
      children: [
        const Text(
          '© 2026 Srivishnu Thiriveedhi • Built with',
          style: TextStyle(color: Colors.white38, fontSize: 12),
        ),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (b) => AppColors.primary.createShader(
            Rect.fromLTWH(0, 0, b.width, b.height),
          ),
          child: const Text(
            ' Flutter ',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ),
        const Text(
          '• All rights reserved',
          style: TextStyle(color: Colors.white38, fontSize: 12),
        ),
      ],
    );
  }
}

// ─── CTA Banner ───────────────────────────────────────────────────────────────
class _CtaBanner extends StatelessWidget {
  final bool dark, isMobile;
  const _CtaBanner({required this.dark, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 60,
        vertical: 60,
      ),
      padding: EdgeInsets.all(isMobile ? 28 : 48),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00838F), Color(0xFF006064), Color(0xFF4527A0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.teal.withOpacity(0.30),
            blurRadius: 50,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: isMobile ? _buildMobileContent() : _buildDesktopContent(),
    );
  }

  Widget _buildDesktopContent() {
    return Row(
      children: [
        Expanded(child: _buildText()),
        const SizedBox(width: 40),
        _buildButtons(),
      ],
    );
  }

  Widget _buildMobileContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildText(), const SizedBox(height: 28), _buildButtons()],
    );
  }

  Widget _buildText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Let's Work Together",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Have a project in mind? I'd love to hear about it and bring your idea to life.",
          style: TextStyle(
            color: Colors.white.withOpacity(0.75),
            fontSize: 14,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.mail_outline_rounded, size: 18),
          label: const Text('Send Email'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.tealDark,
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.download_rounded, size: 18),
          label: const Text('Download CV'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white54, width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

// ─── Social Icon ─────────────────────────────────────────────────────────────
class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  const _SocialIcon({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });
  @override
  State<_SocialIcon> createState() => __SocialIconState();
}

class __SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _hovered ? AppColors.teal : Colors.white.withOpacity(0.08),
              border: Border.all(
                color: _hovered ? AppColors.teal : Colors.white24,
                width: 1,
              ),
            ),
            child: Icon(
              widget.icon,
              size: 18,
              color: _hovered ? Colors.white : Colors.white60,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Footer Link ─────────────────────────────────────────────────────────────
class _FooterLink extends StatefulWidget {
  final String label;
  const _FooterLink({required this.label});
  @override
  State<_FooterLink> createState() => __FooterLinkState();
}

class __FooterLinkState extends State<_FooterLink> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: TextStyle(
          fontSize: 13,
          color: _hovered ? AppColors.teal : Colors.white54,
          fontWeight: _hovered ? FontWeight.w600 : FontWeight.normal,
        ),
        child: Text(widget.label),
      ),
    );
  }
}

// ─── Marquee Strip ───────────────────────────────────────────────────────────
class _MarqueeStrip extends StatelessWidget {
  const _MarqueeStrip();

  @override
  Widget build(BuildContext context) {
    const text =
        'Flutter Developer   •   REST APIs   •   Firebase   •   '
        'UI/UX Design   •   AI Integration   •   Mobile Apps   •   '
        'Clean Architecture   •   State Management   •   Performance   •   ';

    return Container(
      width: double.infinity,
      height: 44,
      color: AppColors.teal.withOpacity(0.90),
      child: Marquee(
        text: text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        scrollAxis: Axis.horizontal,
        blankSpace: 60,
        velocity: 55,
        pauseAfterRound: Duration.zero,
        fadingEdgeStartFraction: 0.05,
        fadingEdgeEndFraction: 0.05,
      ),
    );
  }
}
