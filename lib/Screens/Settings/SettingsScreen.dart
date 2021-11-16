import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_app/Components/Constants.dart';
import 'package:social_app/Components/MyButton.dart';
import 'package:social_app/Cubit/Cubit/SocialCubit.dart';
import 'package:social_app/Cubit/Cubit/SocialStates.dart';
import 'package:social_app/Models/PostModel.dart';
import 'package:social_app/Screens/EditProfile/EditProfile.dart';
import 'package:social_app/Screens/NewPost/NewPostScreen.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Future<void> refresh() async {
      SocialCubit.getCubit(context).getPosts();
      return Future.delayed(Duration(seconds: 1));
    }

    // SocialCubit.getCubit(context).userGetData();

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.getCubit(context).model;

        return BuildCondition(
          condition: userModel != null,
          builder: (context) {
            return RefreshIndicator(
              onRefresh: () {
                return refresh();
              },
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
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
                                    '${SocialCubit.getCubit(context).myPosts.length}',
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
                          left: 8.0,
                          right: 8.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                child: Text(
                                  'ADD POST  ',
                                ),
                                onPressed: () {
                                  pushOnly(
                                      context: context, route: NewPostScreen());
                                },
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
                    BuildCondition(
                      condition:
                          SocialCubit.getCubit(context).myPosts.isNotEmpty,
                      builder: (context) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => bulidMyPostItem(
                            SocialCubit.getCubit(context).myPosts[index],
                            context,
                            index,
                          ),
                          itemCount:
                              SocialCubit.getCubit(context).myPosts.length,
                          separatorBuilder: (context, index) => SizedBox(
                            height: 8.0,
                          ),
                        );
                      },
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                    MyButton(
                      text: ' SIGN OUT',
                      color: kDefaultColor,
                      press: () {
                        signOut(context);
                      },
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

Widget bulidMyPostItem(PostModel model, context, index) {
  var size = MediaQuery.of(context).size;
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    elevation: 5.0,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  '${model.image}',
                ),
                radius: 25,
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${model.name}',
                        style: kMySubTitle1,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Icon(
                        Icons.check_circle,
                        color: kDefaultColor,
                        size: 16,
                      ),
                    ],
                  ),
                  Text(
                    '${model.dataTime}',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          height: 1.4,
                        ),
                  ),
                ],
              )),
              SizedBox(
                width: 15.0,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_horiz,
                  size: 16,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: kMySubTitle1,
          ),
          if (model.postImage != '')
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      4.0,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${model.postImage}',
                      ),
                      fit: BoxFit.cover,
                    )),
                width: double.infinity,
                height: size.height * 0.4,
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Icon(
                            MdiIcons.heartOutline,
                            color: Colors.red,
                            size: 16.0,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${SocialCubit.getCubit(context).myPostsLikes[index]}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      // SocialCubit.getCubit(context).likePost(model.uId);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            MdiIcons.messageTextOutline,
                            color: Colors.red,
                            size: 16.0,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '0',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      // SocialCubit.getCubit(context).likePost(
                      //     SocialCubit.getCubit(context).postId[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 8.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            '${SocialCubit.getCubit(context).model!.image}', //this model is the user that use the application now
                          ),
                          radius: 18,
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          'write your comment',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                height: 1.4,
                              ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // SocialCubit.getCubit(context).getUsersWhoLike(
                      //     SocialCubit.getCubit(context).postId[index]);
                    },
                  ),
                ),
                SizedBox(
                  height: double.infinity,
                  child: InkWell(
                    child: Row(
                      children: [
                        Icon(
                          MdiIcons.heartOutline,
                          color: Colors.red,
                          size: 16.0,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {
                      SocialCubit.getCubit(context).likePost(
                          SocialCubit.getCubit(context).myPostsId[index]);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
