import 'package:flutter/material.dart';
import '../constants.dart';
import '../data.dart';
import '../widgets/glass_card.dart';
import '../widgets/animated_reveal.dart';
import '../utils/launcher.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 750;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 60, vertical: isMobile ? 50 : 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedReveal(
            child: SectionHeader(
                label: 'Who I Am', title: 'About Me', dark: dark),
          ),
          const SizedBox(height: 44),
          AnimatedReveal(
            delay: const Duration(milliseconds: 150),
            child: isMobile
                ? _buildMobileContent(context, dark)
                : _buildDesktopContent(context, dark),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopContent(BuildContext context, bool dark) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 5, child: _buildBio(dark)),
          const SizedBox(width: 40),
          Expanded(flex: 4, child: _buildStats(context, dark)),
        ],
      );

  Widget _buildMobileContent(BuildContext context, bool dark) => Column(
        children: [
          _buildBio(dark),
          const SizedBox(height: 32),
          _buildStats(context, dark),
        ],
      );

  // ── Bio card ────────────────────────────────────────────────────────────
  Widget _buildBio(bool dark) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My Story', style: AppTextStyles.cardTitle(dark)),
          const SizedBox(height: 16),
          Text(PortfolioData.summary, style: AppTextStyles.body(dark)),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          ...PortfolioData.education.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.teal.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.school_outlined,
                        color: AppColors.teal, size: 18),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e['degree']!,
                            style: AppTextStyles.cardTitle(dark)
                                .copyWith(fontSize: 13)),
                        const SizedBox(height: 2),
                        Text(
                            '${e['institute']}  •  ${e['year']}  •  ${e['grade']}',
                            style: AppTextStyles.label(dark)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Stats + contact ──────────────────────────────────────────────────────
  Widget _buildStats(BuildContext context, bool dark) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: _statCard('17+', 'Months\nExperience',
                    Icons.work_outline, dark)),
            const SizedBox(width: 16),
            Expanded(
                child: _statCard('4', 'Projects\nDelivered',
                    Icons.rocket_launch_outlined, dark)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
                child: _statCard(
                    '8+', 'Skills\nMastered', Icons.star_outline, dark)),
            const SizedBox(width: 16),
            Expanded(
                child: _statCard('100%', 'Client\nSatisfaction',
                    Icons.thumb_up_outlined, dark)),
          ],
        ),
        const SizedBox(height: 16),

        // ── Tappable contact card ───────────────────────────────────────
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Get In Touch', style: AppTextStyles.cardTitle(dark)),
              const SizedBox(height: 16),

              // Email
              _TappableInfoRow(
                icon: Icons.email_outlined,
                text: PortfolioData.email,
                tooltip: 'Send Email',
                color: AppColors.teal,
                dark: dark,
                onTap: () => launchEmail(context),
              ),
              const SizedBox(height: 12),

              // Phone
              _TappableInfoRow(
                icon: Icons.phone_outlined,
                text: PortfolioData.phone,
                tooltip: 'Call Me',
                color: AppColors.teal,
                dark: dark,
                onTap: () => launchPhone(context),
              ),
              const SizedBox(height: 12),

              // Location (non-tappable)
              _TappableInfoRow(
                icon: Icons.location_on_outlined,
                text: PortfolioData.location,
                tooltip: '',
                color: AppColors.teal,
                dark: dark,
                onTap: null,
              ),
              const SizedBox(height: 12),

              const Divider(),
              const SizedBox(height: 12),

              // LinkedIn row
              _LinkedInRow(context: context, dark: dark),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statCard(
      String value, String label, IconData icon, bool dark) {
    return HoverCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.teal, size: 22),
          const SizedBox(height: 10),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (b) => AppColors.primary
                .createShader(Rect.fromLTWH(0, 0, b.width, b.height)),
            child: Text(value,
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1)),
          ),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.label(dark)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tappable info row  (email / phone / location)
// ─────────────────────────────────────────────────────────────────────────────
class _TappableInfoRow extends StatefulWidget {
  final IconData icon;
  final String text;
  final String tooltip;
  final Color color;
  final bool dark;
  final VoidCallback? onTap;

  const _TappableInfoRow({
    required this.icon,
    required this.text,
    required this.tooltip,
    required this.color,
    required this.dark,
    required this.onTap,
  });

  @override
  State<_TappableInfoRow> createState() => __TappableInfoRowState();
}

class __TappableInfoRowState extends State<_TappableInfoRow> {
  bool _hovered = false;
  final bool _canTap = true;

  @override
  Widget build(BuildContext context) {
    final canTap = widget.onTap != null;
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: canTap ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: (_) { if (canTap) setState(() => _hovered = true); },
        onExit:  (_) { if (canTap) setState(() => _hovered = false); },
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: _hovered
                  ? widget.color.withOpacity(0.08)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(widget.icon,
                    size: 16,
                    color: _hovered ? widget.color : widget.color.withOpacity(0.7)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: 13,
                      color: _hovered
                          ? widget.color
                          : (widget.dark
                              ? AppColors.textOnDark
                              : AppColors.textMutedOnLight),
                      fontWeight:
                          _hovered ? FontWeight.w600 : FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (canTap)
                  AnimatedOpacity(
                    opacity: _hovered ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 180),
                    child: Icon(Icons.open_in_new_rounded,
                        size: 12, color: widget.color),
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
// LinkedIn row inside the contact card
// ─────────────────────────────────────────────────────────────────────────────
class _LinkedInRow extends StatefulWidget {
  final BuildContext context;
  final bool dark;
  const _LinkedInRow({required this.context, required this.dark});

  @override
  State<_LinkedInRow> createState() => __LinkedInRowState();
}

class __LinkedInRowState extends State<_LinkedInRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    const liBlue = Color(0xFF0A66C2);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchLinkedIn(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered
                ? liBlue.withOpacity(0.10)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              // LinkedIn logo box
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: _hovered ? liBlue : liBlue.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Center(
                  child: Text('in',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          height: 1)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Connect on LinkedIn',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _hovered ? liBlue : liBlue.withOpacity(0.75),
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: _hovered ? 1 : 0.4,
                duration: const Duration(milliseconds: 180),
                child: const Icon(Icons.open_in_new_rounded,
                    size: 13, color: liBlue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
