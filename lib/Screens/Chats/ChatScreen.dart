import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Components/Constants.dart';
import 'package:social_app/Cubit/Cubit/SocialCubit.dart';
import 'package:social_app/Cubit/Cubit/SocialStates.dart';
import 'package:social_app/Models/UserModel.dart';
import 'package:social_app/Screens/Chats/ChatDetailsScreen.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var myCubit = SocialCubit.getCubit(context);
        return Scaffold(
          body: BuildCondition(
            condition: myCubit.allUsers.length > 0,
            builder: (context) {
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildChatItem(
                    myCubit.allUsers[index],
                    context,
                  );
                },
                separatorBuilder: (context, index) => Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
                itemCount: myCubit.allUsers.length,
              );
            },
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}

Widget buildChatItem(UserModel model, context) => InkWell(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
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
      onTap: () {
        pushOnly(
          context: context,
          route: ChatDetailsScreen(model),
        );
      },
    );
