import 'package:bluespace/components/loading.dart';
import 'package:bluespace/models/follow_fans_list.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
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
      child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          itemCount: followFansList?.result?.length ?? 0,
          separatorBuilder: (BuildContext context, int index) => Divider(
                height: Adapt.height(30),
                color: Color(0xFFFFFFFF),
              ),
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
                          flex: 2,
                          child: ClipOval(
                            child: Image.network(
                              followFansList?.result[index]?.avatar,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Adapt.width(20),
                        ),
                        Expanded(
                          flex: 8,
                          child: Text(
                            followFansList?.result[index]?.nickname,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        // followFansList?.result[index].isFocus
                        //     ?
                        Expanded(
                            flex: 3,
                            child: _FollowFansWidget(
                              isFocus: followFansList?.result[index]?.isFocus ??
                                  false,
                              isFollow: isFollow,
                              dispatch: dispatch,
                              uid: followFansList?.result[index]?.uid,
                            )),
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
  const _FollowFansWidget(
      {this.isFocus, this.isFollow, this.dispatch, this.uid});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: isFocus
            ? Container(
                child: isFollow
                    ? InkWell(
                        onTap: () => {
                          dispatch(UserListActionCreator.follow(
                            'cancel',
                            uid,
                          ))
                        },
                        child: Container(
                            padding: EdgeInsets.fromLTRB(
                                0, Adapt.height(8), 0, Adapt.height(8)),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.blueGrey),
                                borderRadius:
                                    BorderRadius.circular(Adapt.radius(50))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '互相关注',
                                  style: TextStyle(
                                      fontSize: Adapt.sp(28),
                                      color: Colors.black45),
                                ),
                              ],
                            )),
                      )
                    : InkWell(
                        onTap: () => {
                          dispatch(UserListActionCreator.follow(
                            'add',
                            uid,
                          ))
                        },
                        child: Container(
                            padding: EdgeInsets.fromLTRB(
                                0, Adapt.height(8), 0, Adapt.height(8)),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.blueGrey),
                                borderRadius:
                                    BorderRadius.circular(Adapt.radius(50))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '关注',
                                  style: TextStyle(
                                      fontSize: Adapt.sp(28),
                                      color: Colors.black),
                                ),
                              ],
                            )),
                      ),
              )
            : Container(
                child: isFollow
                    ? InkWell(
                        onTap: () => {
                          dispatch(UserListActionCreator.follow(
                            'cancel',
                            uid,
                          ))
                        },
                        child: Container(
                            padding: EdgeInsets.fromLTRB(
                                0, Adapt.height(8), 0, Adapt.height(8)),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.blueGrey),
                                borderRadius:
                                    BorderRadius.circular(Adapt.radius(50))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '已关注',
                                  style: TextStyle(
                                      fontSize: Adapt.sp(28),
                                      color: Colors.black45),
                                ),
                              ],
                            )),
                      )
                    : InkWell(
                        onTap: () => {
                          dispatch(UserListActionCreator.follow(
                            'add',
                            uid,
                          ))
                        },
                        child: Container(
                            padding: EdgeInsets.fromLTRB(
                                0, Adapt.height(8), 0, Adapt.height(8)),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.blueGrey),
                                borderRadius:
                                    BorderRadius.circular(Adapt.radius(50))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '关注',
                                  style: TextStyle(
                                      fontSize: Adapt.sp(28),
                                      color: Colors.black),
                                ),
                              ],
                            )),
                      ),
              ));
  }
}
