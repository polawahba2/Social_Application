import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Components/Constants.dart';
import 'package:social_app/Components/MyButton.dart';
import 'package:social_app/Cubit/RegisterCubit/RegisterCubit.dart';
import 'package:social_app/Cubit/RegisterCubit/RegisterStates.dart';
import 'package:social_app/Screens/Home/HomeLayOut.dart';
import 'package:social_app/Screens/LogIn/LoginScreen.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var signUpKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
      listener: (context, state) {
        if (state is SocialCreateSuccessState) {
          pushAndTerminate(context: context, route: LogInScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: signUpKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      const Text(
                        'Signin and share your memories with your friends.',
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          // fillColor: Colors.green,
                          labelText: 'User Name',
                          border: OutlineInputBorder(),
                        ),
                        controller: userNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ' enter valid email';
                          }
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          // fillColor: Colors.green,
                          labelText: 'E-mail',
                          border: OutlineInputBorder(),
                        ),
                        controller: emailController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@')) {
                            return ' enter valid email';
                          }
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          // fillColor: Colors.green,
                          labelText: 'Password',

                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        controller: passwordController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 5) {
                            return 'enter valid password';
                          }
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          // fillColor: Colors.green,
                          labelText: 're enter Password',

                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        controller: rePasswordController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 5 ||
                              value != passwordController.text) {
                            return 'the password is not identical ';
                          }
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                          decoration: const InputDecoration(
                            // fillColor: Colors.green,
                            labelText: 'Phone',

                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                          controller: phoneController,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 9) {
                              return 'enter valid phone';
                            }
                          },
                          onFieldSubmitted: (value) {
                            if (signUpKey.currentState!.validate()) {
                              SocialRegisterCubit.getCubit(context)
                                  .userRegister(
                                name: userNameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          }),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      BuildCondition(
                        condition: state is! SocialRegisterLoadingState,
                        builder: (context) {
                          return MyButton(
                            text: 'Register',
                            color: Colors.blue,
                            press: () {
                              if (signUpKey.currentState!.validate()) {
                                SocialRegisterCubit.getCubit(context)
                                    .userRegister(
                                  name: userNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            textColor: Colors.white,
                          );
                        },
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            ' have an account ? ',
                            style: TextStyle(
                              fontSize: 15,
                              // color: Colors.blue,
                            ),
                          ),
                          InkWell(
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              pushAndTerminate(
                                  context: context, route: LogInScreen());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
