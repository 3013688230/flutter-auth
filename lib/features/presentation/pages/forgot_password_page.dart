import 'package:flutter/material.dart';

import '../../../const.dart';
import '../widgets/container_button_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/row_text_widget.dart';
import '../widgets/text_container_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 22.0,
            vertical: 32.0,
          ),
          child: Column(
            children: [
              const HeaderWidget(
                title: 'Forgot Password',
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                  "Don't worry! Just fill in your email and ${AppConst.appName}"
                  "will send you a link to rest your password."),
              const SizedBox(
                height: 20.0,
              ),
              TextContainerWidget(
                controller: _emailController,
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const ContainerButtonWidget(
                title: 'Send Password Reset Email',
              ),
              const SizedBox(
                height: 20.0,
              ),
              RowTextWidget(
                title1: "Remember the account information?",
                title2: "Login",
                onTap: () {
                  Navigator.pushNamed(context, PageConst.loginPage);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
