import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_app/Components/Constants.dart';
import 'package:social_app/Cubit/Cubit/SocialCubit.dart';
import 'package:social_app/Cubit/Cubit/SocialStates.dart';
import 'package:social_app/Screens/NewPost/NewPostScreen.dart';

class HomeLayOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          pushOnly(context: context, route: NewPostScreen());
        }
      },
      builder: (context, state) {
        var myCubit = SocialCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              '${myCubit.appBarTitle[myCubit.currentIndex]}',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.all(9.0),
                child: InkWell(
                  child: Icon(
                    MdiIcons.bellBadgeOutline,
                    color: Colors.black,
                  ),
                  onTap: null,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: InkWell(
                  child: Icon(
                    MdiIcons.magnify,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          body: myCubit.screens[myCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0.0,
            currentIndex: myCubit.currentIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              myCubit.changeButtomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.chatProcessingOutline),
                label: 'chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_a_photo_outlined),
                label: 'Add Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.cogOutline),
                label: 'settings',
              ),
            ],
          ),
        );
      },
    );
  }
}

// if (!FirebaseAuth.instance.currentUser!.emailVerified)
//   Container(
//     width: double.infinity,
//     color: Colors.amber.shade300,
//     height: 50,
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           const Icon(Icons.info_outline),
//           const SizedBox(
//             width: 3,
//           ),
//           const Text('please verify your account'),
//           const Spacer(),
//           TextButton(
//               onPressed: () {
//                 FirebaseAuth.instance.currentUser!
//                     .sendEmailVerification()
//                     .then((value) {
//                   showToast(
//                       text: 'check your mail',
//                       state: ToastStates.SUCESS);
//                 }).catchError((error) {});
//               },
//               child: const Text('verify'))
//         ],
//       ),
//     ),
//   )
