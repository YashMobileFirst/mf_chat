part of mfchat;

class AvatarContainer extends StatelessWidget {

  final ChatUser user;
  final Function(ChatUser) onPress;
  final Function(ChatUser) onLongPress;
  final Widget Function(ChatUser) avatarBuilder;
  final BoxConstraints constraints;

  const AvatarContainer({
    @required this.user,
    this.onPress,
    this.onLongPress,
    this.avatarBuilder,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final constraints = this.constraints ??
        BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width);
    return GestureDetector(
      onTap: () => onPress != null ? onPress(user) : null,
      onLongPress: () => onLongPress != null ? onLongPress(user) : null,
      child: avatarBuilder != null
          ? avatarBuilder(user)
          : Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ClipOval(
                  child: Container(
                    height: constraints.maxWidth * 0.08,
                    width: constraints.maxWidth * 0.08,
                    color: Colors.grey,
                    child: Center(
                        child: Text(user.name == null || user.name.isEmpty
                            ? ''
                            : user.name[0])),
                  ),
                ),
                user.avatar != null && user.avatar.length != 0
                    ? Center(
                        child: ClipOval(
                          child: FadeInImage.memoryNetwork(
                            image: user.avatar,
                            fit: BoxFit.cover,
                            height: constraints.maxWidth * 0.08,
                            width: constraints.maxWidth * 0.08,
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
    );
  }
}
