import 'package:flutter/material.dart';
import 'package:money_converter/core/enums/viewstates.dart';
import 'package:money_converter/core/viewmodels/login_viewmodel.dart';
import 'package:money_converter/ui/views/views.dart';
import 'package:money_converter/ui/widgets/form_input.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController;
  TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BaseView<LoginViewModel>(
      onModelReady: (model) async {
        await model.init();
        print("Email Textfield should have: ${model.email}");
        emailController = TextEditingController(text: model.email);
        passwordController = TextEditingController(text: model.password);
      },
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.18,
                    child: CircleAvatar(
                      radius: 40,
                      child: Icon(
                        Icons.verified_user,
                        size: 40,
                      ),
                    ),
                  ),
                  Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  formField<LoginViewModel>(
                      model: model,
                      errorIndex: 0,
                      title: "Email",
                      controller: emailController,
                      initialValue: model.email,
                      obscureText: false,
                      modelError: model.errors),
                  formField<LoginViewModel>(
                      model: model,
                      errorIndex: 1,
                      title: "Password",
                      controller: passwordController,
                      initialValue: model.password,
                      obscureText: true,
                      modelError: model.errors),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Forgot Password? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            "Retreive",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (model.state == ViewState.Busy)
                    CircularProgressIndicator()
                  else
                    RaisedButton(
                      child: Text("Login"),
                      onPressed: () async {
                        var status = await model.login(
                            email: emailController.text,
                            password: passwordController.text);
                        if (status) {
                          //navigate to home screen
                          Navigator.pushNamed(context, "/");
                        } else {
                          print("error: ${model.errors.toString()}");
                        }
                      },
                    ),
                  model.error != null
                      ? Text(
                          model.error,
                          style: TextStyle(color: Colors.red),
                        )
                      : Container(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
