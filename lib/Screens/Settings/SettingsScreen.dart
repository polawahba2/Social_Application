import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Components/Constants.dart';
import 'package:social_app/Cubit/Cubit/SocialCubit.dart';
import 'package:social_app/Cubit/Cubit/SocialStates.dart';
import 'package:social_app/Screens/EditProfile/EditProfile.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // SocialCubit.getCubit(context).userGetData();

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.getCubit(context).model;

        return BuildCondition(
          condition: userModel != null,
          builder: (context) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height * 0.27,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Container(
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
                                image:
                                    NetworkImage(userModel!.cover.toString()),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 60,
                              // backgroundColor: Colors.amber,
                              backgroundImage:
                                  NetworkImage(userModel.image.toString()),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      userModel.name.toString(),
                      style: kMyTitle1,
                    ),
                    Text(
                      userModel.bio.toString(),
                      style: kMySubTitle2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    '126',
                                    style: kMySubTitle2,
                                  ),
                                  Text(
                                    'Posts',
                                    style: kMySubTitle1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    '100',
                                    style: kMySubTitle2,
                                  ),
                                  Text(
                                    'Photos',
                                    style: kMySubTitle1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    '10K',
                                    style: kMySubTitle2,
                                  ),
                                  Text(
                                    'Follower',
                                    style: kMySubTitle1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    '43',
                                    style: kMySubTitle2,
                                  ),
                                  Text(
                                    'Following',
                                    style: kMySubTitle1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                child: Text(
                                  'ADD PHOTOS  ',
                                ),
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.015,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                pushOnly(
                                  context: context,
                                  route: EditProfileScreen(),
                                );
                              },
                              child: Icon(
                                Icons.edit_outlined,
                                size: 14,
                              ),
                            ),
                          ],
                        )),
                    IconButton(
                      onPressed: () {
                        signOut(context);
                      },
                      icon: Icon(
                        Icons.logout_outlined,
                        color: kDefaultColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

// Widget myButton(var size) => MaterialButton(
//       height: size.height * 0.055,
//       color: kDefaultColor,
//       minWidth: double.infinity,
//       onPressed: () {},
//       child: Text(
//         'EDIT PROFILE',
//         style: TextStyle(
//           color: Colors.white,
//         ),
//       ),
//     );
