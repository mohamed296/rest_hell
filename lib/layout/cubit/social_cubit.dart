import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rest_hell/model/chat_model.dart';
import 'package:rest_hell/model/post_model.dart';
import 'package:rest_hell/model/user_model.dart';
import 'package:rest_hell/modules/chat/chat_modules.dart';
import 'package:rest_hell/modules/home/home_modules.dart';
import 'package:rest_hell/modules/profile/profil_module.dart';
import 'package:rest_hell/layout/cubit/social_state.dart';
import 'package:rest_hell/shared/widget/constant.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInatioalState());
  static SocialCubit get(context) => BlocProvider.of(context);

  void ref({required Widget widget}) {
    RestartWidget(
      child: widget,
    );
    emit(RefScreanState());
  }

  int curentIndex = 0;
  List<Widget> screans = [
    const HomeModules(),
    const ChatModules(),
    const ProfilModule(),
  ];
  List<String> title = ["Home", "Chat", "Profil"];
  void changeScrean(int index) {
    curentIndex = index;
    if (index == 1) getUsers();
    if (index == 2) getInfUser();
    screans[index];
    title[index];
    emit(SocialChangeScreanState());
  }

  UserModel? uModel;
  void getInfUser() {
    log(userId.toString());
    emit(UserInfoLodingState());

    FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .get()
        .then((value) {
      uModel = UserModel.fromJson(value.data()!);
      log(value.data().toString());
      emit(UpDataUserScussesState());
      emit(UserInfoScassesState());
    }).catchError((e) {
      log(e.toString());
      emit(UserInfoErrorState(error: e.toString()));
    });
  }

  var picker = ImagePicker();
  XFile? imageProfile;
  String imagePath = "";

  void getImage() async {
    emit(ImageProfileLodingState());
    imageProfile =
        await picker.pickImage(source: ImageSource.gallery).then((value) async {
      imagePath = value!.path;
      log(imagePath);

      emit(ImageProfileScussesState());
    }).catchError((e) {
      emit(ImageProfileErrorState(error: e.toString()));
    });
  }

  void removeImage() {
    imagePath = '';
    emit(RemoveImageScussesState());
  }

  void upLoadImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UpLoadImageProfileLodingState());
    firebase_storage.FirebaseStorage.instance
        .ref('user/${Uri.file(imagePath).pathSegments.last}')
        .putFile(
          File(imagePath),
        )
        .then((value) {
      value.ref
          .getDownloadURL()
          .then((value) =>
              upDataUser(name: name, phone: phone, image: value, bio: bio))
          .catchError((e) {
        emit(UpLoadImageProfileErrorState(error: e.toString()));
      });
    }).catchError((e) {
      emit(UpLoadImageProfileErrorState(error: e.toString()));
    });
  }

  void upDataUser({
    required String? name,
    required String? phone,
    String? image,
    required String? bio,
  }) {
    emit(UpDataUserLodingState());
    UserModel userModel = UserModel(
        name: name == '' ? uModel!.name : name,
        email: uModel!.email,
        id: uModel!.id,
        phone: phone == '' ? uModel!.phone : phone,
        image: image ??
            uModel!.image ??
            "https://image.freepik.com/free-icon/important-person_318-10744.jpg",
        bio: bio == '' ? uModel!.bio : bio,
        followers: uModel!.followers,
        photos: uModel!.photos);
    FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .update(userModel.toMap())
        .then((value) => getInfUser())
        .catchError((e) {
      emit(UpDataUserErrorState(error: e.toString()));
    });
  }

  void creatPost({
    required String title,
    String? postImage,
  }) {
    emit(CreatPostLodingState());
    PostModel pModel = PostModel(
        id: uModel!.id,
        name: uModel!.name,
        imageProfile: uModel!.image,
        postTitle: title,
        imagePost: postImage ?? '',
        dateTime: DateTime.now().toString());
    FirebaseFirestore.instance
        .collection('posts')
        .add(pModel.toMap())
        .then((value) {
      posts = [];
      postId = [];
      getPosts();
    }).catchError((e) {
      emit(CreatPostErrorState(error: e.toString()));
    });
  }

  void upLoadPostImage({required String title}) {
    emit(UpLoadImagePostLodingState());
    firebase_storage.FirebaseStorage.instance
        .ref('posts/${Uri.file(imagePath).pathSegments.last}')
        .putFile(
          File(imagePath),
        )
        .then((value) => value.ref.getDownloadURL().then((value) {
              creatPost(title: title, postImage: value);
            }).catchError((e) {
              emit(CreatPostErrorState(error: e.toString()));
            }))
        .catchError((e) {
      emit(CreatPostErrorState(error: e.toString()));
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  void getPosts() {
    emit(GetPostsLodingState());

    FirebaseFirestore.instance
        .collection('posts')
        .orderBy("dateTime", descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        postId.add(element.id);
        posts.add(PostModel.fromJson(element.data()));

        // getLikes(postId: element.id);
      }
      emit(GetPostsScassesState());
    }).catchError((e) {
      log(e.toString());
      emit(GetPostsErrorState(error: e.toString()));
    });
  }

  // bool isLike = false;
  // void changeLike() {
  //   isLike = !isLike;
  // }

  // List lisks = [];

  // void creatLikes({required String postId}) {
  //   LikeModel likeModel = LikeModel(
  //       id: uModel!.id,
  //       name: uModel!.name,
  //       imageProfile: uModel!.image,
  //       postId: postId,
  //       isLike: isLike,
  //       dateTime: "${DateTime.now()}");
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(postId)
  //       .collection("likes")
  //       .doc(uModel!.id)
  //       .set(likeModel.toMap())
  //       .then((value) {
  //     changeLike();
  //     getLikes(postId: postId);
  //     emit(LikesScassesState());
  //   }).catchError((e) {
  //     emit(LikesErrorState(error: e.toString()));
  //   });
  // }

  // void getLikes({required String postId}) {
  //   lisks = [];
  //   emit(GetLiksLodingState());

  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(postId)
  //       .collection('likes')
  //       .get()
  //       .then((value) {
  //     for (var element in value.docs) {
  //       lisks.add({postId: LikeModel.fromJson(element.data())});
  //     }
  //     emit(GetLikesScassesState());
  //   }).catchError((e) {
  //     emit(GetLikesErrorState(error: e.toString()));
  //   });
  // }

  List<UserModel> users = [];
  void getUsers() {
    emit(GetUsersLodingState());

    FirebaseFirestore.instance.collection('user').get().then((value) {
      users = [];
      for (var element in value.docs) {
        if (element.data()['id'] != uModel!.id) {
          users.add(UserModel.fromJson(element.data()));
        }
      }
      emit(GetUsersScassesState());
    }).catchError((e) {
      log(e.toString());
      emit(GetUsersErrorState(error: e.toString()));
    });
  }

  void creatMassage({required String reseverId, required String text}) {
    emit(CreatMassegeLodingState());
    MassegeModel mModel = MassegeModel(
        senderId: uModel!.id,
        text: text,
        reseverId: reseverId,
        dateTime: DateTime.now().toString());
    FirebaseFirestore.instance
        .collection("user")
        .doc(uModel!.id)
        .collection("chat")
        .doc(reseverId)
        .collection("massages")
        .add(mModel.toMap())
        .then((value) {
      emit(CreatMassegeScassesState());
    }).catchError((e) {
      emit(CreatMassegeErrorState(error: e.toString()));
    });

    FirebaseFirestore.instance
        .collection("user")
        .doc(reseverId)
        .collection("chat")
        .doc(uModel!.id)
        .collection("massages")
        .add(mModel.toMap())
        .then((value) {
      emit(CreatMassegeScassesState());
    }).catchError((e) {
      emit(CreatMassegeErrorState(error: e.toString()));
    });
  }

  List<MassegeModel> massages = [];
  void getMasseges({required String reseverId}) {
    FirebaseFirestore.instance
        .collection("user")
        .doc(uModel!.id)
        .collection("chat")
        .doc(reseverId)
        .collection("massages")
        .orderBy("dateTime", descending: true)
        .snapshots()
        .listen((event) {
      massages = [];
      for (var e in event.docs) {
        massages.add(MassegeModel.fromJson(e.data()));
      }
      emit(GetMassegeScassesState());
    });
  }
}
