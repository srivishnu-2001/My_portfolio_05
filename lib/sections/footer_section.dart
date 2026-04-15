import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../constants.dart';
import '../data.dart';
import '../utils/launcher.dart';
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
              isMobile
                  ? _buildMobileFooter(context, dark)
                  : _buildDesktopFooter(context, dark),
              const SizedBox(height: 40),
              const Divider(color: Colors.white12),
              const SizedBox(height: 20),
              _buildBottomBar(),
            ],
          ),
        ),
        // Scrolling marquee strip
        const _MarqueeStrip(),
      ],
    );
  }

  Widget _buildDesktopFooter(BuildContext context, bool dark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _buildBrandCol(context)),
        const SizedBox(width: 60),
        Expanded(flex: 2, child: _buildQuickLinks()),
        const SizedBox(width: 40),
        Expanded(flex: 3, child: _buildContactCol(context, dark)),
      ],
    );
  }

  Widget _buildMobileFooter(BuildContext context, bool dark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBrandCol(context),
        const SizedBox(height: 36),
        _buildContactCol(context, dark),
      ],
    );
  }

  // ── Brand column with social icons ────────────────────────────────────────
  Widget _buildBrandCol(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        // Social icons — all tappable
        Row(
          children: [
            _SocialIcon(
              icon: Icons.code,
              tooltip: 'GitHub',
              onTap: () => launchGitHub(context),
            ),
            const SizedBox(width: 12),
            _SocialIcon(
              isLinkedIn: true,
              tooltip: 'LinkedIn',
              onTap: () => launchLinkedIn(context),
            ),
            const SizedBox(width: 12),
            _SocialIcon(
              icon: Icons.email_outlined,
              tooltip: 'Email',
              onTap: () => launchEmail(context),
            ),
            const SizedBox(width: 12),
            _SocialIcon(
              icon: Icons.phone_outlined,
              tooltip: 'Call',
              onTap: () => launchPhone(context),
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

  // ── Contact column — every row tappable ──────────────────────────────────
  Widget _buildContactCol(BuildContext context, bool dark) {
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
        _TappableFooterRow(
          icon: Icons.email_outlined,
          text: PortfolioData.email,
          tooltip: 'Send Email',
          onTap: () => launchEmail(context),
        ),
        const SizedBox(height: 12),
        _TappableFooterRow(
          icon: Icons.phone_outlined,
          text: PortfolioData.phone,
          tooltip: 'Call Me',
          onTap: () => launchPhone(context),
        ),
        const SizedBox(height: 12),
        _TappableFooterRow(
          icon: Icons.location_on_outlined,
          text: PortfolioData.location,
          tooltip: '',
          onTap: null,
        ),
        const SizedBox(height: 12),
        // LinkedIn dedicated row
        _TappableFooterRow(
          isLinkedIn: true,
          text: 'Connect on LinkedIn',
          tooltip: 'Open LinkedIn',
          onTap: () => launchLinkedIn(context),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      children: [
        const Text(
          '© 2026 Srivishnu Thiriveedhi  •  Built with ',
          style: TextStyle(color: Colors.white38, fontSize: 12),
        ),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (b) => AppColors.primary.createShader(
            Rect.fromLTWH(0, 0, b.width, b.height),
          ),
          child: const Text(
            'Flutter',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ),
        const Text(
          '  •  All rights reserved',
          style: TextStyle(color: Colors.white38, fontSize: 12),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CTA Banner
// ─────────────────────────────────────────────────────────────────────────────
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
      child: isMobile
          ? _buildMobileContent(context)
          : _buildDesktopContent(context),
    );
  }

  Widget _buildDesktopContent(BuildContext context) => Row(
    children: [
      Expanded(child: _buildText()),
      const SizedBox(width: 40),
      _buildButtons(context),
    ],
  );

  Widget _buildMobileContent(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildText(),
      const SizedBox(height: 28),
      _buildButtons(context),
    ],
  );

  Widget _buildText() => Column(
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

  Widget _buildButtons(BuildContext context) => Wrap(
    spacing: 12,
    runSpacing: 12,
    children: [
      // Email CTA — tappable
      ElevatedButton.icon(
        onPressed: () => launchEmail(context),
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
      // LinkedIn CTA — tappable
      OutlinedButton.icon(
        onPressed: () => launchLinkedIn(context),
        icon: Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
          ),
          child: const Center(
            child: Text(
              'in',
              style: TextStyle(
                color: Color(0xFF0A66C2),
                fontSize: 10,
                fontWeight: FontWeight.w900,
                height: 1,
              ),
            ),
          ),
        ),
        label: const Text('LinkedIn'),
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

// ─────────────────────────────────────────────────────────────────────────────
// Social icon button in footer brand col
// ─────────────────────────────────────────────────────────────────────────────
class _SocialIcon extends StatefulWidget {
  final IconData? icon;
  final bool isLinkedIn;
  final String tooltip;
  final VoidCallback onTap;

  const _SocialIcon({
    this.icon,
    this.isLinkedIn = false,
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
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: widget.isLinkedIn ? BoxShape.rectangle : BoxShape.circle,
              borderRadius: widget.isLinkedIn ? BorderRadius.circular(8) : null,
              color: _hovered
                  ? (widget.isLinkedIn
                        ? const Color(0xFF0A66C2)
                        : AppColors.teal)
                  : Colors.white.withOpacity(0.08),
              border: Border.all(
                color: _hovered
                    ? (widget.isLinkedIn
                          ? const Color(0xFF0A66C2)
                          : AppColors.teal)
                    : Colors.white24,
                width: 1,
              ),
            ),
            child: Center(
              child: widget.isLinkedIn
                  ? Text(
                      'in',
                      style: TextStyle(
                        color: _hovered ? Colors.white : Colors.white60,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        height: 1,
                      ),
                    )
                  : Icon(
                      widget.icon,
                      size: 18,
                      color: _hovered ? Colors.white : Colors.white60,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tappable footer contact row
// ─────────────────────────────────────────────────────────────────────────────
class _TappableFooterRow extends StatefulWidget {
  final IconData? icon;
  final bool isLinkedIn;
  final String text;
  final String tooltip;
  final VoidCallback? onTap;

  const _TappableFooterRow({
    this.icon,
    this.isLinkedIn = false,
    required this.text,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_TappableFooterRow> createState() => __TappableFooterRowState();
}

class __TappableFooterRowState extends State<_TappableFooterRow> {
  bool _hovered = false;
  final _liBlue = const Color(0xFF0A66C2);

  @override
  Widget build(BuildContext context) {
    final canTap = widget.onTap != null;
    final activeColor = widget.isLinkedIn ? _liBlue : AppColors.teal;

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
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
            decoration: BoxDecoration(
              color: _hovered
                  ? activeColor.withOpacity(0.12)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon or LinkedIn logo
                widget.isLinkedIn
                    ? Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: _hovered ? _liBlue : _liBlue.withOpacity(0.65),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: const Center(
                          child: Text(
                            'in',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              height: 1,
                            ),
                          ),
                        ),
                      )
                    : Icon(
                        widget.icon,
                        size: 16,
                        color: _hovered
                            ? activeColor
                            : activeColor.withOpacity(0.65),
                      ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: 13,
                      color: _hovered ? activeColor : Colors.white60,
                      fontWeight: _hovered
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (canTap)
                  AnimatedOpacity(
                    opacity: _hovered ? 1 : 0,
                    duration: const Duration(milliseconds: 180),
                    child: Icon(
                      Icons.open_in_new_rounded,
                      size: 12,
                      color: activeColor,
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

// ─────────────────────────────────────────────────────────────────────────────
// Footer nav link
// ─────────────────────────────────────────────────────────────────────────────
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
          fontWeight: _hovered ? FontWeight.w600 : FontWeight.normal,
          color: _hovered ? AppColors.teal : Colors.white54,
        ),
        child: Text(widget.label),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Marquee strip
// ─────────────────────────────────────────────────────────────────────────────
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
