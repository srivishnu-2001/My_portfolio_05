import 'package:flutter/material.dart';
import '../constants.dart';
import '../data.dart';
import '../widgets/glass_card.dart';
import '../widgets/animated_reveal.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark  = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 750;
    final crossAxis = width >= 1200 ? 4 : width >= 750 ? 3 : 2;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 60, vertical: isMobile ? 50 : 80),
      decoration: BoxDecoration(
        color: dark
            ? AppColors.darkSurface.withOpacity(0.5)
            : AppColors.lightBg.withOpacity(0.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedReveal(
            child: SectionHeader(
                label: 'What I Do', title: 'Skills & Expertise', dark: dark),
          ),
          const SizedBox(height: 44),
          // Skill cards grid
          AnimatedReveal(
            delay: const Duration(milliseconds: 100),
            child: _SkillGrid(crossAxis: crossAxis, dark: dark),
          ),
          const SizedBox(height: 48),
          // Additional skills
          AnimatedReveal(
            delay: const Duration(milliseconds: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Additional Tools & Skills',
                    style: AppTextStyles.cardTitle(dark)
                        .copyWith(fontSize: 18)),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: PortfolioData.additionalSkills
                      .map((s) => _AdditionalSkillChip(
                          icon: s['icon']!, name: s['name']!, dark: dark))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillGrid extends StatelessWidget {
  final int crossAxis;
  final bool dark;
  const _SkillGrid({required this.crossAxis, required this.dark});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxis,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: PortfolioData.skills.length,
      itemBuilder: (ctx, i) {
        final s = PortfolioData.skills[i];
        return AnimatedReveal(
          key: ValueKey('skill_$i'),
          delay: Duration(milliseconds: 60 * i),
          child: _SkillCard(skill: s, dark: dark),
        );
      },
    );
  }
}

class _SkillCard extends StatefulWidget {
  final Map<String, dynamic> skill;
  final bool dark;
  const _SkillCard({required this.skill, required this.dark});
  @override
  State<_SkillCard> createState() => __SkillCardState();
}

class __SkillCardState extends State<_SkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _bar;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _bar  = Tween<double>(begin: 0, end: widget.skill['level'] as double)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final accent = Color(widget.skill['colorHex'] as int);
    final pct    = ((widget.skill['level'] as double) * 100).round();

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: widget.dark
              ? AppColors.darkCard.withOpacity(_hovered ? 0.95 : 0.75)
              : AppColors.lightCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? accent.withOpacity(0.5)
                : (widget.dark ? AppColors.darkBorder : AppColors.lightBorder),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? accent.withOpacity(0.18)
                  : Colors.black.withOpacity(widget.dark ? 0.25 : 0.06),
              blurRadius: _hovered ? 28 : 12,
              offset: Offset(0, _hovered ? 10 : 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.skill['icon'] as String,
                      style: const TextStyle(fontSize: 26)),
                  AnimatedBuilder(
                    animation: _bar,
                    builder: (_, __) => Text(
                      '${(_bar.value * 100).round()}%',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: accent,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                widget.skill['name'] as String,
                style: AppTextStyles.cardTitle(widget.dark)
                    .copyWith(fontSize: 13),
              ),
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: AnimatedBuilder(
                  animation: _bar,
                  builder: (_, __) => LinearProgressIndicator(
                    value: _bar.value,
                    backgroundColor: widget.dark
                        ? Colors.white12
                        : Colors.grey.withOpacity(0.15),
                    valueColor: AlwaysStoppedAnimation<Color>(accent),
                    minHeight: 5,
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

class _AdditionalSkillChip extends StatefulWidget {
  final String icon, name;
  final bool dark;
  const _AdditionalSkillChip(
      {required this.icon, required this.name, required this.dark});
  @override
  State<_AdditionalSkillChip> createState() => __AdditionalSkillChipState();
}

class __AdditionalSkillChipState extends State<_AdditionalSkillChip> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.teal.withOpacity(0.12)
              : (widget.dark ? AppColors.darkCard : AppColors.lightCard),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: _hovered
                ? AppColors.teal.withOpacity(0.5)
                : (widget.dark ? AppColors.darkBorder : AppColors.lightBorder),
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.icon, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Text(widget.name,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _hovered
                      ? AppColors.teal
                      : (widget.dark
                          ? AppColors.textOnDark
                          : AppColors.textOnLight),
                )),
          ],
        ),
      ),
    );
  }
}
