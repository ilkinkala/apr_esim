import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';

// ─────────────────────────────────────────────────────────────
// Page type enum & data model
// ─────────────────────────────────────────────────────────────

enum PageType { globe, moneyCard, setup }

class OnboardingData {
  final String title;
  final String subtitle;
  final PageType pageType;

  const OnboardingData({
    required this.title,
    required this.subtitle,
    required this.pageType,
  });
}

// ─────────────────────────────────────────────────────────────
// Main Onboarding Screen
// ─────────────────────────────────────────────────────────────

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _animationController;

  static const _pages = [
    OnboardingData(
      title: 'Stay Connected Everywhere',
      subtitle:
          'Access instant mobile data in 190+ countries without swapping physical SIMs.',
      pageType: PageType.globe,
    ),
    OnboardingData(
      title: 'Affordable Data Plans',
      subtitle:
          'Say goodbye to expensive roaming charges. Get premium data at local rates.',
      pageType: PageType.moneyCard,
    ),
    OnboardingData(
      title: 'Easy Setup',
      subtitle:
          'Just choose your destination, purchase a plan, and scan the QR code to activate instantly.',
      pageType: PageType.setup,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animationController.forward();
  }

  void _onNextPressed() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToSignIn();
    }
  }

  void _navigateToSignIn() {
    // TODO: Navigate to Sign In screen when it's created
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navigating to Sign In... (Coming soon!)'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Page View
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
              _animationController.reset();
              _animationController.forward();
            },
            itemBuilder: (context, index) {
              return _OnboardingPage(
                data: _pages[index],
                onSkip: _navigateToSignIn,
                animation: _animationController,
              );
            },
          ),

          // Bottom Section (fixed)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 50.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Page Indicator Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        width: _currentPage == index ? 24.w : 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primary
                              : AppColors.primary.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Next / Get Started Button
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: _onNextPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1
                            ? 'Get Started'
                            : 'Next',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
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
}

// ─────────────────────────────────────────────────────────────
// Individual Onboarding Page
// ─────────────────────────────────────────────────────────────

class _OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  final VoidCallback onSkip;
  final AnimationController animation;

  const _OnboardingPage({
    required this.data,
    required this.onSkip,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Background decorations
        if (data.pageType == PageType.globe)
          ..._buildGlobeBackground(screenSize),
        if (data.pageType == PageType.moneyCard)
          ..._buildCardBackground(screenSize),

        // Content
        SafeArea(
          child: Column(
            children: [
              // Skip Button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: GestureDetector(
                    onTap: onSkip,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      child: Text(
                        'SKIP',
                        style: TextStyle(
                          color: data.pageType == PageType.moneyCard
                              ? AppColors.background
                              : AppColors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Visual Content
              Expanded(flex: 5, child: _buildVisualContent()),

              // Text Section
              Expanded(
                flex: data.pageType == PageType.moneyCard ? 2 : 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: data.pageType == PageType.moneyCard
                            ? 4.h
                            : 16.h,
                      ),
                      // Title
                      SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: const Offset(0, 0.3),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: const Interval(
                                  0.2,
                                  1.0,
                                  curve: Curves.easeOutCubic,
                                ),
                              ),
                            ),
                        child: FadeTransition(
                          opacity: CurvedAnimation(
                            parent: animation,
                            curve: const Interval(0.2, 1.0),
                          ),
                          child: Text(
                            data.title,
                            style: TextStyle(
                              fontSize: 26.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                      SizedBox(height: 14.h),

                      // Subtitle
                      SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: const Offset(0, 0.3),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: const Interval(
                                  0.35,
                                  1.0,
                                  curve: Curves.easeOutCubic,
                                ),
                              ),
                            ),
                        child: FadeTransition(
                          opacity: CurvedAnimation(
                            parent: animation,
                            curve: const Interval(0.35, 1.0),
                          ),
                          child: Text(
                            data.subtitle,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: AppColors.textSecondary,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Space for bottom controls
              SizedBox(height: 140.h),
            ],
          ),
        ),
      ],
    );
  }

  // ── Background builders ──

  List<Widget> _buildGlobeBackground(Size screenSize) {
    return [
      // Back wave (sage green)
      Positioned.fill(
        child: FadeTransition(
          opacity: animation,
          child: CustomPaint(
            painter: _WavePainter(
              waveColor: AppColors.primary.withValues(alpha: 0.28),
              yShift: -0.025,
            ),
          ),
        ),
      ),
      // Front wave (dark teal)
      Positioned.fill(
        child: FadeTransition(
          opacity: animation,
          child: CustomPaint(
            painter: _WavePainter(waveColor: AppColors.primary, yShift: 0.0),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildCardBackground(Size screenSize) {
    return [
      // Shadow card
      Positioned.fill(
        child: FadeTransition(
          opacity: animation,
          child: CustomPaint(
            painter: _CardWavePainter(
              cardColor: AppColors.primary.withValues(alpha: 0.25),
              dx: 8,
              dy: 10,
            ),
          ),
        ),
      ),
      // Main card
      Positioned.fill(
        child: FadeTransition(
          opacity: animation,
          child: CustomPaint(
            painter: _CardWavePainter(
              cardColor: AppColors.primary,
              dx: 0,
              dy: 0,
            ),
          ),
        ),
      ),
    ];
  }

  // ── Visual content per page ──

  Widget _buildVisualContent() {
    switch (data.pageType) {
      case PageType.globe:
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
              .animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
          child: FadeTransition(
            opacity: animation,
            child: OverflowBox(
              maxWidth: 500.w,
              maxHeight: 500.w,
              child: Transform.translate(
                offset: Offset(0, -50.h),
                child: Image.asset(
                  'assets/images/onboarding/onboarding_screen1.png',
                  width: 500.w,
                  height: 500.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );

      case PageType.moneyCard:
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
              .animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
          child: FadeTransition(
            opacity: animation,
            child: OverflowBox(
              maxWidth: 550.w,
              maxHeight: 550.w,
              child: Transform.translate(
                offset: Offset(0, -40.h),
                child: Image.asset(
                  'assets/images/onboarding/onboarding_screen2.png',
                  width: 550.w,
                  height: 550.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );

      case PageType.setup:
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
              .animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
          child: FadeTransition(
            opacity: animation,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Center(
                child: Image.asset(
                  'assets/images/onboarding/onboarding_setup.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
    }
  }
}

// ─────────────────────────────────────────────────────────────
// Screen 1 – Wave Painter (flowing horizontal ribbons)
// ─────────────────────────────────────────────────────────────

class _WavePainter extends CustomPainter {
  final Color waveColor;
  final double yShift;

  const _WavePainter({required this.waveColor, this.yShift = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()
      ..color = waveColor
      ..style = PaintingStyle.fill;

    final baseTop = 0.44 + yShift;
    final baseBot = 0.51 + yShift;

    final path = Path();

    // Top edge – single smooth S-curve
    path.moveTo(0, h * baseTop);
    path.cubicTo(
      w * 0.35,
      h * (baseTop - 0.05),
      w * 0.65,
      h * (baseTop + 0.06),
      w,
      h * (baseTop - 0.04),
    );

    // Right edge down
    path.lineTo(w, h * (baseBot - 0.04));

    // Bottom edge – single smooth S-curve back
    path.cubicTo(
      w * 0.65,
      h * (baseBot + 0.06),
      w * 0.35,
      h * (baseBot - 0.05),
      0,
      h * baseBot,
    );

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WavePainter old) =>
      waveColor != old.waveColor || yShift != old.yShift;
}

// ─────────────────────────────────────────────────────────────
// Screen 2 – Card with wavy bottom edge
// ─────────────────────────────────────────────────────────────

class _CardWavePainter extends CustomPainter {
  final Color cardColor;
  final double dx;
  final double dy;

  const _CardWavePainter({required this.cardColor, this.dx = 0, this.dy = 0});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()
      ..color = cardColor
      ..style = PaintingStyle.fill;

    final margin = w * 0.05;
    final topY = h * 0.09;
    final radius = w * 0.07;

    canvas.save();
    canvas.translate(dx, dy);

    final path = Path();

    // Top-left rounded corner
    path.moveTo(margin, topY + radius);
    path.quadraticBezierTo(margin, topY, margin + radius, topY);

    // Top edge
    path.lineTo(w - margin - radius, topY);

    // Top-right rounded corner
    path.quadraticBezierTo(w - margin, topY, w - margin, topY + radius);

    // Right edge down to wave
    path.lineTo(w - margin, h * 0.50);

    // Wavy bottom edge (right to left)
    path.cubicTo(w - margin, h * 0.56, w * 0.72, h * 0.62, w * 0.50, h * 0.54);
    path.cubicTo(w * 0.32, h * 0.48, w * 0.18, h * 0.52, margin, h * 0.56);

    // Left edge back up
    path.lineTo(margin, topY + radius);

    path.close();
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CardWavePainter old) =>
      cardColor != old.cardColor || dx != old.dx || dy != old.dy;
}
