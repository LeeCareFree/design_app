import 'package:bluespace/utils/adapt.dart';
import 'package:flutter/material.dart';

class TikTokButtonRow extends StatelessWidget {
  final double bottomPadding;
  final bool isFavorite;
  final Function onFavorite;
  final Function onComment;
  final Function onShare;
  final Function onAvatar;
  const TikTokButtonRow({
    Key key,
    this.bottomPadding,
    this.onFavorite,
    this.onComment,
    this.onShare,
    this.isFavorite: false,
    this.onAvatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Adapt.screenW(),
      margin: EdgeInsets.only(
        bottom: bottomPadding ?? 50,
        right: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FavoriteIcon(
            onFavorite: onFavorite,
            isFavorite: isFavorite,
          ),
          _IconButton(
            icon: IconToText(Icons.mode_comment, size: Adapt.width(50)),
            text: '4213',
            onTap: onComment,
          ),
          _IconButton(
            icon: IconToText(Icons.share, size: Adapt.width(50)),
            text: '346',
            onTap: onShare,
          ),
          // Container(
          //   width: Adapt.width(50),
          //   height: Adapt.height(50),
          //   margin: EdgeInsets.only(top: 10),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(Adapt.radius(50)),
          //     // color: Colors.black.withOpacity(0.8),
          //   ),
          // )
        ],
      ),
    );
  }
}

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({
    Key key,
    @required this.onFavorite,
    this.isFavorite,
  }) : super(key: key);
  final bool isFavorite;
  final Function onFavorite;

  @override
  Widget build(BuildContext context) {
    return _IconButton(
      icon: IconToText(
        Icons.favorite,
        size: Adapt.width(50),
        color: isFavorite ? Colors.red : null,
      ),
      text: '1.0w',
      onTap: onFavorite,
    );
  }
}

/// 把IconData转换为文字，使其可以使用文字样式
class IconToText extends StatelessWidget {
  final IconData icon;
  final TextStyle style;
  final double size;
  final Color color;

  const IconToText(
    this.icon, {
    Key key,
    this.style,
    this.size,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      String.fromCharCode(icon.codePoint),
      style: style ??
          TextStyle(
            fontFamily: 'MaterialIcons',
            fontSize: size ?? 30,
            inherit: true,
            color: color,
          ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final Function onTap;
  const _IconButton({
    Key key,
    this.icon,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shadowStyle = TextStyle(
      shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.15),
          offset: Offset(0, 1),
          blurRadius: 1,
        ),
      ],
    );
    Widget body = Column(
      children: <Widget>[
        CircleAvatar(
          child: icon ?? Container(),
        ),
        Container(height: 2),
        Text(
          text ?? '??',
        ),
      ],
    );
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: DefaultTextStyle(
        child: body,
        style: shadowStyle,
      ),
    );
  }
}
