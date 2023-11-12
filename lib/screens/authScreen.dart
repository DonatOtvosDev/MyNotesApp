import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:my_notes/providers/auth.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  static const routeName = "/auth";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "WELCOME",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Take Your Notes With Us",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                AuthForm()
              ]),
        ),
      ),
    );
  }
}

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  Map<String, String> authData = {};
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextStyle textStyle =
      const TextStyle(fontSize: 18, color: Colors.white);
  bool _isLoading = false;
  bool _isLogIn = true;
  String passw = "";

  Future<void> _submit() async {
    authData = {};
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    _formKey.currentState!.save();
    await Provider.of<UserAuth>(context, listen: false).loginUser(authData);
   
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
                vertical: 18,
                horizontal: MediaQuery.of(context).size.width * 0.17),
            child: _isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Username:",
                          style: textStyle,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35)
                                  .copyWith(topLeft: const Radius.circular(10)),
                              color: Colors.white),
                          child: TextFormField(
                            style: const TextStyle(fontSize: 18),
                            validator: (value) {
                              if (value == "") {
                                return "Field is required";
                              } else if (value!.length < 4) {
                                return "Username must be at least 4 characters";
                              } else if (value.contains(RegExp("[^a-z0-9]"))) {
                                return "Invalid character";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              authData["username"] = newValue!.trim();
                            },
                          ),
                        ),
                        Text(
                          "Password:",
                          style: textStyle,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35)
                                  .copyWith(topLeft: const Radius.circular(10)),
                              color: Colors.white),
                          child: TextFormField(
                              style: const TextStyle(fontSize: 18),
                              validator: (value) {
                                if (value == "") {
                                  return "Field is required";
                                } else if (value!.length < 6) {
                                  return "Password must be at least 4 characters";
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                authData["password"] = newValue!.trim();
                              }),
                        ),
                        if (!_isLogIn)
                          Text(
                            "Password again:",
                            style: textStyle,
                          ),
                        if (!_isLogIn)
                          Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35)
                                    .copyWith(
                                        topLeft: const Radius.circular(10)),
                                color: Colors.white),
                            child: TextFormField(
                              style: const TextStyle(fontSize: 18),
                              validator: (value) {
                                if (value == "") {
                                  return "Field is required";
                                } else if (value!.length < 6) {
                                  return "Password must be at least 4 characters";
                                } else if (value != passw) {
                                  return "Both passwords must mach!";
                                }
                                return null;
                              },
                            ),
                          ),
                        Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 8),
                            alignment: Alignment.center,
                            child: ElevatedButton(
                                onPressed: _submit,
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.white, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context)
                                            .colorScheme
                                            .background)),
                                child: Text(
                                  _isLogIn ? "Login" : "Register",
                                  style: textStyle.copyWith(
                                      fontWeight: FontWeight.bold),
                                ))),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogIn = !_isLogIn;
                                });
                              },
                              child: Text(
                                _isLogIn
                                    ? "Do not have an account yet?"
                                    : "Already have account?",
                                style: textStyle,
                                textAlign: TextAlign.center,
                              )),
                        )
                      ],
                    ))));
  }
}
