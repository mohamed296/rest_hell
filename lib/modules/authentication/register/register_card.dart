import 'package:flutter/material.dart';

import 'package:rest_hell/modules/authentication/cubit/authentication_cubit.dart';
import 'package:rest_hell/modules/authentication/cubit/authentication_state.dart';
import 'package:rest_hell/shared/widget/widgets.dart';

class RegisterCard extends StatefulWidget {
  final AuthCubit cubit;
  final AuthState state;

  const RegisterCard({
    Key? key,
    required this.cubit,
    required this.state,
  }) : super(key: key);

  @override
  State<RegisterCard> createState() => _RegisterCardState();
}

class _RegisterCardState extends State<RegisterCard> {
  final keyForm = GlobalKey<FormState>();

  final TextEditingController nameControler = TextEditingController();

  final TextEditingController emailControler = TextEditingController();

  final TextEditingController passwordControler = TextEditingController();
  final TextEditingController phoneControler = TextEditingController();

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
            context: context,
            controller: nameControler,
            validat: (String? value) {
              if (value!.isEmpty) {
                return "Pleas Enter Your name";
              }
              return null;
            },
            type: TextInputType.name,
            label: "Name ",
            pIcon: Icons.person,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          defoletTextForm(
              context: context,
              controller: emailControler,
              validat: (String? value) {
                if (value!.isEmpty) {
                  return "Pleas Enter Your Email";
                }
                return null;
              },
              type: TextInputType.emailAddress,
              label: "Email ",
              pIcon: Icons.email),
          SizedBox(
            height: height * 0.02,
          ),
          defoletTextForm(
              context: context,
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
              }),
          SizedBox(
            height: height * 0.02,
          ),
          defoletTextForm(
              context: context,
              controller: phoneControler,
              validat: (String? value) {
                if (value!.isEmpty) {
                  return "Pleas Enter Your phone";
                }
                return null;
              },
              type: TextInputType.phone,
              label: "phone ",
              pIcon: Icons.phone),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Aleady have an account?",
                style: TextStyle(color: Colors.green[900]),
              ),
              defoltTextBottom(
                  onTap: () {
                    widget.cubit.changeAuth();
                  },
                  text: "Login")
            ],
          ),
          SizedBox(
            width: widht * 0.4,
            child: widget.state is! AuthLodingState
                ? defoltElvationBottom(
                    onTap: () {
                      if (keyForm.currentState!.validate()) {
                        widget.cubit.register(
                            name: nameControler.text,
                            email: emailControler.text,
                            password: passwordControler.text,
                            phone: phoneControler.text);
                      }
                    },
                    text: "Register")
                : LinearProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
          ),
        ],
      ),
    );
  }
}
