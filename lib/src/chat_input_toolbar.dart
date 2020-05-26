part of mfchat;

class ChatInputToolbar extends StatelessWidget {
  final ChatUser user;
  final Function(ChatMessage) onSend;
  final String text;

  ChatInputToolbar({
    Key key,
    this.text,
    this.onSend,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatMessage message = ChatMessage(
      text: text,
      user: user,
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
                    onSubmitted: (value) {
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
                onPressed: text.length != 0
                    ? () => _sendMessage(context, message)
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _sendMessage(BuildContext context, ChatMessage message) async {
    if (text.length != 0) {
      await onSend(message);
    }
  }
}
