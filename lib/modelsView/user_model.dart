class UserModel {
  String? uid;
  String? name;
  String? photo;
  String? email;
  String? status;
  bool? isOnline;
  List<dynamic> friends = [];

  UserModel({
    required this.uid,
    this.name,
    this.photo,
    this.isOnline = false,
    this.friends = const [],
    this.email,
    this.status,
  });

  void fromJsonData(Map<String, dynamic> data) {
    uid = data['uid'];
    name = data['name'];
    photo= data['photo'];
    isOnline = data['is_online'];
    status = data['status'];
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
    status = data['status'];
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
  String? status;

  UserContactModel({required this.uid, required this.name, required this.photo,required this.isOnline,this.status});

  void fromJsonData(Map<String, dynamic> data) {
    uid = data['uid'];
    name = data['name'];
    photo = data['photo'];
    isOnline = data['is_online'] ?? false;
    status = data['status'] ?? "";
  }

  UserContactModel.fromJson(Map<String, dynamic> data) {
    uid = data['uid'];
    name = data['name'] ?? "";
    data['photo'] != null ? photo = data['photo'] : '';
    data['is_online'] ?? false;
    status = data['status'];
  }


}