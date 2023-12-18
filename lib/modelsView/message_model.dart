class Message {
  String? sender;
  DateTime? time; // Would usually be type DateTime or Firebase Timestamp in production apps
  String? text;
  bool? isLiked;
  bool? unread;
  String? des;

  Message({
    required this.sender,
    required this.time,
    required this.text,
    this.isLiked,
    this.unread,
    required this.des,
  });

  Message.fromJson(Map<String, dynamic> json) {
    sender = json['sender'];
    //time = json['time'];
    text = json['text'];
    isLiked = json['is_liked'];
    unread = json['unread'];
    des = json['des'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['sender'] = sender;
    data['time'] = time;
    data['text'] = text;
    data['is_liked'] = isLiked;
    data['unread'] = unread;
    data['des'] = des;
    return data;
  }


}
