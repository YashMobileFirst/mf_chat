part of mfchat;

class MessageListView extends StatefulWidget {
  final List<ChatMessage> messages;
  final ChatUser user;
  final Widget Function(ChatMessage) messageBuilder;
  final Widget Function(String, [ChatMessage]) messageTextBuilder;

  MessageListView({
    this.messages,
    this.user,
    this.messageBuilder,
    this.messageTextBuilder,
  });

  @override
  _MessageListViewState createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  double previousPixelPostion = 0.0;

  @override
  Widget build(BuildContext context) {
    final constraints = BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
        maxWidth: MediaQuery.of(context).size.width);

    return Flexible(
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.messages.length,
            itemBuilder: (context, i) {
              bool first = false;
              bool last = false;

              if (widget.messages.length == 0) {
                first = true;
              } else if (widget.messages.length - 1 == i) {
                last = true;
              }

              return Align(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: first ? 10.0 : 0.0,
                        bottom: last ? 10.0 : 0.0,
                      ),
                      child: Row(
                        mainAxisAlignment:
                            widget.messages[i].user.uid == widget.user.uid
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              child: widget.messageBuilder != null
                                  ? widget.messageBuilder(widget.messages[i])
                                  : Align(
                                      alignment: widget.messages[i].user.uid ==
                                              widget.user.uid
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: MessageContainer(
                                        isUser: widget.messages[i].user.uid ==
                                            widget.user.uid,
                                        message: widget.messages[i],
                                        messageTextBuilder:
                                            widget.messageTextBuilder,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Container(
            height: 100.0,
          ),
        ],
      ),
    );
  }
}
