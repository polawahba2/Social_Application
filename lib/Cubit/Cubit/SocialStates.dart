abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

//get user
class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;
  SocialGetUserErrorState(this.error);
}

//get all users

class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {
  final String error;
  SocialGetAllUsersErrorState(this.error);
}

//
class SocialChangeButtomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImagePickedSucessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSucessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialProfileImageUploadeLoadingState extends SocialStates {}

class SocialProfileImageUploadedSucessState extends SocialStates {}

class SocialProfileImageUploadedErrorState extends SocialStates {}

class SocialCoverImageUploadeLoadingState extends SocialStates {}

class SocialCoverImageUploadedSucessState extends SocialStates {}

class SocialCoverImageUploadedErrorState extends SocialStates {}

class SocialUserUploadeLoadingState extends SocialStates {}

class SocialUserUploadeSucessState extends SocialStates {}

class SocialUserUploadeErrorState extends SocialStates {}

// Create Post
class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSucessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialPostImagePickedSucessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

//Get Posts

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String error;
  SocialGetPostsErrorState(this.error);
}

//get my posts

class SocialGetMyPostsLoadingState extends SocialStates {}

class SocialGetMyPostsSuccessState extends SocialStates {}

class SocialGetMyPostsErrorState extends SocialStates {
  final String error;
  SocialGetMyPostsErrorState(this.error);
}

//like post

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;
  SocialLikePostErrorState(this.error);
}

//unlike posts
class SocialUnLikePostSuccessState extends SocialStates {}

class SocialUnLikePostErrorState extends SocialStates {
  final String error;
  SocialUnLikePostErrorState(this.error);
}

//get users
class SocialgetUsersWhoLikeSuccessState extends SocialStates {}

//chat

class SocialSendMassageSucessState extends SocialStates {}

class SocialSendMassageErrorState extends SocialStates {}

class SocialGetMassagesLoadingState extends SocialStates {}

class SocialGetMassagesSucesstate extends SocialStates {}
