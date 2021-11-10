import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:rest_hell/layout/cubit/social_cubit.dart';
import 'package:rest_hell/layout/cubit/social_state.dart';
import 'package:rest_hell/modules/home/add_post.dart';
import 'package:rest_hell/shared/widget/widgets.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: cubit.title[cubit.curentIndex] != "Profil"
              ? AppBar(
                  title: Text(cubit.title[cubit.curentIndex]),
                  leading: cubit.title[cubit.curentIndex] == "Home"
                      ? IconButton(
                          onPressed: () {
                            navigateTo(context, AddPost());
                          },
                          icon: const Icon(
                            Icons.add_circle_outline,
                            size: 35,
                          ))
                      : null,
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notification_important),
                    ),
                    IconButton(
                      onPressed: () {
                        Phoenix.rebirth(context);
                      },
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                )
              : null,
          body: cubit.screans[cubit.curentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0.0,
            currentIndex: cubit.curentIndex,
            onTap: (index) {
              cubit.changeScrean(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ],
          ),
        );
      },
    );
  }
}
//  FancyBottomNavigation(
//             initialSelection: cubit.curentIndex,
//             tabs: [
//               TabData(iconData: Icons.home, title: "Home"),
//               TabData(iconData: Icons.chat, title: "Chat"),
//               TabData(iconData: Icons.person, title: "Profil")
//             ],
//             onTabChangedListener: (position) {
//               cubit.changeScrean(position);
//             },
//             textColor: Colors.green[900],
//             circleColor: Theme.of(context).colorScheme.primary,
//             inactiveIconColor: Theme.of(context).colorScheme.primary,
//           ),