import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_hell/layout/cubit/social_cubit.dart';
import 'package:rest_hell/layout/cubit/social_state.dart';
import 'package:rest_hell/model/chat_model.dart';

import 'package:rest_hell/model/user_model.dart';

class ChatDetalis extends StatelessWidget {
  ChatDetalis({
    Key? key,
    this.model,
  }) : super(key: key);
  final UserModel? model;
  final TextEditingController massageController = TextEditingController();
  var listConteroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      SocialCubit.get(context).getMasseges(reseverId: model!.id!);
      return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context).massages;
          return Scaffold(
            appBar: AppBar(
              title: ListTile(
                leading: CircleAvatar(
                  maxRadius: 25,
                  backgroundImage: NetworkImage("${model!.image}"),
                ),
                title: Text(model!.name!),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: ListView.separated(
                        controller: listConteroller,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return SocialCubit.get(context).uModel!.id! ==
                                  cubit[index].senderId
                              ? senderMassage(cubit[index], context)
                              : reseverMassage(cubit[index], context);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 15.0,
                          );
                        },
                        itemCount: cubit.length),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: textfiled(context),
                      ),
                      IconButton(
                          onPressed: () {
                            SocialCubit.get(context).creatMassage(
                                reseverId: model!.id!,
                                text: massageController.text);
                            massageController.clear();
                          },
                          icon: Icon(
                            Icons.send,
                            color: Theme.of(context).colorScheme.primary,
                            size: 35.0,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget reseverMassage(MassegeModel model, context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.6)),
        child: Text(model.text!),
      ),
    );
  }

  Widget senderMassage(MassegeModel model, context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
        child: Text(model.text!),
      ),
    );
  }

  Widget textfiled(context) {
    return TextFormField(
      controller: massageController,
      maxLines: 6,
      minLines: 1,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                width: 3.0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                width: 3.0)),
        fillColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
        filled: true,
        hintText: "send massege ......",
      ),
    );
  }
}
