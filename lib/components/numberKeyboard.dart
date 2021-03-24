import 'package:bluespace/utils/adapt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NumberKeyboardActionSheet extends StatefulWidget {
  String name;
  TextEditingController controller;
  Function callback;
  String unit;

  NumberKeyboardActionSheet({
    Key key,
    @required this.name,
    @required this.controller,
    @required this.callback,
    @required this.unit,
  }) : super(key: key);

  @override
  State createState() => new _NumberKeyboardActionSheetState();
}

class _NumberKeyboardActionSheetState extends State<NumberKeyboardActionSheet> {
  ///键盘上的键值名称
  static const List<String> _keyNames = [
    '7',
    '8',
    '9',
    '4',
    '5',
    '6',
    '1',
    '2',
    '3',
    '.',
    '0',
    '<-'
  ];
  void initState() {
    super.initState();
    widget.controller.text = '';
  }

  ///控件点击事件
  void _onViewClick(String keyName) async {
    var currentText = widget.controller.text; //当前的文本
    if (RegExp('^\\d+\\.\\d{2}\$').hasMatch(currentText) && keyName != '<-') {
      Fluttertoast.showToast(msg: '只能输入两位小数');
      return;
    }
    if ((currentText == '' && (keyName == '.' || keyName == '<-')) ||
        (RegExp('\\.').hasMatch(currentText) && keyName == '.'))
      return; //{不能第一个就输入.或者<-},{不能在已经输入了.再输入}
    if (keyName == '<-') {
      //{回车键}
      if (currentText.length == 0) return;
      widget.controller.text = currentText.substring(0, currentText.length - 1);
      return;
    }
    if (currentText == '0' && (RegExp('^[1-9]\$').hasMatch(keyName))) {
      //{如果第一位是数字0，那么第二次输入的是1-9，那么就替换}
      widget.controller.text = keyName;
      return;
    }
    print(widget.key);
    widget.controller.text = currentText + keyName;
    print(widget.controller.text);
    widget.callback(widget.controller.text + widget.unit);
  }

  ///数字展示面板
  Widget _showDigitalView() {
    return Container(
      height: Adapt.height(100.0),
      padding: EdgeInsets.all(Adapt.height(10.0)),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              enabled: false,
              textAlign: TextAlign.end,
              controller: widget.controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '请输入${widget.name}',
                  hintStyle: TextStyle(
                      color: Color(0xeaeaeaea),
                      fontSize: Adapt.sp(26),
                      letterSpacing: 1.0),
                  contentPadding: const EdgeInsets.all(0.0)),
            ),
          ),
          SizedBox(
            width: Adapt.width(20),
          ),
          Container(
            child: Text(
              widget.unit,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            // padding: const EdgeInsets.only(right: 8.0),
            constraints: BoxConstraints(minWidth: 100.0),
          ),
        ],
      ),
    );
  }

  ///构建显示数字键盘的视图
  Widget _showKeyboardGridView() {
    List<Widget> keyWidgets = new List();
    for (int i = 0; i < _keyNames.length; i++) {
      keyWidgets.add(
        Material(
          color: Colors.white,
          child: InkWell(
            onTap: () => _onViewClick(_keyNames[i]),
            child: Container(
              width: MediaQuery.of(context).size.width / Adapt.width(10.0),
              height: Adapt.height(100),
              child: Center(
                child: i == _keyNames.length - 1
                    ? Icon(Icons.backspace)
                    : Text(
                        _keyNames[i],
                        style: TextStyle(
                          fontSize: Adapt.sp(36),
                          color: Color(
                            0xff606060,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
      );
    }
    return Wrap(children: keyWidgets);
  }

  ///完整输入的Float值
  void _completeInputFloatValue() {
    var currentText = widget.controller.text;
    if (currentText.endsWith('.')) //如果是小数点结尾的
      widget.controller.text += '00';
    else if (RegExp('^\\d+\\.\\d\$').hasMatch(currentText)) //如果是一位小数结尾的
      widget.controller.text += '0';
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        child: Column(
          children: <Widget>[
            _showDigitalView(),
            Divider(
              height: 1.0,
            ),
            _showKeyboardGridView(),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    _completeInputFloatValue();
    super.deactivate();
  }
}
