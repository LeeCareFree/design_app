import 'package:bluespace/components/drapdown.dart';
import 'package:bluespace/models/designer_list.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SortState implements Cloneable<SortState> {
  DesignerList designerList;
  RefreshController refreshController;
  List designfee = ['不限'];
  List stylearr = ['不限'];
  List service = ['不限'];
  @override
  SortState clone() {
    return SortState()
      ..designfee = designfee
      ..stylearr = stylearr
      ..service = service
      ..refreshController = refreshController
      ..designerList = designerList;
  }
}

SortState initState(Map<String, dynamic> args) {
  return SortState()..designerList = DesignerList(result: []);
}
