import 'package:flutter/material.dart';
import '../constants.dart';
import '../data.dart';
import '../widgets/glass_card.dart';
import '../widgets/animated_reveal.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark     = Theme.of(context).brightness == Brightness.dark;
    final width    = MediaQuery.of(context).size.width;
    final isMobile = width < 750;
    final crossAxis = width >= 1100 ? 2 : 1;

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
                label: 'What I Built', title: 'Featured Projects', dark: dark),
          ),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxis,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: isMobile ? 0.85 : 1.05,
            ),
            itemCount: PortfolioData.projects.length,
            itemBuilder: (ctx, i) {
              final p = PortfolioData.projects[i];
              return AnimatedReveal(
                key: ValueKey('proj_$i'),
                delay: Duration(milliseconds: 100 * i),
                child: _ProjectCard(project: p, dark: dark),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final bool dark;
  const _ProjectCard({required this.project, required this.dark});
  @override
  State<_ProjectCard> createState() => __ProjectCardState();
}

class __ProjectCardState extends State<_ProjectCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late final AnimationController _overlayCtrl;
  late final Animation<double>   _overlayAnim;

  @override
  void initState() {
    super.initState();
    _overlayCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _overlayAnim =
        CurvedAnimation(parent: _overlayCtrl, curve: Curves.easeOut);
  }

  @override void dispose() { _overlayCtrl.dispose(); super.dispose(); }

  void _onHover(bool val) {
    setState(() => _hovered = val);
    if (val) _overlayCtrl.forward(); else _overlayCtrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final accent = Color(widget.project['accentHex'] as int);
    final tags   = List<String>.from(widget.project['tags'] as List);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _onHover(true),
      onExit:  (_) => _onHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _hovered ? -8 : 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.dark ? AppColors.darkCard : AppColors.lightCard,
          border: Border.all(
            color: _hovered
                ? accent.withOpacity(0.5)
                : (widget.dark ? AppColors.darkBorder : AppColors.lightBorder),
            width: 1.3,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? accent.withOpacity(0.25)
                  : Colors.black.withOpacity(widget.dark ? 0.3 : 0.08),
              blurRadius: _hovered ? 40 : 16,
              offset: Offset(0, _hovered ? 16 : 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image area with zoom + overlay
              Expanded(
                flex: 5,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Project image with zoom on hover
                    AnimatedScale(
                      scale: _hovered ? 1.08 : 1.0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOutCubic,
                      child: Image.network(
                        widget.project['image'] as String,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) => Container(
                          color: accent.withOpacity(0.15),
                          child: Icon(Icons.image_outlined,
                              color: accent, size: 48),
                        ),
                      ),
                    ),
                    // Dark overlay on hover
                    AnimatedBuilder(
                      animation: _overlayAnim,
                      builder: (_, __) => Container(
                        color: Colors.black
                            .withOpacity(0.45 * _overlayAnim.value),
                        child: Center(
                          child: Opacity(
                            opacity: _overlayAnim.value,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: accent.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.open_in_new_rounded,
                                      color: Colors.white, size: 16),
                                  SizedBox(width: 8),
                                  Text('View Project',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Accent top bar
                    Positioned(
                      top: 0, left: 0, right: 0,
                      child: Container(
                        height: 3,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [accent, accent.withOpacity(0)],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Info area
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title row
                      Row(
                        children: [
                          Container(
                            width: 10, height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, color: accent),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              widget.project['title'] as String,
                              style: AppTextStyles.cardTitle(widget.dark)
                                  .copyWith(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Description
                      Expanded(
                        child: Text(
                          widget.project['desc'] as String,
                          style: AppTextStyles.body(widget.dark)
                              .copyWith(fontSize: 13),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Tags
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: tags
                            .map((t) => _Tag(label: t, accent: accent))
                            .toList(),
                      ),
                    ],
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

class _Tag extends StatelessWidget {
  final String label;
  final Color accent;
  const _Tag({required this.label, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.10),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: accent.withOpacity(0.3), width: 1),
      ),
      child: Text(label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: accent,
            letterSpacing: 0.3,
          )),
    );
  }
}
