abstract class SocialState {}

class SocialInatioalState extends SocialState {}

class RefScreanState extends SocialState {}

class SocialChangeScreanState extends SocialState {}

class UserInfoLodingState extends SocialState {}

class UserInfoScassesState extends SocialState {}

class UserInfoErrorState extends SocialState {
  String error;
  UserInfoErrorState({
    required this.error,
  });
}

class GetPostsLodingState extends SocialState {}

class GetPostsScassesState extends SocialState {}

class GetPostsErrorState extends SocialState {
  String error;
  GetPostsErrorState({
    required this.error,
  });
}

class GetUsersLodingState extends SocialState {}

class GetUsersScassesState extends SocialState {}

class GetUsersErrorState extends SocialState {
  String error;
  GetUsersErrorState({
    required this.error,
  });
}

class ImageProfileLodingState extends SocialState {}

class ImageProfileScussesState extends SocialState {}

class ImageProfileErrorState extends SocialState {
  String error;
  ImageProfileErrorState({
    required this.error,
  });
}

class UpLoadImageProfileLodingState extends SocialState {}

class UpLoadImageProfileScussesState extends SocialState {}

class UpLoadImageProfileErrorState extends SocialState {
  String error;
  UpLoadImageProfileErrorState({
    required this.error,
  });
}

class RemoveImageScussesState extends SocialState {}

class UpDataUserLodingState extends SocialState {}

class UpDataUserScussesState extends SocialState {}

class UpDataUserErrorState extends SocialState {
  String error;
  UpDataUserErrorState({
    required this.error,
  });
}

class CreatPostLodingState extends SocialState {}

class CreatPostScussesState extends SocialState {}

class CreatPostErrorState extends SocialState {
  String error;
  CreatPostErrorState({
    required this.error,
  });
}

class UpLoadImagePostLodingState extends SocialState {}

class LikesScassesState extends SocialState {}

class LikesErrorState extends SocialState {
  String error;
  LikesErrorState({
    required this.error,
  });
}

class GetLiksLodingState extends SocialState {}

class GetLikesScassesState extends SocialState {}

class GetLikesErrorState extends SocialState {
  String error;
  GetLikesErrorState({
    required this.error,
  });
}

class CreatMassegeLodingState extends SocialState {}

class CreatMassegeScassesState extends SocialState {}

class CreatMassegeErrorState extends SocialState {
  String error;
  CreatMassegeErrorState({
    required this.error,
  });
}

class GetMassegeScassesState extends SocialState {}
