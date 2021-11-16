import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Components/Constants.dart';
import 'package:social_app/Components/MyButton.dart';
import 'package:social_app/Components/Toast.dart';
import 'package:social_app/Cubit/Cubit/SocialCubit.dart';
import 'package:social_app/Cubit/LogInCubit/LogInCubit.dart';
import 'package:social_app/Cubit/LogInCubit/LogInStates.dart';
import 'package:social_app/Screens/Home/HomeLayOut.dart';
import 'package:social_app/Screens/Register/RegisterScreen.dart';
import 'package:social_app/Shared/CasheHelper.dart';

class LogInScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var logInkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocConsumer<SocialLogInCubit, SocialLogInStates>(
      listener: (context, state) {
        if (state is SocialLogInErrorState) {
          showToast(text: state.error.toString(), state: ToastStates.ERROR);
        }
        if (state is SocialLogInSuccessState) {
          CashHelper.saveData(
            key: 'uId',
            value: state.uId,
          );
          uId = state.uId;
          SocialCubit.getCubit(context).userGetData();
          SocialCubit.getCubit(context).getAllUsers();
          SocialCubit.getCubit(context).getPosts();
          SocialCubit.getCubit(context).getMyPosts();

          pushAndTerminate(context: context, route: HomeLayOut());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: logInkey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.2,
                      ),
                      const Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      const Text(
                        'Login and share your memories with your friends.',
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
                        controller: passwordController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 5) {
                            return 'enter valid password';
                          }
                        },
                        obscureText: true,
                        onFieldSubmitted: (value) {
                          if (logInkey.currentState!.validate()) {
                            SocialLogInCubit.getCubit(context).userLogIn(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      BuildCondition(
                          condition: state is! SocialLogInLoadingState,
                          builder: (context) {
                            return MyButton(
                              text: 'Log In',
                              color: Colors.blue,
                              press: () {
                                if (logInkey.currentState!.validate()) {
                                  SocialLogInCubit.getCubit(context).userLogIn(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              textColor: Colors.white,
                            );
                          },
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator())),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'don\'t have an account ? ',
                            style: TextStyle(
                              fontSize: 15,
                              // color: Colors.blue,
                            ),
                          ),
                          InkWell(
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              pushAndTerminate(
                                  context: context, route: RegisterScreen());
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
