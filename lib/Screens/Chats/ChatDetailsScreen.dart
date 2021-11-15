import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Components/Constants.dart';
import 'package:social_app/Cubit/Cubit/SocialCubit.dart';
import 'package:social_app/Cubit/Cubit/SocialStates.dart';
import 'package:social_app/Models/MessageModel.dart';
import 'package:social_app/Models/UserModel.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel model;
  ChatDetailsScreen(this.model);
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      SocialCubit.getCubit(context).getMessages(
        reciverId: model.uId,
      );
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Row(
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
                  Text(
                    '${model.name}',
                    style: kMySubTitle1,
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          var message =
                              SocialCubit.getCubit(context).messages[index];
                          if (SocialCubit.getCubit(context).model!.uId ==
                              message.senderId) {
                            return buildMyMessage(message);
                          } else {
                            return buildMessage(message);
                          }
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 15.0,
                        ),
                        itemCount:
                            SocialCubit.getCubit(context).messages.length,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(17.0),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'write your massage here....',
                                  border: InputBorder.none,
                                ),
                                controller: textController,
                              ),
                            ),
                            Container(
                              width: 50,
                              color: kDefaultColor,
                              child: MaterialButton(
                                onPressed: () {
                                  SocialCubit.getCubit(context).sendMessage(
                                    reciverId: model.uId,
                                    dateTime: DateTime.now().toString(),
                                    text: textController.text,
                                  );
                                  textController.text = '';
                                },
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

Widget buildMessage(MessageModel message) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(15.0),
            topStart: Radius.circular(15.0),
            bottomEnd: Radius.circular(15.0),
          ),
          color: Colors.grey[350],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        child: Text(
          '${message.text}',
        ),
      ),
    );

Widget buildMyMessage(MessageModel message) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(15.0),
            topStart: Radius.circular(15.0),
            bottomStart: Radius.circular(15.0),
          ),
          color: Colors.blue,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        child: Text(
          '${message.text}',
        ),
      ),
    );
