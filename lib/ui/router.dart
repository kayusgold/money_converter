import 'package:money_converter/ui/views/signup_view.dart';
import 'package:money_converter/ui/views/views.dart';
import 'package:flutter/material.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
        break;
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUpView());
        break;
      case '/signin':
        return MaterialPageRoute(builder: (_) => LoginView());
        break;
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("no route defined for ${settings.name}"),
            ),
          ),
        );
        break;
    }
  }
}
