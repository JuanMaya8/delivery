import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scaleAnim = Tween<double>(begin: 0.86, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.splashGradient),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: ScaleTransition(
              scale: _scaleAnim,
              child: Column(
                children: [
                  const Spacer(flex: 3),
                  Text(
                    'Foodgo',
                    style: GoogleFonts.greatVibes(
                      fontSize: 54,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(flex: 5),
                  const _LoadingDots(),
                  const SizedBox(height: 26),
                  const _BurgerBottomImage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BurgerBottomImage extends StatelessWidget {
  const _BurgerBottomImage();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -18,
            bottom: -8,
            child: Transform.rotate(
              angle: -0.07,
              child: Image.network(
                'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600',
                width: 220,
                height: 175,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => const _BurgerFallback(width: 220),
              ),
            ),
          ),
          Positioned(
            left: 106,
            bottom: -4,
            child: Image.network(
              'https://images.unsplash.com/photo-1550547660-d9450f859349?w=600',
              width: 172,
              height: 138,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => const _BurgerFallback(width: 172),
            ),
          ),
        ],
      ),
    );
  }
}

class _BurgerFallback extends StatelessWidget {
  final double width;

  const _BurgerFallback({required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width * 0.72,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.14),
        borderRadius: BorderRadius.circular(32),
      ),
      child: const Icon(
        Icons.fastfood_rounded,
        size: 70,
        color: Colors.white70,
      ),
    );
  }
}

class _LoadingDots extends StatelessWidget {
  const _LoadingDots();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: index == 1 ? Colors.white : Colors.white.withOpacity(0.55),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
