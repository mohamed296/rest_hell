import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:rest_hell/modules/authentication/cubit/authentication_cubit.dart';
import 'package:rest_hell/modules/authentication/cubit/authentication_state.dart';
import 'package:rest_hell/shared/widget/widgets.dart';

class LoginCard extends StatefulWidget {
  final AuthCubit cubit;
  final AuthState state;

  const LoginCard({
    Key? key,
    required this.cubit,
    required this.state,
  }) : super(key: key);

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final keyForm = GlobalKey<FormState>();

  final TextEditingController emailControler = TextEditingController();

  final TextEditingController passwordControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double widht = MediaQuery.of(context).size.width;
    return Form(
      key: keyForm,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.04,
          ),
          defoletTextForm(
            controller: emailControler,
            validat: (String? value) {
              if (value!.isEmpty) {
                return "Pleas Enter Your Email";
              }
              return null;
            },
            type: TextInputType.emailAddress,
            label: "Email ",
            pIcon: Icons.email,
            isShow: false,
            context: context,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          defoletTextForm(
              controller: passwordControler,
              validat: (String? value) {
                if (value!.isEmpty) {
                  return "Pleas Enter Your Password";
                }
                return null;
              },
              type: TextInputType.emailAddress,
              label: "Password ",
              pIcon: Icons.lock,
              sIcon: widget.cubit.showICon,
              isShow: widget.cubit.isShow,
              sOnTap: () {
                widget.cubit.showPassword();
              },
              context: context),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "New On RestHall?",
                style: TextStyle(color: Colors.green[900]),
              ),
              defoltTextBottom(
                  onTap: () {
                    widget.cubit.changeAuth();
                  },
                  text: "Create an Account")
            ],
          ),
          SizedBox(
            width: widht * 0.4,
            child: widget.state is! AuthLodingState
                ? defoltElvationBottom(
                    onTap: () {
                      if (keyForm.currentState!.validate()) {
                        widget.cubit.login(
                            email: emailControler.text,
                            password: passwordControler.text);
                        Phoenix.rebirth(context);
                      }
                    },
                    text: "Login")
                : LinearProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
          ),
        ],
      ),
    );
  }
}
