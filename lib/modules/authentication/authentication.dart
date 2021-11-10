import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_hell/modules/authentication/cubit/authentication_cubit.dart';
import 'package:rest_hell/modules/authentication/cubit/authentication_state.dart';
import 'package:rest_hell/modules/authentication/Login/login_module.dart';
import 'package:rest_hell/modules/authentication/register/register_module.dart';

class Authentication extends StatelessWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return Scaffold(
            body: Stack(
              children: [
                AnimatedPositioned(
                  curve: Curves.decelerate,
                  duration: const Duration(milliseconds: 700),
                  right: cubit.isLogin ? 0 : size.width,
                  left: cubit.isLogin ? 0 : -size.width,
                  child: const LoginModule(),
                ),
                AnimatedPositioned(
                  right: !cubit.isLogin ? 0 : -size.width,
                  left: !cubit.isLogin ? 0 : size.width,
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.decelerate,
                  child: const RegisterModule(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
