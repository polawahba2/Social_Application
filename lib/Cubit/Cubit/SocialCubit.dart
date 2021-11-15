// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Components/Constants.dart';
import 'package:social_app/Cubit/Cubit/SocialStates.dart';
import 'package:social_app/Models/MessageModel.dart';
import 'package:social_app/Models/PostModel.dart';
import 'package:social_app/Models/UserModel.dart';
import 'package:social_app/Screens/Chats/ChatScreen.dart';
import 'package:social_app/Screens/Feeds/FeedsScreen.dart';
import 'package:social_app/Screens/NewPost/NewPostScreen.dart';
import 'package:social_app/Screens/Settings/SettingsScreen.dart';
import 'package:social_app/Screens/Users/UsersScreen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit getCubit(context) => BlocProvider.of(context);
  File? profileImage;
  File? coverImage;
  var picker = ImagePicker();

  UserModel? model;
  List appBarTitle = [
    'Home',
    'Chats',
    'Post',
    'Settings',
  ];

  void userGetData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      emit(SocialGetUserSuccessState());
      // print('the  data is ${value.data()}');

      model = UserModel.fromJson(value.data());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    SettingScreen(),
  ];
  void changeButtomNav(
    int index,
  ) {
    if (index == 1) getAllUsers();

    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeButtomNavState());
    }
  }

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSucessState());
    } else {
      emit(SocialProfileImagePickedErrorState());
      print('No image selected.');
    }
  }

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      // print(pickedFile.path);
      ///data/user/0/com.example.social_app/cache/image_picker5806066583606201847.jpg
      emit(SocialCoverImagePickedSucessState());
    } else {
      emit(SocialCoverImagePickedErrorState());
      print('No image selected.');
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialProfileImageUploadeLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          profileImage: value,
        );
        profileImage = null;
      }).catchError((error) {
        emit(SocialProfileImageUploadedErrorState());
      });
    }).catchError((error) {
      emit(SocialProfileImageUploadedErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialCoverImageUploadeLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          coverImage: value,
        );
        coverImage = null;
      }).catchError((error) {
        emit(SocialCoverImageUploadedErrorState());
      });
    }).catchError((error) {
      emit(SocialCoverImageUploadedErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? profileImage,
    String? coverImage,
  }) {
    UserModel userModel = UserModel(
      name: name,
      bio: bio,
      phone: phone,
      email: model!.email,
      image: profileImage ?? model!.image,
      cover: coverImage ?? model!.cover,
      uId: model!.uId,
      isVerified: model!.isVerified,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .update(userModel.toMap())
        .then((value) {
      emit(SocialUserUploadeSucessState());

      userGetData();
    }).catchError((error) {
      emit(SocialUserUploadeErrorState());
    });
  }

  File? postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      // print(pickedFile.path);
      ///data/user/0/com.example.social_app/cache/image_picker5806066583606201847.jpg
      emit(SocialPostImagePickedSucessState());
    } else {
      emit(SocialPostImagePickedErrorState());
      print('No image selected.');
    }
  }

  void uploadPostImage({
    required String? dataTime,
    required String? text,
  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          text: text,
          dataTime: dataTime,
          postImage: value,
        );
        coverImage = null;
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void createPost({
    required String? dataTime,
    required String? text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel Model = PostModel(
      name: model!.name,
      image: model!.image,
      uId: model!.uId,
      dataTime: dataTime,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(Model.toMap())
        .then((value) {
      emit(SocialCreatePostSucessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];

  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dataTime')
        .get()
        .then((listOfPostsId) {
      listOfPostsId.docs.forEach((element) {
        element.reference.collection('likes').get().then((listOfUsersId) {
          likes.add(listOfUsersId.docs.length);

          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(SocialGetPostsSuccessState());
        }).catchError((error) {});
      });
      // emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  void unLikePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .delete()
        .then((value) {
      emit(SocialUnLikePostSuccessState());
    }).catchError((error) {
      emit(SocialUnLikePostErrorState(error.toString()));
    });
  }

  List<UserModel> allUsers = [];
  void getAllUsers() {
    if (allUsers.isEmpty)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != model!.uId)
            allUsers.add(UserModel.fromJson(element.data()));
          emit(SocialGetAllUsersSuccessState());
        });
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
  }

  // List UsersWhoLike = [];
  // void getUsersWhoLike(String postId) {
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(postId)
  //       .get()
  //       .then((value) {
  //     // value.docs.forEach((element) {
  //     //   UsersWhoLike.add(element.data());
  //     // });

  //     // print(UsersWhoLike);
  //     emit(SocialgetUsersWhoLikeSuccessState());
  //     // print(UsersWhoLike);
  //   });
  // }

  void sendMessage({
    required reciverId,
    required dateTime,
    required text,
  }) {
    MessageModel message = MessageModel(
      dateTime: dateTime,
      reciverId: reciverId,
      text: text,
      senderId: model!.uId,
    );
    //myChat
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .add(message.toMap())
        .then((value) {
      emit(SocialSendMassageSucessState());
    }).catchError((error) {
      emit(SocialSendMassageErrorState());
    });
//reciver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('messages')
        .add(message.toMap())
        .then((value) {
      emit(SocialSendMassageSucessState());
    }).catchError((error) {
      emit(SocialSendMassageErrorState());
    });
  }

  List<MessageModel> messages = [
    MessageModel(text: ''),
  ];
  void getMessages({
    required reciverId,
  }) {
    // emit(SocialGetMassagesLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      emit(SocialGetMassagesSucesstate());
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
    });
  }
}
