import 'package:flutter/material.dart';

import '../constants.dart';
import '../data.dart';
import '../widgets/animated_reveal.dart';
import '../widgets/glass_card.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 750;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 60,
        vertical: isMobile ? 50 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedReveal(
            child: SectionHeader(
              label: 'My Journey',
              title: 'Work Experience',
              dark: dark,
            ),
          ),
          const SizedBox(height: 48),
          ...PortfolioData.experience.asMap().entries.map((entry) {
            final i = entry.key;
            final exp = entry.value;
            return AnimatedReveal(
              key: ValueKey('exp_$i'),
              delay: Duration(milliseconds: 120 * i),
              child: _TimelineTile(exp: exp, dark: dark, isLast: true),
            );
          }),
        ],
      ),
    );
  }
}

class _TimelineTile extends StatefulWidget {
  final Map<String, dynamic> exp;
  final bool dark;
  final bool isLast;
  const _TimelineTile({
    required this.exp,
    required this.dark,
    required this.isLast,
  });
  @override
  State<_TimelineTile> createState() => __TimelineTileState();
}

class __TimelineTileState extends State<_TimelineTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _lineCtrl;
  late final Animation<double> _lineAnim;

  @override
  void initState() {
    super.initState();
    _lineCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _lineAnim = CurvedAnimation(parent: _lineCtrl, curve: Curves.easeOutCubic);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _lineCtrl.forward();
    });
  }

  @override
  void dispose() {
    _lineCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 750;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline column
        Column(
          children: [
            // Dot
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primary,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.teal.withOpacity(0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.work_outline_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            // Animated line
            if (!widget.isLast)
              AnimatedBuilder(
                animation: _lineAnim,
                builder: (_, __) => Container(
                  width: 2,
                  height: 80 * _lineAnim.value,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.teal, AppColors.teal.withOpacity(0)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 24),
        // Content card
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: HoverCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildRoleCompany(),
                            const SizedBox(height: 10),
                            _buildDurationBadge(),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildRoleCompany()),
                            const SizedBox(width: 16),
                            _buildDurationBadge(),
                          ],
                        ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 16),
                  // Bullet points
                  ...(widget.exp['bullets'] as List<String>)
                      .asMap()
                      .entries
                      .map(
                        (e) => AnimatedReveal(
                          key: ValueKey('bullet_${e.key}'),
                          delay: Duration(milliseconds: 80 * e.key),
                          slideOffset: 20,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 6),
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.teal,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    e.value,
                                    style: AppTextStyles.body(widget.dark),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoleCompany() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.exp['role'] as String,
          style: AppTextStyles.cardTitle(widget.dark).copyWith(fontSize: 17),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(
              Icons.business_outlined,
              size: 14,
              color: AppColors.teal,
            ),
            const SizedBox(width: 6),
            Text(
              widget.exp['company'] as String,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.teal,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDurationBadge() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.teal.withOpacity(0.10),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: AppColors.teal.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            widget.exp['duration'] as String,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.teal,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          widget.exp['period'] ?? '',
          style: TextStyle(
            fontSize: 12,
            color: widget.dark
                ? AppColors.textMutedOnDark
                : AppColors.textMutedOnLight,
          ),
        ),
      ],
    );
  }
}
