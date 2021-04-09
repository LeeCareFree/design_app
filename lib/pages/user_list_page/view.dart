import 'package:bluespace/components/loading.dart';
import 'package:bluespace/models/follow_fans_list.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    UserListState state, Dispatch dispatch, ViewService viewService) {
  final _theme = ThemeStyle.getTheme(viewService.context);
  return Scaffold(
      backgroundColor: _theme.backgroundColor,
      appBar: AppBar(
        iconTheme: _theme.iconTheme,
        elevation: 3.0,
        backgroundColor: _theme.bottomAppBarColor,
        brightness: _theme.brightness,
        centerTitle: true,
        title: Text(
          state.type == 'fans' ? '粉丝列表' : '关注列表',
          style: TextStyle(color: Colors.black, fontSize: Adapt.sp(36)),
        ),
      ),
      body: Stack(children: [
        state.isLoading
            ? LoadingLayout(
                title: '加载中...',
                show: true,
              )
            : SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                controller: state.refreshController,
                onRefresh: () => dispatch(UserListActionCreator.getList()),
                onLoading: () => {},
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                        child: _UserListWidget(
                      followFansList: state.followFansList,
                      isFollow: state.isFollow ?? true,
                      dispatch: dispatch,
                    ))
                  ],
                ))
      ]));
}

class _UserListWidget extends StatelessWidget {
  final FollowFansList followFansList;
  final bool isFollow;
  final Dispatch dispatch;
  const _UserListWidget({this.followFansList, this.dispatch, this.isFollow});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: followFansList?.result?.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                onTap: () => {
                      Navigator.of(context).pushNamed('personalPage',
                          arguments: {
                            'uid': followFansList?.result[index]?.uid
                          })
                    },
                child: Container(
                    padding: EdgeInsets.all(Adapt.width(20)),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[200]))),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          flex: 1,
                          child: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              followFansList?.result[index]?.avatar,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Adapt.width(20),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            followFansList?.result[index]?.nickname,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        // followFansList?.result[index].isFocus
                        //     ?
                        Expanded(
                            flex: 2,
                            child: _FollowFansWidget(
                                isFocus:
                                    followFansList?.result[index]?.isFocus ??
                                        false,
                                dispatch: dispatch,
                                uid: followFansList?.result[index]?.uid,
                                index: index)),
                      ],
                    )));
          }),
    );
  }
}

class _FollowFansWidget extends StatelessWidget {
  final bool isFollow;
  final bool isFocus;
  final Dispatch dispatch;
  final String uid;
  final int index;
  const _FollowFansWidget(
      {this.isFocus, this.isFollow, this.dispatch, this.uid, this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: isFocus
          ? InkWell(
              onTap: () => {
                dispatch(UserListActionCreator.follow('cancel', uid, index))
              },
              child: Container(
                  padding: EdgeInsets.fromLTRB(
                      0, Adapt.height(8), 0, Adapt.height(8)),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(Adapt.radius(50))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '互相关注',
                        style: TextStyle(
                            fontSize: Adapt.sp(28), color: Colors.black45),
                      ),
                    ],
                  )),
            )
          : InkWell(
              onTap: () =>
                  {dispatch(UserListActionCreator.follow('add', uid, index))},
              child: Container(
                  padding: EdgeInsets.fromLTRB(
                      0, Adapt.height(8), 0, Adapt.height(8)),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(Adapt.radius(50))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '关注',
                        style: TextStyle(
                            fontSize: Adapt.sp(28), color: Colors.black),
                      ),
                    ],
                  )),
            ),
    );
  }
}
