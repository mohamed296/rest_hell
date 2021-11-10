import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:rest_hell/layout/social_layout.dart';

import 'package:rest_hell/modules/authentication/authentication.dart';
import 'package:rest_hell/layout/cubit/social_cubit.dart';
import 'package:rest_hell/shared/provider/app_cubut.dart';
import 'package:rest_hell/shared/provider/app_state.dart';
import 'package:rest_hell/shared/service/local/sherd_helper.dart';
import 'package:rest_hell/shared/service/network/dio_helper.dart';
import 'package:rest_hell/shared/style/them_light.dart';
import 'package:rest_hell/shared/widget/constant.dart';

import 'shared/provider/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await SherdHelper.init();
  await Firebase.initializeApp();
  userId = SherdHelper.getData(key: "uId");
  Widget screan;
  if (userId != null) {
    screan = const HomeLayout();
  } else {
    screan = const Authentication();
  }

  runApp(Phoenix(
    child: MyApp(
      screan: screan,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.screan,
  }) : super(key: key);
  final Widget? screan;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
            create: (context) =>
                screan != const HomeLayout() ? SocialCubit() : SocialCubit()
                  ..getInfUser()
                  ..getPosts()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              home: screan);
        },
      ),
    );
  }
}
