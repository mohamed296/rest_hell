class LikeModel {
  String? id;
  String? name;
  String? imageProfile;
  String? postId;
  bool? isLike;
  String? dateTime;
  LikeModel({
    required this.id,
    required this.name,
    required this.imageProfile,
    required this.postId,
    required this.isLike,
    required this.dateTime,
  });
  LikeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageProfile = json['imageProfile'];
    postId = json['postId'];
    isLike = json['isLike'];
    dateTime = json['dateTime'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageProfile': imageProfile,
      'postId': postId,
      'isLike': isLike,
      'dateTime': dateTime,
    };
  }
}
