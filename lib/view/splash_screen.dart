import 'package:flutter/material.dart';
import 'package:samaj_parivaar_app/res/assets_res.dart';
import 'package:samaj_parivaar_app/utils/local_storage.dart';
import 'package:samaj_parivaar_app/view/intro_page.dart';
import 'package:samaj_parivaar_app/view/landing/landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnim;

  @override
  void initState() {
    super.initState();
    // 2.2 second total duration
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    // single curve drives both scale and opacity
    _logoAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart));

    // navigate when animation finishes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (!LocalStorage.i.isLoggedIn()) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(pageBuilder: (_, __, ___) => const IntroPage()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(pageBuilder: (_, __, ___) => const LandingPage()),
          );
        }
      }
    });

    // start animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, child) {
            // scale 0.6 → 5  |  opacity 1 → 0
            final scale = 0.6 + 4.4 * _logoAnim.value;
            final opacity = 1 - _logoAnim.value;

            return Transform.scale(
              scale: scale,
              child: Opacity(
                opacity: opacity,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(AssetsRes.LOGO, fit: BoxFit.contain),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
