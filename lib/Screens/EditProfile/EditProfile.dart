import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Components/Constants.dart';
import 'package:social_app/Components/Toast.dart';
import 'package:social_app/Cubit/Cubit/SocialCubit.dart';
import 'package:social_app/Cubit/Cubit/SocialStates.dart';

class EditProfileScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var updateFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var myCubit = SocialCubit.getCubit(context);

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialUserUploadeSucessState) {
          showToast(
            text: 'Data Updated Sucessefully',
            state: ToastStates.SUCESS,
          );
        }
      },
      builder: (context, state) {
        var userModel = SocialCubit.getCubit(context).model;
        var profileImage = SocialCubit.getCubit(context).profileImage;
        var coverImage = SocialCubit.getCubit(context).coverImage;
        nameController.text = userModel!.name.toString();
        bioController.text = userModel.bio.toString();
        phoneController.text = userModel.phone.toString();
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(
                  right: 8.0,
                ),
                child: TextButton(
                  onPressed: () {
                    if (coverImage != null && profileImage != null) {
                      myCubit.uploadCoverImage(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                      );
                      myCubit.uploadProfileImage(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                      );
                    } else if (profileImage != null) {
                      myCubit.uploadProfileImage(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                      );
                    } else if (coverImage != null) {
                      myCubit.uploadCoverImage(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                      );
                    } else {
                      myCubit.updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                      );
                    }
                  },
                  child: Text(
                    'UPDATE',
                  ),
                ),
              )
            ],
            title: Text(
              'Edit Profile',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (state is SocialGetUserLoadingState)
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(),
                    ),
                  SizedBox(
                    height: size.height * 0.27,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                height: size.height * 0.2,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                child: Image(
                                  image: coverImage == null
                                      ? NetworkImage(userModel.cover.toString())
                                      : FileImage(coverImage) as ImageProvider,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.blue,
                                child: IconButton(
                                  onPressed: () {
                                    myCubit.getCoverImage();
                                  },
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.white,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                // backgroundColor: Colors.amber,
                                backgroundImage: profileImage == null
                                    ? NetworkImage(userModel.image.toString())
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.blue,
                                child: IconButton(
                                  onPressed: () {
                                    myCubit.getProfileImage();
                                  },
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (coverImage != null || profileImage != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                      child: Row(
                        children: [
                          if (profileImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      myCubit.uploadProfileImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text);
                                    },
                                    minWidth: double.infinity,
                                    child: Text(
                                      'change profile ',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    color: kDefaultColor,
                                  ),
                                  if (state
                                      is SocialProfileImageUploadeLoadingState)
                                    LinearProgressIndicator(),
                                ],
                              ),
                            ),
                          SizedBox(
                            width: 5,
                          ),
                          if (coverImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      myCubit.uploadCoverImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text);
                                    },
                                    minWidth: double.infinity,
                                    child: Text(
                                      'change Cover ',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    color: kDefaultColor,
                                  ),
                                  if (state
                                      is SocialCoverImageUploadeLoadingState)
                                    LinearProgressIndicator(),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  Form(
                      key: updateFormKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                // fillColor: Colors.green,
                                labelText: 'Name',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Icons.people_alt_outlined,
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ' enter valid NAME';
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                // fillColor: Colors.green,_
                                labelText: 'Biooo',
                                border: OutlineInputBorder(),

                                prefixIcon: Icon(
                                  Icons.info_outline,
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              controller: bioController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ' enter valid BIO';
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                // fillColor: Colors.green,
                                labelText: 'Phone Number',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Icons.call,
                                ),
                              ),
                              // textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) {
                                myCubit.updateUser(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text,
                                );
                              },
                              controller: phoneController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ' enter valid phone';
                                }
                              },
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
