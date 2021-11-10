class PostModel {
  String? id;
  String? name;
  String? imageProfile;
  String? postTitle;
  String? imagePost;
  String? dateTime;
  PostModel({
    required this.id,
    required this.name,
    required this.imageProfile,
    required this.postTitle,
    required this.imagePost,
    required this.dateTime,
  });
  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageProfile = json['imageProfile'];
    postTitle = json['postTitle'];
    imagePost = json['imagePost'];
    dateTime = json['dateTime'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageProfile': imageProfile,
      'postTitle': postTitle,
      'imagePost': imagePost,
      'dateTime': dateTime,
    };
  }
}
