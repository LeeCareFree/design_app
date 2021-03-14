/*
 * @Author: your name
 * @Date: 2021-03-11 18:16:47
 * @LastEditTime: 2021-03-12 14:26:53
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \design_app\lib\components\searchbar_delegate.dart
 */
import 'package:flutter/material.dart';

class SearchBarDelegate extends SearchDelegate {
  //数据内容
  String searchHint = "请输入搜索内容...";
  var sourceList = [
    "dart",
    "dart 入门",
    "flutter",
    "flutter 编程",
    "flutter 编程开发",
  ];

  var suggestList = ["flutter", "flutter 编程开发"];

  @override
  String get searchFieldLabel => searchHint;

  //重写搜索框右上角方法
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      //放置按钮，点击时，将搜索框清空
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  //重写左上角方法
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      //返回动态按钮
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        //回调中调用close方法，关闭搜索页面
        close(context, null);
      },
    );
  }

  //重写键盘点击确认后方法
  @override
  Widget buildResults(BuildContext context) {
    List<String> result = List();

    ///模拟搜索过程
    for (var str in sourceList) {
      ///query 就是输入框的 TextEditingController
      if (query.isNotEmpty && str.contains(query)) {
        result.add(str);
      }
    }

    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
        title: Text(result[index]),
      ),
    );
  }

  //重写输入过程方法,在输入过程不断调用
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggest = query.isEmpty
        ? suggestList
        : sourceList.where((input) => input.startsWith(query)).toList();

    return ListView.builder(
      itemCount: suggest.length,
      itemBuilder: (BuildContext context, int index) => InkWell(
        child: ListTile(
          title: RichText(
            text: TextSpan(
              text: suggest[index].substring(0, query.length),
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggest[index].substring(query.length),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          //  query.replaceAll("", suggest[index].toString());
          searchHint = "";
          query = suggest[index].toString();
          showResults(context);
        },
      ),
    );
  }
}
