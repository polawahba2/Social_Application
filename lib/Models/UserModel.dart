class UserModel {
  String? uId;
  String? phone = '';
  bool? isVerified;
  String? name;
  String? email;
  String? bio;
  String? cover =
      'https://image.freepik.com/free-photo/embarrassed-shocked-european-man-points-index-finger-copy-space-recommends-service-shows-new-product-keeps-mouth-widely-opened-from-surprisement_273609-38455.jpg';

  String? image =
      'https://image.freepik.com/free-vector/mysterious-mafia-man-smoking-cigarette_52683-34828.jpg';

  UserModel({
    this.uId,
    this.phone,
    this.isVerified,
    this.name,
    this.email,
    this.bio,
    this.cover,
    this.image,
  });
  UserModel.fromJson(Map<String, dynamic>? json) {
    {
      uId = json!['uId'];
      phone = json['phone'];
      isVerified = json['isVerified'];
      name = json['name'];
      email = json['email'];
      bio = json['bio'];
      cover = json['cover'];
      image = json['image'];
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'phone': phone,
      'isVerified': isVerified,
      'name': name,
      'email': email,
      'cover': cover,
      'image': image,
      'bio': bio,
    };
  }
}
