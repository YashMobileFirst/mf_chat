part of mfchat;

class MessageContainer extends StatelessWidget {
  final ChatMessage message;
  final Widget Function(String, [ChatMessage]) messageTextBuilder;
  final bool isUser;

  const MessageContainer({
    @required this.message,
    this.messageTextBuilder,
    this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    final constraints = BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
        maxWidth: MediaQuery.of(context).size.width);
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: constraints.maxWidth * 0.8,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: message.user.containerColor != null
              ? message.user.containerColor
              : isUser
                  ? Theme.of(context).accentColor
                  : Color.fromRGBO(225, 225, 225, 1),
          borderRadius: BorderRadius.circular(5.0),
        ),
        margin: EdgeInsets.only(
          bottom: 5.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            messageTextBuilder(message.text, message),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment:
                  isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
            ),
          ],
        ),
      ),
    );
  }
}
