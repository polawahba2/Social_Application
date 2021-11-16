import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Cubit/Cubit/SocialCubit.dart';
import 'package:social_app/Screens/LogIn/LoginScreen.dart';
import 'package:social_app/Shared/CasheHelper.dart';

String? uId;
Color kDefaultColor = Colors.blue;

TextStyle kMySubTitle1 = TextStyle(
  color: Colors.black,
  fontSize: 14,
  fontWeight: FontWeight.w500,
  height: 1.4,
);

TextStyle kMySubTitle2 = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w300,
  color: Colors.grey,
  height: 1.3,
);

TextStyle kMyTitle1 = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontWeight: FontWeight.bold,
  // height: 1.3,
);

void pushOnly({context, var route}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return route;
  }));
}

void pushAndTerminate({context, var route}) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return route;
  }));
}

back(context) {
  Navigator.pop(context);
}

void signOut(context) {
  CashHelper.removeKey(key: 'uId');
  uId = '';
  SocialCubit.getCubit(context).currentIndex = 0;
  SocialCubit.getCubit(context).posts = [];
  SocialCubit.getCubit(context).postId = [];
  SocialCubit.getCubit(context).likes = [];

  SocialCubit.getCubit(context).myPosts = [];
  SocialCubit.getCubit(context).myPostsId = [];
  SocialCubit.getCubit(context).myPostsLikes = [];

  SocialCubit.getCubit(context).allUsers = [];
  SocialCubit.getCubit(context).model = null;
  pushAndTerminate(context: context, route: LogInScreen());
}
