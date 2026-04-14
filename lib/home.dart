import 'package:flutter/material.dart';
import 'constants.dart';
import 'data.dart';
import 'painters/particle_painter.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/experience_section.dart';
import 'sections/projects_section.dart';
import 'sections/footer_section.dart';

class PortfolioHome extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;
  const PortfolioHome(
      {super.key, required this.onToggleTheme, required this.themeMode});
  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome>
    with SingleTickerProviderStateMixin {
  final _scrollCtrl = ScrollController();

  // Section keys for smooth scroll navigation
  final _heroKey       = GlobalKey();
  final _aboutKey      = GlobalKey();
  final _skillsKey     = GlobalKey();
  final _experienceKey = GlobalKey();
  final _projectsKey   = GlobalKey();
  final _footerKey     = GlobalKey();

  // Animated background controller
  late final AnimationController _bgCtrl;

  double _scrollProgress = 0.0;
  bool   _navScrolled    = false;

  @override
  void initState() {
    super.initState();
    _bgCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 40))
      ..repeat();

    _scrollCtrl.addListener(() {
      final max = _scrollCtrl.position.maxScrollExtent;
      if (max <= 0) return;
      final prog = (_scrollCtrl.offset / max).clamp(0.0, 1.0);
      final scrolled = _scrollCtrl.offset > 60;
      if (prog != _scrollProgress || scrolled != _navScrolled) {
        setState(() {
          _scrollProgress = prog;
          _navScrolled    = scrolled;
        });
      }
    });
  }

  @override
  void dispose() {
    _bgCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark  = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // ── Animated Particle Background ──────────────────────────────────
          AnimatedBuilder(
            animation: _bgCtrl,
            builder: (_, __) => CustomPaint(
              painter: ParticlePainter(_bgCtrl.value, isDark: dark),
              size: MediaQuery.of(context).size,
            ),
          ),

          // ── Scroll Progress Bar ───────────────────────────────────────────
          Positioned(
            top: 0, left: 0, right: 0,
            child: LinearProgressIndicator(
              value: _scrollProgress,
              minHeight: 3,
              backgroundColor: Colors.transparent,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.teal),
            ),
          ),

          // ── Main Content ──────────────────────────────────────────────────
          Column(
            children: [
              // Top nav
              _TopNav(
                scrolled:       _navScrolled,
                dark:           dark,
                themeMode:      widget.themeMode,
                onToggleTheme:  widget.onToggleTheme,
                onNavTap: (key) => _scrollTo(key),
                heroKey:        _heroKey,
                aboutKey:       _aboutKey,
                skillsKey:      _skillsKey,
                experienceKey:  _experienceKey,
                projectsKey:    _projectsKey,
              ),
              // Scrollable body
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollCtrl,
                  child: Column(
                    children: [
                      SizedBox(key: _heroKey,       child: const HeroSection()),
                      SizedBox(key: _aboutKey,      child: const AboutSection()),
                      SizedBox(key: _skillsKey,     child: const SkillsSection()),
                      SizedBox(key: _experienceKey, child: const ExperienceSection()),
                      SizedBox(key: _projectsKey,   child: const ProjectsSection()),
                      SizedBox(key: _footerKey,     child: const FooterSection()),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ── FAB – Scroll to top ───────────────────────────────────────────
          if (_navScrolled)
            Positioned(
              bottom: 28,
              right:  28,
              child: _ScrollToTopFab(
                onTap: () => _scrollCtrl.animateTo(
                  0,
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeInOutCubic,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TOP NAV BAR
// ─────────────────────────────────────────────────────────────────────────────
class _TopNav extends StatelessWidget {
  final bool scrolled, dark;
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;
  final void Function(GlobalKey) onNavTap;
  final GlobalKey heroKey, aboutKey, skillsKey, experienceKey, projectsKey;

  const _TopNav({
    required this.scrolled,
    required this.dark,
    required this.themeMode,
    required this.onToggleTheme,
    required this.onNavTap,
    required this.heroKey,
    required this.aboutKey,
    required this.skillsKey,
    required this.experienceKey,
    required this.projectsKey,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 900;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: scrolled
            ? (dark
                ? AppColors.darkCard.withOpacity(0.92)
                : AppColors.lightCard.withOpacity(0.92))
            : Colors.transparent,
        border: scrolled
            ? Border(
                bottom: BorderSide(
                  color: dark ? AppColors.darkBorder : AppColors.lightBorder,
                  width: 1,
                ),
              )
            : null,
        boxShadow: scrolled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 20,
                )
              ]
            : [],
      ),
      child: Row(
        children: [
          // Brand
          GestureDetector(
            onTap: () => onNavTap(heroKey),
            child: Row(
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.primary,
                  ),
                  child: const Center(
                    child: Text('ST',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 13)),
                  ),
                ),
                if (isWide) ...[
                  const SizedBox(width: 10),
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (b) => AppColors.primary
                        .createShader(Rect.fromLTWH(0, 0, b.width, b.height)),
                    child: const Text('Srivishnu',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3)),
                  ),
                ],
              ],
            ),
          ),
          const Spacer(),
          // Nav links (desktop only)
          if (isWide) ...[
            _NavLink('About',      onTap: () => onNavTap(aboutKey),      dark: dark),
            _NavLink('Skills',     onTap: () => onNavTap(skillsKey),     dark: dark),
            _NavLink('Experience', onTap: () => onNavTap(experienceKey), dark: dark),
            _NavLink('Projects',   onTap: () => onNavTap(projectsKey),   dark: dark),
            const SizedBox(width: 8),
            // Hire Me button
            Container(
              decoration: BoxDecoration(
                gradient: AppColors.primary,
                borderRadius: BorderRadius.circular(50),
              ),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
                child: const Text('Hire Me',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13)),
              ),
            ),
            const SizedBox(width: 12),
          ],
          // Theme toggle
          _ThemeToggle(themeMode: themeMode, onToggle: onToggleTheme, dark: dark),
        ],
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool dark;
  const _NavLink(this.label, {required this.onTap, required this.dark});
  @override
  State<_NavLink> createState() => __NavLinkState();
}

class __NavLinkState extends State<_NavLink> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 180),
            style: TextStyle(
              fontSize: 13,
              fontWeight: _hovered ? FontWeight.w700 : FontWeight.w500,
              color: _hovered
                  ? AppColors.teal
                  : (widget.dark
                      ? AppColors.textOnDark
                      : AppColors.textOnLight),
              letterSpacing: 0.3,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

class _ThemeToggle extends StatefulWidget {
  final ThemeMode themeMode;
  final VoidCallback onToggle;
  final bool dark;
  const _ThemeToggle(
      {required this.themeMode, required this.onToggle, required this.dark});
  @override
  State<_ThemeToggle> createState() => __ThemeToggleState();
}

class __ThemeToggleState extends State<_ThemeToggle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    if (widget.themeMode == ThemeMode.light) _ctrl.value = 1;
  }
  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onToggle();
        if (widget.themeMode == ThemeMode.dark) {
          _ctrl.forward();
        } else {
          _ctrl.reverse();
        }
      },
      child: Tooltip(
        message: widget.dark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 54, height: 28,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: widget.dark ? AppColors.primary : null,
            color: widget.dark ? null : Colors.grey.shade300,
            border: Border.all(
              color: widget.dark ? Colors.transparent : Colors.grey.shade400,
              width: 1,
            ),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            alignment: widget.dark
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
              width: 20, height: 20,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                widget.dark ? Icons.dark_mode : Icons.light_mode,
                size: 12,
                color: widget.dark ? AppColors.tealDark : Colors.amber,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SCROLL TO TOP FAB
// ─────────────────────────────────────────────────────────────────────────────
class _ScrollToTopFab extends StatefulWidget {
  final VoidCallback onTap;
  const _ScrollToTopFab({required this.onTap});
  @override
  State<_ScrollToTopFab> createState() => __ScrollToTopFabState();
}

class __ScrollToTopFabState extends State<_ScrollToTopFab> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 48, height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.primary,
            boxShadow: [
              BoxShadow(
                color: AppColors.teal.withOpacity(_hovered ? 0.5 : 0.3),
                blurRadius: _hovered ? 20 : 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.keyboard_arrow_up_rounded,
              color: Colors.white, size: 24),
        ),
      ),
    );
  }
}
