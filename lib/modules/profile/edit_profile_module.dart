import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_hell/model/user_model.dart';
import 'package:rest_hell/layout/cubit/social_cubit.dart';
import 'package:rest_hell/layout/cubit/social_state.dart';
import 'package:rest_hell/shared/widget/widgets.dart';

class EditProfileModule extends StatefulWidget {
  const EditProfileModule({Key? key}) : super(key: key);

  @override
  State<EditProfileModule> createState() => _EditProfileModuleState();
}

class _EditProfileModuleState extends State<EditProfileModule> {
  final TextEditingController nameControler = TextEditingController();
  final TextEditingController phoneControler = TextEditingController();
  final TextEditingController bioControler = TextEditingController();
  var keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        if (state is UpDataUserScussesState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        UserModel userModel = SocialCubit.get(context).uModel!;
        var image = SocialCubit.get(context).imagePath;

        return Scaffold(
          appBar: AppBar(),
          body: Stack(
            children: [
              Container(
                height: size * 0.5,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                transform: Matrix4.rotationZ(0.8),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(size * 0.03),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size * 0.1,
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey,
                              child: Container(
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: image != ''
                                    ? SizedBox(
                                        width: 120,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.file(
                                              File(image),
                                              fit: BoxFit.cover,
                                            )),
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image(
                                          image: NetworkImage(userModel.image!),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                SocialCubit.get(context).getImage();
                              },
                              icon: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20,
                                child: CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  radius: 14,
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: size * 0.03,
                      ),
                      defoletTextForm(
                        context: context,
                        controller: nameControler,
                        hint: userModel.name,
                        validat: (value) {
                          if (value!.isEmpty) {
                            return "Pelese enter your name";
                          }
                          return null;
                        },
                        type: TextInputType.name,
                        label: "Name",
                        pIcon: Icons.person,
                      ),
                      SizedBox(
                        height: size * 0.01,
                      ),
                      defoletTextForm(
                        context: context,
                        controller: phoneControler,
                        hint: userModel.phone,
                        validat: (value) {
                          if (value!.isEmpty) {
                            return "Pelese enter your phone";
                          }
                          return null;
                        },
                        type: TextInputType.number,
                        label: "Phone",
                        pIcon: Icons.phone,
                      ),
                      SizedBox(
                        height: size * 0.01,
                      ),
                      defoletTextForm(
                        context: context,
                        controller: bioControler,
                        hint: userModel.bio,
                        validat: (value) {
                          if (value!.isEmpty) {
                            return "Pelese enter your bio";
                          }
                          return null;
                        },
                        type: TextInputType.text,
                        label: "Bio",
                        pIcon: Icons.menu,
                      ),
                      SizedBox(
                        height: size * 0.01,
                      ),
                      SizedBox(
                          width: size * 0.2,
                          child: defoltElvationBottom(
                              onTap: () {
                                if (image == "") {
                                  SocialCubit.get(context).upDataUser(
                                      name: nameControler.text,
                                      phone: phoneControler.text,
                                      bio: bioControler.text);
                                } else {
                                  SocialCubit.get(context).upLoadImage(
                                      name: nameControler.text,
                                      phone: phoneControler.text,
                                      bio: bioControler.text);
                                }
                              },
                              text: "Up Data")),
                      SizedBox(
                        height: size * 0.02,
                      ),
                      if (state is UpLoadImageProfileLodingState)
                        SizedBox(
                          width: size * 0.3,
                          child: const LinearProgressIndicator(),
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
