import 'package:bluespace/utils/adapt.dart';
import 'package:flutter/material.dart';

class CustomReorderableListView extends StatefulWidget {
  final List<Widget> list;
  CustomReorderableListView({this.list});
  @override
  _CustomReorderableListViewState createState() =>
      _CustomReorderableListViewState();
}

class _CustomReorderableListViewState extends State<CustomReorderableListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adapt.screenH(),
      child: ReorderableListView(
        physics: NeverScrollableScrollPhysics(),
        onReorder: _handleReorder,
        children: widget.list.map((item) => _buildItem(item)).toList(),
      ),
    );
  }

  void _handleReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    setState(() {
      final element = widget.list.removeAt(oldIndex);
      widget.list.insert(newIndex, element);
    });
  }

  Widget _buildItem(Widget item) {
    return Container(
      key: ValueKey(item),
      child: item,
    );
  }
}
