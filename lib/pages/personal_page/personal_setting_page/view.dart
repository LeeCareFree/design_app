import 'package:bluespace/router/PopRouter.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PersonalSettingState state, Dispatch dispatch, ViewService viewService) {
  final _theme = ThemeStyle.getTheme(viewService.context);
  return Scaffold(
    backgroundColor: _theme.backgroundColor,
    appBar: AppBar(
      iconTheme: _theme.iconTheme,
      elevation: 3.0,
      backgroundColor: _theme.bottomAppBarColor,
      brightness: _theme.brightness,
      title: Text(
        '编辑资料',
        style: TextStyle(color: Colors.black, fontSize: Adapt.sp(32)),
      ),
      centerTitle: true,
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          _Menu(
            text: '头像',
            oldProfile: state.oldProfile,
            profile: state.profile,
            press: () =>
                {dispatch(PersonalSettingActionCreator.pickImg('profile'))},
            type: 'required',
          ),
          _Menu(
            text: '昵称',
            content: Text(
              state.nickname ?? '未填写',
              style: TextStyle(
                  color: state.nickname != null ? Colors.black : Colors.grey),
            ),
            type: 'required',
            press: () => {
              Navigator.push(
                  viewService.context,
                  PopRoute(
                      child: BottomInputDialog(
                          textEditingController: state.nicknamController,
                          submit: () => {
                                dispatch(
                                    PersonalSettingActionCreator.setContent(
                                        'nickname',
                                        state.nicknamController.text)),
                                Navigator.pop(viewService.context)
                              })))
            },
          ),
          _Menu(
            text: '简介',
            content: Text(
              state.personalShow ?? '未填写',
              style: TextStyle(
                  color:
                      state.personalShow != null ? Colors.black : Colors.grey),
            ),
            press: () => {
              Navigator.push(
                  viewService.context,
                  PopRoute(
                      child: BottomInputDialog(
                    textEditingController: state.personalShowController,
                    submit: () => {
                      dispatch(PersonalSettingActionCreator.setContent(
                          'personalShow', state.personalShowController.text)),
                      Navigator.pop(viewService.context)
                    },
                  )))
            },
          ),
          _Menu(
            oldBackgroundImg: state.oldBackgroundImg,
            text: '封面',
            backgroundImg: state.backgroundImg,
            content: Container(),
            press: () => {
              dispatch(PersonalSettingActionCreator.pickImg('backgroundImg'))
            },
          ),
          _Menu(
            text: '性别',
            content: Text(
              state.gender == 1
                  ? '男'
                  : state.gender == 2
                      ? '女'
                      : '未选择',
              style: TextStyle(
                  color: state.gender != 0 ? Colors.black : Colors.grey),
            ),
            press: () => {
              showDialog(
                context: viewService.context,
                builder: (_) => _TypeList(
                  onTap: (d) => {
                    dispatch(
                        PersonalSettingActionCreator.setContent('gender', d))
                  },
                  selected: state.gender == 1 ? '男' : '女',
                ),
              )
            },
          ),
          _Menu(
            text: '位置',
            content: Text(
              state.location ?? '未选择',
              style: TextStyle(
                  color: state.location != null ? Colors.black : Colors.grey),
            ),
            press: () => dispatch(PersonalSettingActionCreator.pickLocation()),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(Adapt.radius(30))),
            margin: EdgeInsets.all(Adapt.height(60)),
            child: TextButton(
              onPressed: () => dispatch(PersonalSettingActionCreator.submit()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(children: [
                    Text(
                      '确认提交',
                      style: TextStyle(color: Colors.black54),
                    )
                  ]),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

class _Menu extends StatelessWidget {
  final Function press;
  final String text;
  final Widget content;
  final Asset backgroundImg;
  final Asset profile;
  final String type;
  final String oldProfile;
  final String oldBackgroundImg;
  const _Menu(
      {this.type,
      this.profile,
      this.press,
      this.text,
      this.backgroundImg,
      this.content,
      this.oldProfile,
      this.oldBackgroundImg});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey)),
        ),
        margin: EdgeInsets.symmetric(horizontal: Adapt.width(20)),
        padding: EdgeInsets.symmetric(vertical: Adapt.height(40)),
        child: InkWell(
          onTap: press,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              type == 'required'
                  ? Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.new_releases_rounded,
                        color: Colors.red,
                        size: Adapt.height(15),
                      ),
                    )
                  : Expanded(
                      flex: 1,
                      child: Container(),
                    ),
              Expanded(flex: 2, child: Text(text)),
              Expanded(
                  flex: 8,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    text == '头像'
                        ? ((oldProfile != null && profile != null)
                            ? CircleAvatar(
                                child: AssetThumb(
                                asset: profile,
                                width: 50,
                                height: 50,
                              ))
                            : CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                  oldProfile,
                                ),
                              ))
                        : text == '封面'
                            ? (oldBackgroundImg != null &&
                                    backgroundImg != null)
                                ? AssetThumb(
                                    asset: backgroundImg,
                                    width: 200,
                                    height: 100,
                                  )
                                : Container(
                                    width: Adapt.width(200),
                                    height: Adapt.height(100),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider(
                                            oldBackgroundImg,
                                          ),
                                        )),
                                  )
                            : content
                  ])),
              Expanded(flex: 1, child: Icon(Icons.chevron_right_outlined)),
            ],
          ),
        ));
  }
}

class BottomInputDialog extends StatelessWidget {
  final TextEditingController textEditingController;
  final String type;
  final Function submit;
  const BottomInputDialog({this.textEditingController, this.type, this.submit});
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: new Column(
        children: <Widget>[
          Expanded(
              child: new GestureDetector(
            child: new Container(
              color: Colors.black54,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )),
          Container(
            width: Adapt.screenW(),
            decoration: BoxDecoration(color: Colors.grey[50]),
            child: Flex(
              direction: Axis.horizontal,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    margin: EdgeInsets.only(left: Adapt.width(30)),
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(Adapt.radius(50))),
                    height: Adapt.height(60),
                    child: TextField(
                      onSubmitted: (s) => submit(),
                      controller: textEditingController,
                      autofocus: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(Adapt.width(20),
                            Adapt.height(5), Adapt.width(10), Adapt.height(27)),
                        border: InputBorder.none,
                        hintText: "请输入...",
                        hintStyle: TextStyle(
                          fontSize: Adapt.sp(30),
                          height: Adapt.height(2),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(onPressed: submit, child: Text('确定')),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _TypeList extends StatelessWidget {
  final Function(String) onTap;
  final String selected;
  final String type;
  const _TypeList({this.onTap, this.selected, this.type});
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final _theme = ThemeStyle.getTheme(context);
    final _backGroundColor = _theme.brightness == Brightness.light
        ? Colors.white
        : _theme.primaryColorDark;
    final List<String> data = [
      '男',
      '女',
    ];
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0.0,
      backgroundColor: _backGroundColor,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
      title: Text('请选择性别', style: TextStyle(fontWeight: FontWeight.w600)),
      children: [
        Container(
          height: _size.height / 8,
          width: _size.width,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
            separatorBuilder: (_, __) => SizedBox(height: 10),
            physics: BouncingScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (_, index) {
              final _language = data[index];
              return GestureDetector(
                onTap: () {
                  onTap(_language);
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: selected == _language
                      ? BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        )
                      // border: Border.all(color: Colors.black))
                      : null,
                  child: Text(
                    _language,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Adapt.sp(32),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
