import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_hell/layout/cubit/social_cubit.dart';
import 'package:rest_hell/layout/cubit/social_state.dart';
import 'package:rest_hell/modules/chat/chat_detalis_modules.dart';
import 'package:rest_hell/shared/widget/widgets.dart';

class ChatModules extends StatelessWidget {
  const ChatModules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context).users;
        return ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListTile(
                  leading: CircleAvatar(
                    maxRadius: 25,
                    backgroundImage: NetworkImage("${cubit[index].image}"),
                  ),
                  title: Text(cubit[index].name!),
                  trailing: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_horiz)),
                  onTap: () {
                    navigateTo(
                        context,
                        ChatDetalis(
                          model: cubit[index],
                        ));
                  },
                ),
              );
            },
            separatorBuilder: (context, intex) {
              return Container(
                margin: const EdgeInsets.only(left: 40),
                height: 1,
                color: Colors.green.withOpacity(0.5),
              );
            },
            itemCount: cubit.length);
      },
    );
  }
}
