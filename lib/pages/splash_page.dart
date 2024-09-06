import 'package:cred/main.dart';
import 'package:cred/pages/home_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  /// Splash screens which will be displayed for 1 second
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  /// will redirect to home page after 1 second
  redirect() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // will initialize the global variables with the device dimensions
    if (mounted) {
      setState(() {
        height = MediaQuery.of(context).size.height;
        width = MediaQuery.of(context).size.width;
      });
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        // CRED logo
        child: Image.asset(
          "assets/images/cred.png",
          height: 150,
          width: 150,
        ),
      ),
    );
  }
}
