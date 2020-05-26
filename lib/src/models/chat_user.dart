part of mfchat;

class ChatUser {
  String uid;
  String name;
  String avatar;

  ChatUser({
    String uid,
    this.name,
    this.avatar,
  }) {
    this.uid = uid != null ? uid : Uuid().v4().toString();
  }

  ChatUser.fromJson(Map<dynamic, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    try {
      data['uid'] = uid;
      data['name'] = name;
      data['avatar'] = avatar;
    } catch (e) {
      print(e);
    }

    return data;
  }
}
