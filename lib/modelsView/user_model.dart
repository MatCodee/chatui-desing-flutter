class UserModel {
  String? uid;
  String? name;
  String? photo;
  String? email;
  bool? isOnline;
  List<dynamic> friends = [];

  UserModel({
    required this.uid,
    this.name,
    this.photo,
    this.isOnline = false,
    this.friends = const [],
    this.email,
  });

  void fromJsonData(Map<String, dynamic> data) {
    uid = data['uid'];
    name = data['name'];
    photo= data['photo'];
    isOnline = data['is_online'];
    if (data['friends'] != null && data['friends'] is List) {
      friends = List<String>.from(data['friends']);
    } else {
      friends = [];
    }
  }

  UserModel.fromJson(Map<String, dynamic> data) {
    uid = data['uid'];
    name = data['name'];
    photo= data['photo'];
    isOnline = data['is_online'];
    if (data['friends'] != null && data['friends'] is List) {
      friends = List<String>.from(data['friends']);
    } else {
      friends = [];
    }
  }
}



class UserContactModel {
  String uid = "";
  String name = "";
  String photo = "";
  bool isOnline = false;

  UserContactModel({required this.uid, required this.name, required this.photo,required this.isOnline});

  void fromJsonData(Map<String, dynamic> data) {
    uid = data['uid'];
    name = data['name'];
    photo = data['photo'];
    isOnline = data['is_online'] ?? false;
  }

  UserContactModel.fromJson(Map<String, dynamic> data) {
    uid = data['uid'];
    name = data['name'] ?? "";
    data['photo'] != null ? photo = data['photo'] : '';
    data['is_online'] ?? false;
  }


}