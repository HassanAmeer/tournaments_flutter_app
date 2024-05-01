import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:manager/firebase_options.dart';
import 'package:manager/utils/colors.dart';
import 'package:provider/provider.dart';
import 'auth/login.dart';
import 'screens/homepage.dart';
import 'utils/assets.dart';
import 'utils/glitch.dart';
import 'vm/authvm.dart';
import 'vm/home_vm.dart';
import 'vm/planing_vm.dart';
import 'vm/planing_vm_version2.dart';
import 'vm/sporttype_vm.dart';
import 'vm/tournaments_vm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeProviderC()),
          ChangeNotifierProvider(create: (_) => TournamentsC()),
          ChangeNotifierProvider(create: (_) => SportTypesC()),
          ChangeNotifierProvider(create: (_) => PlaningProviderC()),
          ChangeNotifierProvider(create: (_) => PlaningProviderVersion2C()),
          ChangeNotifierProvider(create: (_) => AdminAuthProviderC()),
        ],
        child: MaterialApp(
            title: 'Truiner Managment',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                colorScheme:
                    ColorScheme.fromSeed(seedColor: MaterialColors.deepOrange),
                useMaterial3: true,
                appBarTheme: AppBarTheme(
                    backgroundColor: MaterialColors.deepOrange.shade200)),
            home: const SplashPage()));
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    onlineSpan();
  }

  onlineSpan() async {
    Timer(const Duration(seconds: 3), () async {
      Navigator.of(context).pushReplacement(PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2),
          pageBuilder: (context, animation, secondaryAnimation) =>
              // const HomePage(),
              const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(color: MaterialColors.deepOrange[50]),
        child: Scaffold(
            backgroundColor: MaterialColors.deepOrange[50],
            extendBody: true,
            extendBodyBehindAppBar: true,
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 0.8 / 1,
                              child: GlithEffect(
                                  child: Image.asset(Assets.logotransparent)))
                          .animate()
                          .scale()),
                  Text('Champ Corner Manager',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: MaterialColors.deepOrange[400],
                                  shadows: [
                                BoxShadow(
                                    color: MaterialColors.deepOrange[200]!,
                                    offset: const Offset(1, 1),
                                    blurRadius: 2)
                              ]))
                      .animate(
                          delay: 500.ms,
                          onPlay: (controller) => controller.repeat())
                      .shakeX()
                      .shimmer(
                          duration: const Duration(seconds: 2),
                          delay: const Duration(milliseconds: 1000))
                      .shimmer(
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeInOut)
                ])));
  }
}
