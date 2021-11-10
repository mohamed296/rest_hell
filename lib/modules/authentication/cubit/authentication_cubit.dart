import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_hell/model/user_model.dart';
import 'package:rest_hell/modules/authentication/cubit/authentication_state.dart';
import 'package:rest_hell/shared/service/local/sherd_helper.dart';
import 'package:rest_hell/shared/widget/constant.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInatioalState());
  static AuthCubit get(context) => BlocProvider.of(context);
  bool isLogin = true;
  void changeAuth() {
    isLogin = !isLogin;
    emit(ChangeAuth());
  }

  bool isShow = true;
  IconData? showICon = Icons.visibility;
  void showPassword() {
    isShow = !isShow;
    showICon = isShow ? Icons.visibility : Icons.visibility_off;
    emit(ShowPassword());
  }

  void register(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    emit(AuthLodingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreat(name: name, email: email, uid: value.user!.uid, phone: phone);
      SherdHelper.saveData(key: "uId", value: value.user!.uid).then((e) {
        userId = value.user!.uid;
      });
    }).catchError((e) {
      log(e.toString());
      emit(AuthErrorState(error: e.toString()));
    });
  }

  void userCreat(
      {required String name,
      required String email,
      required String uid,
      required String phone}) {
    emit(UserLodingState());
    UserModel model = UserModel(
        name: name,
        email: email,
        id: uid,
        phone: phone,
        followers: 0,
        photos: 0,
        image:
            "https://image.freepik.com/free-icon/important-person_318-10744.jpg",
        bio: "write bio....");
    FirebaseFirestore.instance
        .collection("user")
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(UserScassesState());
    }).catchError((e) {
      log(e.toString());
      emit(UserErrorState(error: e.toString()));
    });
  }

  void login({required String email, required String password}) {
    emit(AuthLodingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      SherdHelper.saveData(key: "uId", value: value.user!.uid).then((e) {
        userId = value.user!.uid;
        emit(AuthScassesState());
      });
    }).catchError((e) {
      log(e.toString());
      emit(AuthErrorState(error: e.toString()));
    });
  }
}
