import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rest_hell/layout/social_layout.dart';
import 'package:rest_hell/modules/authentication/Login/login_card.dart';
import 'package:rest_hell/modules/authentication/cubit/authentication_cubit.dart';
import 'package:rest_hell/modules/authentication/cubit/authentication_state.dart';
import 'package:rest_hell/shared/widget/widgets.dart';

class LoginModule extends StatelessWidget {
  const LoginModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double widht = MediaQuery.of(context).size.width;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          showSnakBar(state.error.toString(), context);
        }
        if (state is AuthScassesState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const HomeLayout(),
            ),
          );
        }
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      height: height,
                      width: widht,
                      color: const Color(0xffFCD1D1),
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                      height: height,
                      width: widht,
                      color: const Color(0xffAEE1E1),
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: height * 0.12,
                  left: height * 0.22,
                  right: height * 0.03),
              child: SvgPicture.asset(
                'assets/images/Login.svg',
                height: height * 0.12,
                width: widht * 0.2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.13,
                    ),
                    Text(
                      "LOGIN",
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: Colors.white.withOpacity(0.9)),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Card(
                      color: Colors.white.withOpacity(0.6),
                      elevation: 0.0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(100),
                          bottomLeft: Radius.circular(100),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(height * 0.03),
                        child: LoginCard(
                          cubit: cubit,
                          state: state,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
