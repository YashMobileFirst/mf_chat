part of mfchat;

class MFChat extends StatefulWidget {
  final List<ChatMessage> messages;
  final String text;
  final ChatUser user;
  final Function(ChatMessage) onSend;
  final Widget Function(ChatMessage) messageBuilder;
  final Widget Function(String, [ChatMessage]) messageTextBuilder;

  MFChat({
    Key key,
    @required this.messages,
    this.text,
    @required this.user,
    @required this.onSend,
    this.messageBuilder,
    this.messageTextBuilder,
  }) : super(key: key);

  @override
  _MFChatState createState() => _MFChatState();
}

class _MFChatState extends State<MFChat> {
  String _text = "";
  bool visible = false;
  double height = 48.0;
  bool showLoadMore = false;

  String get messageInput => _text;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final maxWidth = constraints.maxWidth == double.infinity
          ? MediaQuery.of(context).size.width
          : constraints.maxWidth;
      final maxHeight = constraints.maxWidth == double.infinity
          ? MediaQuery.of(context).size.height
          : constraints.maxHeight;

      return Container(
        height: maxHeight,
        width: maxWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MessageListView(
              user: widget.user,
              messages: widget.messages,
              messageBuilder: widget.messageBuilder,
              messageTextBuilder: widget.messageTextBuilder,
            ),
            ChatInputToolbar(
              onSend: widget.onSend,
              user: widget.user,
              text: widget.text != null ? widget.text : _text,
            )
          ],
        ),
      );
    });
  }
}
