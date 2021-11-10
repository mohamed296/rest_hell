import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_hell/layout/cubit/social_cubit.dart';
import 'package:rest_hell/layout/cubit/social_state.dart';

class HomeModules extends StatelessWidget {
  const HomeModules({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context).posts;
        return cubit.length - 1 > 0 && SocialCubit.get(context).uModel != null
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0.0,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    margin: EdgeInsets.symmetric(
                        vertical: height * 0.01, horizontal: height * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            maxRadius: 25,
                            backgroundImage:
                                NetworkImage("${cubit[index].imageProfile}"),
                          ),
                          title: Text(cubit[index].name!),
                          subtitle: Text(cubit[index].dateTime!),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_horiz)),
                        ),
                        Container(
                          height: 1,
                          color: Colors.green.withOpacity(0.1),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: height * 0.01,
                              horizontal: height * 0.02),
                          child: Text(
                            cubit[index].postTitle!,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        cubit[index].imagePost != ''
                            ? Container(
                                constraints:
                                    BoxConstraints(maxHeight: height * 0.6),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            cubit[index].imagePost!),
                                        fit: BoxFit.cover)),
                              )
                            : SizedBox(height: height * 0.01),
                        Padding(
                          padding: EdgeInsets.all(height * 0.01),
                          child: Row(
                            children: [
                              Expanded(
                                  child: InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.favorite_border,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),

                                    const Text("0"),
                                    //  Text(SocialCubit.get(context)
                                    //     .lisks
                                    //     .length
                                    //     .toString())

                                    const Expanded(child: Text("  Love")),
                                  ],
                                ),
                              )),
                              const Spacer(),
                              Expanded(
                                  child: InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.comment_outlined,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    const Text("10"),
                                    const Text("Comments"),
                                  ],
                                ),
                              )),
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.green[900],
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            maxRadius: 15,
                            backgroundImage: NetworkImage(
                                SocialCubit.get(context).uModel!.image!),
                          ),
                          title: InkWell(
                              onTap: () {},
                              child: Text(
                                "Write a Comment....",
                                style: Theme.of(context).textTheme.caption,
                              )),
                          trailing: IconButton(
                              onPressed: () {
                                // SocialCubit.get(context).creatLikes(
                                //     postId:
                                //         SocialCubit.get(context).postId[index]);
                              },
                              icon: Icon(
                                Icons.favorite_border,
                                color: Theme.of(context).colorScheme.secondary,
                                size: 30,
                              )),
                        ),
                      ],
                    ),
                  );
                })
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
