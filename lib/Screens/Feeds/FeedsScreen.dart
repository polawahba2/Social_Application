import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_app/Components/Constants.dart';
import 'package:social_app/Cubit/Cubit/SocialCubit.dart';
import 'package:social_app/Cubit/Cubit/SocialStates.dart';
import 'package:social_app/Models/PostModel.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> refresh() async {
      SocialCubit.getCubit(context).getPosts();
      return Future.delayed(Duration(seconds: 1));
    }

    var size = MediaQuery.of(context).size;
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BuildCondition(
          condition: SocialCubit.getCubit(context).posts.isNotEmpty &&
              SocialCubit.getCubit(context).model != null,
          builder: (context) {
            return RefreshIndicator(
              onRefresh: () {
                return refresh();
              },
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(5.0),
                      elevation: 5.0,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          Image(
                            image: const NetworkImage(
                              'https://image.freepik.com/free-photo/indignant-puzzled-redhead-woman-raises-palm-thinks-what-answer-received-message-holds-mobile-phone-wears-round-spectacles-hoodie-models-yellow-wall-with-blank-space-right_273609-42106.jpg',
                            ),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: size.height * 0.3,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Communicate with your friends ',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => bulidPostItem(
                        SocialCubit.getCubit(context).posts[index],
                        context,
                        index,
                      ),
                      itemCount: SocialCubit.getCubit(context).posts.length,
                      separatorBuilder: (context, index) => SizedBox(
                        height: 8.0,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              ),
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget bulidPostItem(PostModel model, context, index) {
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
          // Padding(
          //   padding: const EdgeInsets.only(
          //     bottom: 10.0,
          //     top: 5.0,
          //   ),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(
          //             end: 3.0,
          //           ),
          //           child: Container(
          //             height: 20,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1.0,
          //               height: 25,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#software',
          //                 style: TextStyle(
          //                   color: kDefaultColor,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           height: 20,
          //           child: MaterialButton(
          //             onPressed: () {},
          //             minWidth: 1.0,
          //             height: 25,
          //             padding: EdgeInsets.zero,
          //             child: Text(
          //               '#software development ',
          //               style: TextStyle(
          //                 color: kDefaultColor,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
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
                            '${SocialCubit.getCubit(context).likes[index]}',
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
                          SocialCubit.getCubit(context).postId[index]);
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
