abstract class SocialLogInStates {}

class SocialLogInInitialState extends SocialLogInStates {}

class SocialLogInLoadingState extends SocialLogInStates {}

class SocialLogInSuccessState extends SocialLogInStates {
  final String uId;

  SocialLogInSuccessState(this.uId);
}

class SocialLogInErrorState extends SocialLogInStates {
  final String error;
  SocialLogInErrorState(this.error);
}
