import 'package:bluespace/pages/video_page/component/video_gesture.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// TikTok风格的一个视频页组件，覆盖在video上，提供以下功能：
/// 播放按钮的遮罩
/// 单击事件
/// 点赞事件回调（每次）
/// 长宽比控制
/// 底部padding（用于适配有沉浸式底部状态栏时）
///
class VideoPage extends StatelessWidget {
  final Widget video;
  final double aspectRatio;
  final String tag;

  final Widget buttomButtonRow;
  final Widget userInfoWidget;

  final bool hidePauseIcon;

  final Function onAddFavorite;
  final Function onSingleTap;

  const VideoPage({
    Key key,
    this.tag,
    this.buttomButtonRow,
    this.userInfoWidget,
    this.onAddFavorite,
    this.onSingleTap,
    this.video,
    this.aspectRatio: 9 / 16.0,
    this.hidePauseIcon: false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // 右边的按钮列表
    Widget buttonButtons = buttomButtonRow ?? Container();
    // 用户信息
    Widget userInfo = userInfoWidget ?? VideoUserInfo();
    // 视频加载的动画
    // Widget videoLoading = VideoLoadingPlaceHolder(tag: tag);
    // 视频播放页
    Widget videoContainer = VideoGesture(
      onAddFavorite: onAddFavorite,
      onSingleTap: onSingleTap,
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: video,
          ),
          hidePauseIcon
              ? Container()
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 120,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
        ],
      ),
    );
    Widget body = Container(
      child: Stack(
        children: <Widget>[
          videoContainer,
          Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.bottomLeft,
            child: userInfo,
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            child: buttonButtons,
          ),
        ],
      ),
    );
    return body;
  }
}

class VideoLoadingPlaceHolder extends StatelessWidget {
  const VideoLoadingPlaceHolder({
    Key key,
    @required this.tag,
  }) : super(key: key);

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: <Color>[
            Colors.blue,
            Colors.green,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // SpinKitWave(
          //   size: 36,
          //   color: Colors.white.withOpacity(0.3),
          // ),
          Container(
            padding: EdgeInsets.all(50),
            child: Text(
              tag ?? 'Unknown Tag',
            ),
          ),
        ],
      ),
    );
  }
}

class VideoUserInfo extends StatelessWidget {
  final String desc;
  // final Function onGoodGift;
  const VideoUserInfo({
    Key key,
    // @required this.onGoodGift,
    this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
      ),
      margin: EdgeInsets.only(right: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage("http://8.129.214.128:3001/avatar/lee.jpg"),
                radius: Adapt.width(50),
              ),
              Text('lee'),
              TextButton(onPressed: () => {}, child: Text('关注'))
            ],
          ),
          Container(height: Adapt.height(10)),
          Text(
            desc ?? '#原创 有钱人的生活就是这么朴实无华，且枯燥 #短视频',
          ),
          Container(height: Adapt.height(10)),
          Row(
            children: <Widget>[
              Icon(Icons.music_note, size: 14),
              Expanded(
                child: Text(
                  '朱二旦的枯燥生活创作的原声',
                  maxLines: 9,
                ),
              )
            ],
          ),
          Container(height: Adapt.height(10)),
        ],
      ),
    );
  }
}
