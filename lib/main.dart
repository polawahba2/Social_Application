import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubit/LogInCubit/BlocObserver.dart';
import 'package:social_app/Screens/Home/HomeLayOut.dart';
import 'package:social_app/Screens/LogIn/LoginScreen.dart';
import 'package:social_app/Shared/CasheHelper.dart';

import 'Components/Constants.dart';
import 'Cubit/Cubit/SocialCubit.dart';
import 'Cubit/LogInCubit/LogInCubit.dart';
import 'Cubit/RegisterCubit/RegisterCubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  // var token = await FirebaseMessaging.instance.getToken();
  // print(token);

  // FirebaseMessaging.onMessage.listen((event) {
  //   showToast(text: 'on message', state: ToastStates.SUCESS);
  //   print(event.data.toString());
  // });

  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   showToast(text: 'on message opened app', state: ToastStates.SUCESS);
  //   print(event.data.toString());
  // });

  await CashHelper.init();
  uId = CashHelper.getDate(key: 'uId');
  print('user id   $uId  Printed at main');
  Widget? startWidget;
  if (uId != null) {
    startWidget = HomeLayOut();
  } else {
    startWidget = LogInScreen();
  }

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (BuildContext context) => SocialLogInCubit(),
      ),
      BlocProvider(
        create: (BuildContext context) => SocialRegisterCubit(),
      ),
      BlocProvider(
        create: (BuildContext context) => SocialCubit()
          ..userGetData()
          ..getPosts()
          ..getMyPosts(),
      ),
    ],
    child: MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: Colors.white70,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: startWidget,
    ),
  ));
}
