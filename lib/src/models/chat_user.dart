part of mfchat;

class ChatUser {
  String uid;
  String name;
  String avatar;
  Color color;
  Color containerColor;

  ChatUser({
    String uid,
    this.name,
    this.avatar,
    this.containerColor,
    this.color,
  }) {
    this.uid = uid != null ? uid : Uuid().v4().toString();
  }

  ChatUser.fromJson(Map<dynamic, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    avatar = json['avatar'];
    containerColor =
        json['containerColor'] != null ? Color(json['containerColor']) : null;
    color = json['color'] != null ? Color(json['color']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    try {
      data['uid'] = uid;
      data['name'] = name;
      data['avatar'] = avatar;
      data['containerColor'] =
          containerColor != null ? containerColor.value : null;
      data['color'] = color != null ? color.value : null;
    } catch (e) {
      print(e);
    }

    return data;
  }
}
