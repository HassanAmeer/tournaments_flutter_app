import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/colors.dart';

class PlaningLoading extends StatefulWidget {
  // final String gender;
  // final String sportType;
  // final String tournamentType;
  // final List teams;
  const PlaningLoading({
    super.key,
    // required this.gender,
    // required this.sportType,
    // required this.teams,
    // required this.tournamentType
  });

  @override
  State<PlaningLoading> createState() => _PlaningLoadingState();
}

class _PlaningLoadingState extends State<PlaningLoading> {
  @override
  void initState() {
    super.initState();
    onlineSpan();
  }

  onlineSpan() async {
    Timer(const Duration(seconds: 3), () async {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    });
    // Timer(const Duration(seconds: 3), () async {
    //   Navigator.of(context).pushReplacement(PageRouteBuilder(
    //       transitionDuration: const Duration(seconds: 2),
    //       pageBuilder: (context, animation, secondaryAnimation) =>
    //           const VCreatedTeamsListPage(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) =>
    //           FadeTransition(opacity: animation, child: child)));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Image.asset("assets/splash1.png")),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(' Become Ready To Planing',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              // color: Colors.deepPurpleAccent,
                              color: MaterialColors.deepOrange[200],
                              shadows: [
                            BoxShadow(
                                color: MaterialColors.deepOrange[800]!,
                                offset: const Offset(1, 1),
                                blurRadius: 2)
                          ]))
                  .animate(
                      delay: 500.ms,
                      onPlay: (controller) => controller.repeat())
                  // .slideY(duration: const Duration(milliseconds: 800))
                  // .scaleXY()
                  .shakeX()
                  .shimmer(
                      duration: const Duration(seconds: 2),
                      delay: const Duration(milliseconds: 1000))
                  .shimmer(
                      duration: const Duration(seconds: 2),
                      curve: Curves.easeInOut),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.grey.shade300,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              child: Image.asset(
                "assets/boxingring.jpg",
                fit: BoxFit.cover,
              )),
        ],
      ),
    );
  }
}
