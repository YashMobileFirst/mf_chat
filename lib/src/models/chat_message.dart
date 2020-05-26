part of mfchat;

class ChatMessage {
  String id;
  String text;
  DateTime createdAt;
  ChatUser user;
  String image;
  String video;

//  Map<String, dynamic> customProperties;

  List<Widget> buttons;

  ChatMessage(
      {String id,
      @required this.text,
      @required this.user,
      DateTime createdAt,
      this.buttons}) {
    this.createdAt = createdAt != null ? createdAt : DateTime.now();
    this.id = id != null ? id : Uuid().v4().toString();
  }

  ChatMessage.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    text = json['text'];
    createdAt = DateTime.fromMillisecondsSinceEpoch(json['createdAt']);
    user = ChatUser.fromJson(json['user']);
//    customProperties = json['customProperties'] as Map<String, dynamic>;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    try {
      data['id'] = this.id;
      data['text'] = this.text;
      data['createdAt'] = this.createdAt.millisecondsSinceEpoch;
      data['user'] = user.toJson();
    } catch (e, stack) {
      print('ERROR caught when trying to convert ChatMessage to JSON:');
      print(e);
      print(stack);
    }
    return data;
  }
}
