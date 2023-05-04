import 'package:flutter/material.dart';
import 'package:flutter_auth/features/presentation/pages/login_page.dart';

import 'const.dart';
import 'features/presentation/pages/forgot_password_page.dart';
import 'features/presentation/pages/register_page.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.forgotPasswordPage:
        {
          return materialBuilder(widget: const ForgotPasswordPage());
        }
      case PageConst.registerPage:
        {
          return materialBuilder(widget: const RegisterPage());
        }
      case PageConst.loginPage:
        {
          return materialBuilder(widget: const LoginPage());
        }
      case '/':
        {
          return materialBuilder(widget: const LoginPage());
        }

      default:
        return materialBuilder(widget: ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Page'),
      ),
      body: const Center(
        child: Text('Error Page'),
      ),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
