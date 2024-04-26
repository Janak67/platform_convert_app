import 'package:flutter/cupertino.dart';

class SplashScreeniOS extends StatefulWidget {
  const SplashScreeniOS({super.key});

  @override
  State<SplashScreeniOS> createState() => _SplashScreeniOSState();
}

class _SplashScreeniOSState extends State<SplashScreeniOS> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacementNamed(context, 'home');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Image.asset('assets/img/1.png',
            fit: BoxFit.cover,
            height: MediaQuery.sizeOf(context).height * 0.07),
      ),
    );
  }
}
