import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    OrderComponentState state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
      child: _OrderPanel(
    dispatch: dispatch,
  ));
}

class _FeatureCell extends StatelessWidget {
  final String title;
  final Function onTap;
  final String icon;
  const _FeatureCell({this.title, this.onTap, this.icon});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Adapt.width(120),
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        margin: EdgeInsets.fromLTRB(4, 10, 2, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Adapt.width(60),
              height: Adapt.height(60),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: icon != null
                    ? DecorationImage(
                        fit: BoxFit.cover, image: AssetImage(icon))
                    : null,
              ),
            ),
            SizedBox(
              height: Adapt.height(5),
            ),
            Text(
              title,
              style: TextStyle(
                  // color: Colors.white,
                  fontSize: Adapt.sp(24),
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderPanel extends StatelessWidget {
  final Dispatch dispatch;
  const _OrderPanel({this.dispatch});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(children: [
        _FeatureCell(
          title: '全部订单',
          icon: 'assets/images/order.png',
          onTap:
              dispatch(OrderComponentActionCreator.navigatorPush('orderPage')),
        ),
        _FeatureCell(
          title: '待付款',
          icon: 'assets/images/pay.png',
          onTap:
              dispatch(OrderComponentActionCreator.navigatorPush('orderPage')),
        ),
        _FeatureCell(
          title: '预约',
          icon: 'assets/images/order.png',
          onTap:
              dispatch(OrderComponentActionCreator.navigatorPush('orderPage')),
        ),
        _FeatureCell(
          title: '设计',
          icon: 'assets/images/refund.png',
          onTap:
              dispatch(OrderComponentActionCreator.navigatorPush('orderPage')),
        ),
        _FeatureCell(
          title: '退款/售后',
          icon: 'assets/images/refund.png',
          onTap:
              dispatch(OrderComponentActionCreator.navigatorPush('orderPage')),
        ),
      ]),
    );
  }
}
