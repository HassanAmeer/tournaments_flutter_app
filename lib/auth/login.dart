import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:manager/vm/authvm.dart';
import 'package:manager/widgets/textfieldwidget.dart';
import 'package:provider/provider.dart';
import '../utils/assets.dart';
import '../utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ADMIN Login")),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () async {
                if (passController.text.isNotEmpty &&
                    emailController.text.isNotEmpty) {
                  await Provider.of<AdminAuthProviderC>(context, listen: false)
                      .matchAdminAuthF(context,
                          email: emailController.text,
                          password: passController.text);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('Required All Fields'),
                      action: SnackBarAction(label: 'Undo', onPressed: () {})));
                }
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(const StadiumBorder()),
                  backgroundColor: MaterialStateProperty.all(
                      MaterialColors.deepOrange.shade300)),
              child:
                  const Text("Login", style: TextStyle(color: Colors.white)))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Image.asset(Assets.admin)),
              Text('Champ Corner Manager',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          // color: Colors.deepPurpleAccent,
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
                      curve: Curves.easeInOut),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              TextFormFieldCustom(
                  controller: emailController, hint: "Email / Name"),
              const SizedBox(height: 5),
              TextFormFieldCustom(
                  controller: passController,
                  hint: "Password",
                  obscureText: isVisible,
                  suffixIcon: IconButton(
                      onPressed: () {
                        isVisible = !isVisible;
                        setState(() {});
                      },
                      icon: Icon(isVisible
                          ? Icons.visibility_off
                          : Icons.visibility))),
            ],
          ),
        ),
      ),
    );
  }
}
