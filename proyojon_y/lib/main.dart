import 'package:flutter/material.dart';
import 'login_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _truckAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    // Truck left theke right e jwr code
    _truckAnimation = Tween<double>(
      begin: -150,
      end: 500,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _controller.forward();


    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>const LoginScreen()),
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

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: [

          /// logo
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 200), // logo upor-nich
              Center(
                child: Image.asset(
                  'assets/Logo.png',
                  width: 300,
                  height: 180,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 00),
              const Center(
                child: Text(
                  "পৌঁছে দিবো নিত্যদিনের বাজার",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),

          /// road
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/Road.png',
              width: screenWidth,
              height: 100,
              fit: BoxFit.fill,
            ),
          ),

          /// TRUCK ANIMATION
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                bottom: 115,
                left: Tween<double>(
                  begin: -150,
                  end: screenWidth / 2 + 30,
                ).evaluate(_controller),
                child: Image.asset(
                  'assets/Truck.png',
                  width: 300,
                  height: 160,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
