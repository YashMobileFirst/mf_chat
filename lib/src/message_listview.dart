part of mfchat;

class MessageListView extends StatefulWidget {
  final List<ChatMessage> messages;
  final ChatUser user;
  final bool showuserAvatar;
  final bool showAvatarForEverMessage;
  final Function(ChatUser) onPressAvatar;
  final Widget Function(ChatUser) avatarBuilder;
  final Widget Function(ChatMessage) messageBuilder;
  final Widget Function(String, [ChatMessage]) messageTextBuilder;
  final Widget Function() renderMessageFooter;
  final BoxDecoration messageContainerDecoration;
  final ScrollController scrollController;
  final EdgeInsets messageContainerPadding;
  final Function changeVisible;
  final bool visible;
  final bool showLoadMore;
  final bool shouldShowLoadEarlier;
  final Widget Function() showLoadEarlierWidget;
  final Function onLoadEarlier;
  final Function(bool) defaultLoadCallback;
  final BoxConstraints constraints;
  final List<Widget> Function(ChatMessage) messageButtonsBuilder;
  final EdgeInsets messagePadding;

  MessageListView({
    this.showLoadEarlierWidget,
    this.shouldShowLoadEarlier,
    this.constraints,
    this.onLoadEarlier,
    this.defaultLoadCallback,
    this.messageContainerPadding =
        const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
    this.scrollController,
    this.messageContainerDecoration,
    this.messages,
    this.user,
    this.showuserAvatar,
    this.showAvatarForEverMessage,
    this.onPressAvatar,
    this.messageBuilder,
    this.renderMessageFooter,
    this.avatarBuilder,
    this.messageTextBuilder,
    this.changeVisible,
    this.visible,
    this.showLoadMore,
    this.messageButtonsBuilder,
    this.messagePadding = const EdgeInsets.all(8.0),
  });

  @override
  _MessageListViewState createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  double previousPixelPostion = 0.0;

  bool scrollNotificationFunc(ScrollNotification scrollNotification) {
    if (previousPixelPostion == 0.0) {
      previousPixelPostion = scrollNotification.metrics.maxScrollExtent;
    }

    if (scrollNotification.metrics.pixels ==
        scrollNotification.metrics.maxScrollExtent) {
      if (widget.visible) {
        widget.changeVisible(false);
      }
    } else {
      if (previousPixelPostion < scrollNotification.metrics.pixels) {
        if (!widget.visible) {
          widget.changeVisible(true);
        }
      }

      previousPixelPostion = scrollNotification.metrics.pixels;
    }

    return true;
  }

  bool shouldShowAvatar(int index) {
    if (widget.showAvatarForEverMessage) {
      return true;
    }
    if (index + 1 < widget.messages.length) {
      return widget.messages[index + 1].user.uid !=
          widget.messages[index].user.uid;
    } else if (index - 1 >= 0) {
      return widget.messages[index - 1].user.uid !=
          widget.messages[index].user.uid;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate;

    final constraints = widget.constraints ??
        BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width);

    return Flexible(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Padding(
          padding: widget.messageContainerPadding,
          child: NotificationListener<ScrollNotification>(
            onNotification: scrollNotificationFunc,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                ListView.builder(
                  controller: widget.scrollController,
                  shrinkWrap: true,
                  itemCount: widget.messages.length,
                  itemBuilder: (context, i) {
                    bool showAvatar = shouldShowAvatar(i);
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
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: constraints.maxWidth * 0.02,
                                  ),
                                  child: Opacity(
                                    opacity: (widget.showAvatarForEverMessage ||
                                                showAvatar) &&
                                            widget.messages[i].user.uid !=
                                                widget.user.uid
                                        ? 1
                                        : 0,
                                    child: AvatarContainer(
                                      user: widget.messages[i].user,
                                      onPress: widget.onPressAvatar,
                                      avatarBuilder: widget.avatarBuilder,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    child: widget.messageBuilder != null
                                        ? widget
                                            .messageBuilder(widget.messages[i])
                                        : Align(
                                            alignment:
                                                widget.messages[i].user.uid ==
                                                        widget.user.uid
                                                    ? Alignment.centerRight
                                                    : Alignment.centerLeft,
                                            child: MessageContainer(
                                              messagePadding:
                                                  widget.messagePadding,
                                              constraints: constraints,
                                              isUser:
                                                  widget.messages[i].user.uid ==
                                                      widget.user.uid,
                                              message: widget.messages[i],
                                              messageTextBuilder:
                                                  widget.messageTextBuilder,
                                              messageContainerDecoration: widget
                                                  .messageContainerDecoration,
                                              buttons:
                                                  widget.messages[i].buttons,
                                              messageButtonsBuilder:
                                                  widget.messageButtonsBuilder,
                                            ),
                                          ),
                                  ),
                                ),
                                if (widget.showuserAvatar)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: constraints.maxWidth * 0.02,
                                    ),
                                    child: Opacity(
                                      opacity:
                                          (widget.showAvatarForEverMessage ||
                                                      showAvatar) &&
                                                  widget.messages[i].user.uid ==
                                                      widget.user.uid
                                              ? 1
                                              : 0,
                                      child: AvatarContainer(
                                        user: widget.messages[i].user,
                                        onPress: widget.onPressAvatar,
                                        avatarBuilder: widget.avatarBuilder,
                                      ),
                                    ),
                                  )
                                else
                                  SizedBox(
                                    width: 10.0,
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
                AnimatedPositioned(
                  top: widget.showLoadMore ? 8.0 : -50.0,
                  duration: Duration(milliseconds: 200),
                  child: widget.showLoadEarlierWidget != null
                      ? widget.showLoadEarlierWidget()
                      : LoadEarlierWidget(
                          onLoadEarlier: widget.onLoadEarlier,
                          defaultLoadCallback: widget.defaultLoadCallback,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
