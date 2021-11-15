import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubit/Cubit/SocialCubit.dart';
import 'package:social_app/Cubit/LogInCubit/LogInStates.dart';

class SocialLogInCubit extends Cubit<SocialLogInStates> {
  SocialLogInCubit() : super(SocialLogInInitialState());

  static SocialLogInCubit getCubit(context) => BlocProvider.of(context);

  void userLogIn({
    required String email,
    required String password,
  }) {
    emit(SocialLogInLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(SocialLogInSuccessState(value.user!.uid));

      // print(value.user!.email);
    }).catchError((error) {
      emit(SocialLogInErrorState(error.toString()));
      print(error.toString());
    });
  }

  // void userLogin({required String email, required String password}) {
  //   emit(SocialLogInLoadingState());
  //   DioHelper.postData(url: LOGIN, data: {
  //     'email': email,
  //     'password': password,
  //   }).then((value) {
  //     logInModel = SocialLogInModel.fromJson(value.data);
  //     emit(SocialLogInSuccessState(logInModel!));
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(SocialLogInErrorState(error.toString()));
  //   });
  // }
}
