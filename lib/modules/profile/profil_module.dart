import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_hell/model/user_model.dart';
import 'package:rest_hell/modules/authentication/authentication.dart';
import 'package:rest_hell/modules/profile/edit_profile_module.dart';
import 'package:rest_hell/layout/cubit/social_cubit.dart';
import 'package:rest_hell/layout/cubit/social_state.dart';
import 'package:rest_hell/shared/service/local/sherd_helper.dart';
import 'package:rest_hell/shared/widget/widgets.dart';

class ProfilModule extends StatelessWidget {
  const ProfilModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).uModel;
        return Stack(
          children: [
            Container(
              height: size * 0.5,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
              transform: Matrix4.rotationZ(0.8),
            ),
            Container(
              height: size,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
              transform: Matrix4.rotationZ(-0.77),
            ),
            userModel != null
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size * 0.15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "${userModel.followers}",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(
                                  "Followers",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                        color: Colors.grey,
                                        fontSize: 16.0,
                                      ),
                                ),
                              ],
                            ),
                            CircleAvatar(
                              radius: 65,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.grey,
                                backgroundImage: NetworkImage(userModel.image!),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "${userModel.photos}",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(
                                  "PHOTOS",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                        color: Colors.grey,
                                        fontSize: 16.0,
                                      ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size * 0.02,
                        ),
                        Text(
                          userModel.name!,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          userModel.bio!,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 14.0),
                        ),
                        SizedBox(
                          height: size * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: size * 0.1,
                              child: OutlinedButton(
                                onPressed: () {
                                  SherdHelper.deletData(key: "uId")
                                      .then((value) {
                                    log("scasses deleted");
                                    UserModel.fromJson({'id': null});
                                    navigateaAndFinsh(
                                      context,
                                      const Authentication(),
                                    );
                                  });
                                },
                                child: const Text(
                                  "Log Out",
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  padding: const EdgeInsets.all(16.0),
                                ),
                              ),
                            ),
                            SizedBox(
                                width: size * 0.3,
                                child: defoltElvationBottom(
                                    onTap: () {
                                      navigateTo(
                                          context, const EditProfileModule());
                                    },
                                    text: "Edit Profile")),
                          ],
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        );
      },
    );
  }
}
