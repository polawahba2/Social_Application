import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Components/Constants.dart';
import 'package:social_app/Components/Toast.dart';
import 'package:social_app/Cubit/Cubit/SocialCubit.dart';
import 'package:social_app/Cubit/Cubit/SocialStates.dart';

class NewPostScreen extends StatelessWidget {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialCreatePostSucessState) {
          back(context);
          SocialCubit.getCubit(context).removePostImage();
          showToast(
            text: 'Post shared successfully',
            state: ToastStates.SUCESS,
          );
        }
      },
      builder: (context, state) {
        var myCubit = SocialCubit.getCubit(context);
        var postImage = myCubit.postImage;
        var size = MediaQuery.of(context).size;
        var appBarHeight = MediaQuery.of(context).padding.top;
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                back(context);
              },
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(
                  right: 8.0,
                ),
                child: TextButton(
                  child: Text(
                    'post',
                  ),
                  onPressed: () {
                    var timeNow = DateTime.now();
                    if (myCubit.postImage == null) {
                      myCubit.createPost(
                          dataTime: timeNow.toString(),
                          text: textController.text);
                      back(context);
                    } else {
                      myCubit.uploadPostImage(
                        dataTime: timeNow.toString(),
                        text: textController.text,
                      );
                    }
                  },
                ),
              )
            ],
            title: Text(
              'Create Post',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: size.height,
                child: Column(
                  children: [
                    if (state is SocialCreatePostLoadingState)
                      LinearProgressIndicator(),
                    if (state is SocialCreatePostLoadingState)
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            '${SocialCubit.getCubit(context).model!.image}',
                          ),
                          radius: 25,
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          'Pola Wahba ',
                          style: kMySubTitle1,
                        ),
                      ],
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'What is in your mind .....',
                          border: InputBorder.none,
                        ),
                        controller: textController,
                      ),
                    ),
                    if (postImage != null)
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            width: double.infinity,
                            height: size.height * 0.5,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6.0),
                                topRight: Radius.circular(6.0),
                              ),
                            ),
                            child: Image(
                              image: FileImage(postImage),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.red,
                            child: IconButton(
                              onPressed: () {
                                myCubit.removePostImage();
                              },
                              icon: Icon(
                                Icons.close,
                                size: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                myCubit.getPostImage();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.image_outlined,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    'add photo',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                '# tags',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * (appBarHeight / 150),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
