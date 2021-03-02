import 'package:flutter/material.dart';
import 'package:money_converter/core/enums/viewstates.dart';
import 'package:money_converter/core/viewmodels/signup_viewmodel.dart';
import 'package:money_converter/ui/views/base_view.dart';
import 'package:money_converter/ui/widgets/form_input.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpViewModel>(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 120,
                child: CircleAvatar(
                  radius: 40,
                  child: Icon(
                    Icons.verified_user,
                    size: 40,
                  ),
                ),
              ),
              Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              formField<SignUpViewModel>(
                  model: model,
                  errorIndex: 0,
                  title: "Name",
                  controller: nameController,
                  obscureText: false,
                  modelError: model.errors),
              formField<SignUpViewModel>(
                  model: model,
                  errorIndex: 1,
                  title: "Email",
                  controller: emailController,
                  obscureText: false,
                  modelError: model.errors),
              formField<SignUpViewModel>(
                  model: model,
                  errorIndex: 2,
                  title: "Password",
                  controller: passwordController,
                  obscureText: true,
                  modelError: model.errors),
              if (model.state == ViewState.Busy)
                CircularProgressIndicator()
              else
                RaisedButton(
                  child: Text("Sign Up"),
                  onPressed: () async {
                    var status = await model.signUp(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text);
                    print("status: $status");
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
                      Text("Already have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signin');
                        },
                        child: Text(
                          "Login",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
