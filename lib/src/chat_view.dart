part of mfchat;

class MFChat extends StatefulWidget {

  final int messageContainerFlex;
  final bool readOnly;
  final double height;
  final double width;
  final List<ChatMessage> messages;
  final TextEditingController textController;
  final FocusNode focusNode;
  final TextDirection inputTextDirection;
  final String text;
  final Function(String) onTextChange;
  final InputDecoration inputDecoration;
  final ChatUser user;
  final Function(ChatMessage) onSend;
  final bool alwaysShowSend;
  final bool sendOnEnter;
  final TextInputAction textInputAction;
  final bool showUserAvatar;
  final Widget Function(ChatUser) avatarBuilder;
  final bool showAvatarForEveryMessage;
  final Function(ChatUser) onPressAvatar;
  final Widget Function(ChatMessage) messageBuilder;
  final Widget Function(String, [ChatMessage]) messageTextBuilder;
  final Widget Function() chatFooterBuilder;
  final int maxInputLength;
  final BoxDecoration messageContainerDecoration;
  final List<Widget> leading;
  final List<Widget> trailing;
  final Widget Function(Function) sendButtonBuilder;
  final TextStyle inputTextStyle;
  final BoxDecoration inputContainerStyle;
  final int inputMaxLines;
  final bool showInputCursor;
  final double inputCursorWidth;
  final Color inputCursorColor;
  final ScrollController scrollController;
  final Widget Function() inputFooterBuilder;
  final EdgeInsetsGeometry messageContainerPadding;
  final bool scrollToBottom;
  final Widget Function() scrollToBottomWidget;
  final Function onScrollToBottomPress;
  final bool shouldShowLoadEarlier;
  final Widget Function() showLoadEarlierWidget;
  final Function onLoadEarlier;

  final EdgeInsets inputToolbarPadding;
  final EdgeInsets inputToolbarMargin;
  final List<Widget> Function(ChatMessage) messageButtonsBuilder;

  MFChat(
      {Key key,
      this.inputTextDirection = TextDirection.ltr,
      this.inputToolbarMargin = const EdgeInsets.all(0.0),
      this.inputToolbarPadding = const EdgeInsets.all(0.0),
      this.shouldShowLoadEarlier = false,
      this.showLoadEarlierWidget,
      this.onLoadEarlier,
      this.sendOnEnter = false,
      this.textInputAction,
      this.scrollToBottom = true,
      this.scrollToBottomWidget,
      this.onScrollToBottomPress,
      this.messageContainerPadding = const EdgeInsets.only(
        left: 2.0,
        right: 2.0,
      ),
      this.scrollController,
      this.inputCursorColor,
      this.inputCursorWidth = 2.0,
      this.showInputCursor = true,
      this.inputMaxLines = 1,
      this.inputContainerStyle,
      this.inputTextStyle,
      this.leading = const <Widget>[],
      this.trailing = const <Widget>[],
      this.messageContainerDecoration,
      this.messageContainerFlex = 1,
      this.height,
      this.width,
      this.readOnly = false,
      @required this.messages,
      this.onTextChange,
      this.text,
      this.textController,
      this.focusNode,
      this.inputDecoration,
      this.alwaysShowSend = false,
      @required this.user,
      @required this.onSend,
      this.onPressAvatar,
      this.avatarBuilder,
      this.showAvatarForEveryMessage = false,
      this.showUserAvatar = false,
      this.maxInputLength,
      this.chatFooterBuilder,
      this.messageBuilder,
      this.inputFooterBuilder,
      this.sendButtonBuilder,
      this.messageTextBuilder,
      this.messageButtonsBuilder})
      : super(key: key);

  @override
  _MFChatState createState() => _MFChatState();
}

class _MFChatState extends State<MFChat> {
  FocusNode inputFocusNode;
  TextEditingController textController;
  ScrollController scrollController;
  String _text = "";
  bool visible = false;
  OverlayEntry _overlayEntry;
  GlobalKey inputKey = GlobalKey();
  double height = 48.0;
  bool showLoadMore = false;

  String get messageInput => _text;

  @override
  void initState() {
    scrollController = widget.scrollController ?? ScrollController();
    textController = widget.textController ?? TextEditingController();
    inputFocusNode = widget.focusNode ?? FocusNode();
    WidgetsBinding.instance.addPostFrameCallback(widgetBuilt);
    super.initState();
  }

  void widgetBuilt(Duration d) {
    double initPos = scrollController.position.maxScrollExtent;
    scrollController.jumpTo(initPos);

    scrollController.addListener(() {
      bool topReached = scrollController.offset <=
              scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange;

      if (widget.shouldShowLoadEarlier) {
        if (topReached) {
          setState(() {
            showLoadMore = true;
          });
        } else {
          setState(() {
            showLoadMore = false;
          });
        }
      } else if (topReached) {
        widget.onLoadEarlier();
      }
    });
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
        height: widget.height != null ? widget.height : maxHeight,
        width: widget.width != null ? widget.width : maxWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MessageListView(
              constraints: constraints,
              shouldShowLoadEarlier: widget.shouldShowLoadEarlier,
              showLoadEarlierWidget: widget.showLoadEarlierWidget,
              onLoadEarlier: widget.onLoadEarlier,
              messageContainerPadding: widget.messageContainerPadding,
              scrollController: widget.scrollController != null
                  ? widget.scrollController
                  : scrollController,
              user: widget.user,
              messages: widget.messages,
              showuserAvatar: widget.showUserAvatar,
              showAvatarForEverMessage: widget.showAvatarForEveryMessage,
              onPressAvatar: widget.onPressAvatar,
              avatarBuilder: widget.avatarBuilder,
              messageBuilder: widget.messageBuilder,
              messageTextBuilder: widget.messageTextBuilder,
              messageContainerDecoration: widget.messageContainerDecoration,
              visible: visible,
              showLoadMore: showLoadMore,
              messageButtonsBuilder: widget.messageButtonsBuilder,
            ),
          ],
        ),
      );
    });
  }
}
