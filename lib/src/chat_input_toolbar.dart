part of mfchat;

class ChatInputToolbar extends StatefulWidget {
  final ChatUser user;
  final Function(ChatMessage) onSend;

  ChatInputToolbar({
    Key key,
    this.onSend,
    @required this.user,
  }) : super(key: key);

  @override
  _ChatInputToolbarState createState() => _ChatInputToolbarState();
}

class _ChatInputToolbarState extends State<ChatInputToolbar> {
  TextEditingController _controller = TextEditingController();
  String text = "";

  @override
  Widget build(BuildContext context) {
    ChatMessage message = ChatMessage(
      text: text,
      user: widget.user,
      createdAt: DateTime.now(),
    );

    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration.collapsed(
                      hintText: "Type a Message here..",
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      setState(() {
                        text = value.toString();
                      });
                    },
                    onSubmitted: (value) {
                      setState(() {
                        text = value.toString();
                      });
                      _sendMessage(context, message);
                    },
                    buildCounter: (
                      BuildContext context, {
                      int currentLength,
                      int maxLength,
                      bool isFocused,
                    }) =>
                        null,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: text.isNotEmpty
                    ? () {
                        _sendMessage(context, message);
                      }
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _sendMessage(BuildContext context, ChatMessage message) async {
    _controller.clear();

    if (text.length != 0) {
      await widget.onSend(message);
    }
  }
}
