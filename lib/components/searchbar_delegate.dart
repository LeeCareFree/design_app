/*
 * @Author: your name
 * @Date: 2021-03-11 18:16:47
 * @LastEditTime: 2021-03-30 11:51:31
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \design_app\lib\components\searchbar_delegate.dart
 */
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bluespace/net/service_method.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/models/search_article.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:bluespace/components/fitImage.dart';

class SearchBarDelegate extends SearchDelegate {
  //数据内容
  String searchHint = "请输入搜索内容...";
  SharedPreferences prefs;
  List<String> searchHistory;

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
          showSuggestions(context);
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

  Future _getData() {
    if (query != '' && query != null) {
      var formData = {'query': query};
      return DioUtil.request('searchArticle', formData: formData);
    } else {
      return null;
    }
  }

  Future<List<String>> _getHistory() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
    searchHistory = prefs.getStringList('searchHistory') ?? List<String>();
    return searchHistory;
  }

  //重写键盘点击确认后方法
  @override
  Widget buildResults(BuildContext context) {
    if (prefs != null && query != '') {
      int index = searchHistory.indexOf(query);
      if (index < 0) {
        searchHistory.insert(0, query);
        prefs.setStringList('searchHistory', searchHistory);
      }
    }
    return FutureBuilder(
      future: _getData(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Container(
              child: Center(
                child: Text('No Result'),
              ),
            );
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Container(
              margin: EdgeInsets.only(top: Adapt.width(30)),
              alignment: Alignment.topCenter,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.black),
              ),
            );
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            SearchArticleModel result = SearchArticleModel.fromJson(
                json.decode(snapshot.data.toString()));
            return _ResultList(
              query: query,
              results: result.data.length != null ? result.data : [],
            );
        }
        return null;
      },
    );
  }

  //重写输入过程方法,在输入过程不断调用
  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: _getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return _buildHistoryList();
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Container(
                margin: EdgeInsets.only(top: Adapt.width(30)),
                alignment: Alignment.topCenter,
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black)),
              );
            case ConnectionState.done:
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              SearchArticleModel result = SearchArticleModel.fromJson(
                  json.decode(snapshot.data.toString()));
              return _SuggestionList(
                query: query,
                suggestions: result.data.length != null ? result.data : [],
                onSelected: (String suggestion) {
                  query = suggestion;
                  showResults(context);
                },
              );
          }
          return null;
        });
  }

  Widget _buildHistoryList() {
    return FutureBuilder(
      future: _getHistory(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // final ThemeData _theme = ThemeStyle.getTheme(context);
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return _buildHistoryList();
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Container(
              margin: EdgeInsets.only(top: Adapt.width(30)),
              alignment: Alignment.topCenter,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black)),
            );
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        Adapt.width(30), Adapt.width(30), 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '搜索历史',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Adapt.sp(35)),
                        ),
                        searchHistory.length > 0
                            ? SizedBox(
                                height: Adapt.width(40),
                                child: IconButton(
                                  padding: EdgeInsets.all(0),
                                  icon: Icon(Icons.delete_outline),
                                  onPressed: () {
                                    if (prefs != null &&
                                        searchHistory.length > 0) {
                                      searchHistory = List<String>();
                                      prefs.remove('searchHistory');
                                      query = '';
                                      showSuggestions(context);
                                    }
                                  },
                                ),
                              )
                            : SizedBox()
                      ],
                    ),
                  ),
                  searchHistory != null && searchHistory.length > 0
                      ? Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: Adapt.width(35)),
                          width: Adapt.screenW(),
                          child: Wrap(
                              spacing: Adapt.width(20),
                              children: searchHistory.map((e) {
                                return ActionChip(
                                    avatar: Icon(
                                      Icons.history,
                                      color: Colors.grey[500],
                                    ),
                                    label: Text(e),
                                    elevation: 3.0,
                                    onPressed: () {
                                      query = e;
                                      showResults(context);
                                    });
                              }).toList()),
                        )
                      : Container(
                          padding: EdgeInsets.only(left: Adapt.width(30)),
                          child: Text('没有搜索记录'),
                        )
                ],
              ),
            );
        }
        return null;
      },
    );
  }
}

Widget _buildSuggestionCell(SearchArticle s, ValueChanged<String> tapped) {
  IconData iconData = s.type == '1'
      ? Icons.article
      : s.type == '2'
          ? Icons.photo_size_select_actual_rounded
          : Icons.video_collection;
  // String name = s.mediaType == 'movie' ? s.title : s.name;
  return Container(
      height: Adapt.width(100),
      child: ListTile(
        leading: Icon(iconData),
        title: new Text(s.title),
        onTap: () => tapped(s.title),
      ));
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final suggestion = suggestions[i];
        return _buildSuggestionCell(suggestion, onSelected);
      },
    );
  }
}

Widget _buildResultCell(SearchArticle s, BuildContext context) {
  String img = s.type == '2' ? s.imgList[0] : s.cover;
  IconData iconData = s.type == '1'
      ? Icons.article
      : s.type == '2'
          ? Icons.photo_size_select_actual_rounded
          : Icons.video_collection;
  List typeArr = [
    {"icon": Icons.article, "name": '文章'},
    {"icon": Icons.photo_size_select_actual_rounded, "name": '图片'},
    {"icon": Icons.video_collection, "name": '视频'}
  ];
  final ThemeData _theme = ThemeStyle.getTheme(context);
  return Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: Adapt.screenW(),
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Adapt.width(5)),
                  topRight: Radius.circular(Adapt.width(5))),
              child: ItemFitWidthNetImage(img, Adapt.screenW() / 2 - 10)),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: Adapt.width(20)),
          margin: EdgeInsets.symmetric(vertical: Adapt.width(10)),
          child: Text(
            '${s.title}',
            style:
                TextStyle(fontSize: Adapt.sp(30), fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding:
              EdgeInsets.only(left: Adapt.width(20), bottom: Adapt.width(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(typeArr[int.parse(s.type) - 1]['icon'],
                  color: _theme.buttonColor),
              Container(
                  padding: EdgeInsets.only(left: Adapt.width(10)),
                  child: Text(typeArr[int.parse(s.type) - 1]['name'],
                      style: TextStyle(fontSize: Adapt.width(25))))
            ],
          ),
        )
      ],
    ),
  );
}

class _ResultList extends StatefulWidget {
  const _ResultList({this.results, this.query});

  final List<SearchArticle> results;
  final String query;

  @override
  _ResultListState createState() => _ResultListState();
}

class _ResultListState extends State<_ResultList> {
  ScrollController scrollController;
  List<SearchArticle> results;
  String query;
  int pageindex;
  int totalpage;
  bool isloading;

  // Future loadData() async {
  //   bool isBottom = scrollController.position.pixels ==
  //       scrollController.position.maxScrollExtent;
  //   if (isBottom && totalpage > pageindex) {
  //     setState(() {
  //       isloading = true;
  //     });
  //     pageindex++;
  //     final r = await TMDBApi.instance.searchMulit(query, page: pageindex);
  //     if (r != null) {
  //       setState(() {
  //         if (r.success) {
  //           pageindex = r.result.page;
  //           totalpage = r.result.totalPages;
  //           results.addAll(r.result.results);
  //         }
  //         isloading = false;
  //       });
  //     }
  //   }
  // }

  // Widget _buildFooter() {
  //   return Offstage(
  //       offstage: !isloading,
  //       child: Container(
  //         height: Adapt.width(80),
  //         alignment: Alignment.center,
  //         child: CircularProgressIndicator(
  //             valueColor: AlwaysStoppedAnimation(Colors.black)),
  //       ));
  // }

  @override
  void initState() {
    results = widget.results;
    query = widget.query;
    pageindex = 1;
    totalpage = 2;
    isloading = false;
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: Adapt.width(20)),
        child: StaggeredGridView.countBuilder(
          shrinkWrap: true,
          // controller: scrollController,
          crossAxisCount: 4,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          itemCount: results.length,
          itemBuilder: (context, i) {
            return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('articleDetailPage',
                      arguments: {'aid': results[i].aid});
                },
                child: _buildResultCell(results[i], context));
          },
          staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        ));
  }
}
