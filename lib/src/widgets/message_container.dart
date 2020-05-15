part of mfchat;

class MessageContainer extends StatelessWidget {

  final ChatMessage message;
  final Widget Function(String, [ChatMessage]) messageTextBuilder;
  final Widget Function(String, [ChatMessage]) messageTimeBuilder;
  final BoxDecoration messageContainerDecoration;
  final bool isUser;
  final List<Widget> buttons;
  final List<Widget> Function(ChatMessage) messageButtonsBuilder;
  final BoxConstraints constraints;
  final EdgeInsets messagePadding;

  const MessageContainer({
    @required this.message,
    this.constraints,
    this.messageTextBuilder,
    this.messageTimeBuilder,
    this.messageContainerDecoration,
    this.isUser,
    this.messageButtonsBuilder,
    this.buttons,
    this.messagePadding = const EdgeInsets.all(8.0),
  });

  @override
  Widget build(BuildContext context) {
    final constraints = this.constraints ??
        BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width);
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: constraints.maxWidth * 0.8,
      ),
      child: Container(
        decoration: messageContainerDecoration != null
            ? messageContainerDecoration.copyWith(
                color: message.user.containerColor != null
                    ? message.user.containerColor
                    : messageContainerDecoration.color,
              )
            : BoxDecoration(
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
        padding: messagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            messageTextBuilder(message.text, message),
            if (buttons != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment:
                    isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: buttons,
              )
            else if (messageButtonsBuilder != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment:
                    isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: messageButtonsBuilder(message),
                mainAxisSize: MainAxisSize.min,
              ),
          ],
        ),
      ),
    );
  }
}
