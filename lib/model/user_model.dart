class UserModel {
  String? name;
  String? email;
  String? id;
  String? phone;
  String? image;
  String? bio;
  int? followers;
  int? photos;
  UserModel({
    required this.name,
    required this.email,
    required this.id,
    required this.phone,
    required this.image,
    required this.bio,
    required this.followers,
    required this.photos,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    id = json['id'];
    phone = json['phone'];
    image = json['image'];
    bio = json['bio'];
    followers = json['followers'];
    photos = json['photos'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'id': id,
      'phone': phone,
      'image': image,
      'bio': bio,
      'followers': followers,
      'photos': photos,
    };
  }
}
