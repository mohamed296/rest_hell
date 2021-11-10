import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rest_hell/layout/cubit/social_cubit.dart';
import 'package:rest_hell/layout/cubit/social_state.dart';
import 'package:rest_hell/layout/social_layout.dart';
import 'package:rest_hell/shared/widget/widgets.dart';

class AddPost extends StatelessWidget {
  AddPost({Key? key}) : super(key: key);
  final TextEditingController titleControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        if (state is CreatPostScussesState || state is GetPostsScassesState) {
          navigateaAndFinsh(context, const HomeLayout());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                state is UpLoadImagePostLodingState ||
                        State is CreatPostLodingState
                    ? const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: LinearProgressIndicator(),
                      )
                    : const SizedBox(
                        height: 0,
                        width: 0,
                      ),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: titleControler,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "What are you thinking about"),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  flex: 2,
                  child: cubit.imagePath == ''
                      ? SvgPicture.asset(
                          "assets/images/upload_image.svg",
                        )
                      : Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Image.file(File(cubit.imagePath)),
                            IconButton(
                                onPressed: () {
                                  cubit.removeImage();
                                },
                                icon: CircleAvatar(
                                  backgroundColor:
                                      Colors.black.withOpacity(0.6),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                )),
                          ],
                        ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 150.0,
                      child: OutlinedButton(
                        onPressed: () {
                          cubit.getImage();
                        },
                        child: const Text("UpLode Image"),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.all(16.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150.0,
                      child: defoltElvationBottom(
                        onTap: () {
                          if (cubit.imagePath == '') {
                            cubit.creatPost(title: titleControler.text);
                          } else {
                            cubit.upLoadPostImage(title: titleControler.text);
                          }
                        },
                        text: "Add Post",
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
