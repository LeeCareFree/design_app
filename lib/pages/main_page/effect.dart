import 'package:bluespace/globalState/action.dart';
import 'package:bluespace/globalState/store.dart';
import 'package:bluespace/models/message_list.dart';
import 'package:bluespace/pages/chat_page/chat_detail_page/view.dart';
import 'package:bluespace/pages/main_page/action.dart';
import 'package:bluespace/pages/main_page/state.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';

Effect<MainPageState> buildEffect() {
  return combineEffects(<Object, Effect<MainPageState>>{
    MainPageAction.action: _onAction,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
    Lifecycle.build: _onBuild
  });
}

// ReceivePort _port = ReceivePort();
void _onAction(Action action, Context<MainPageState> ctx) {}
void _onInit(Action action, Context<MainPageState> ctx) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final uid = prefs.getString('uid') ?? '';
  ctx.state.uid = uid;
  ctx.state.socket = io('http://192.168.0.107:3001', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true,
  });
  ctx.state.socket.connect();
  ctx.state.socket.emit('createUser', uid);
  ctx.state.socket.emit('messageList', uid);
  ctx.state.socket.on(
      'getMessageList',
      (data) => {
            GlobalStore.store.dispatch(GlobalActionCreator.updateMessageList(
                MessageList.fromJson(data)))
          });
  GlobalStore.store
      .dispatch(GlobalActionCreator.updateSocket(ctx.state.socket));

  ctx.state.socket.on('disconnect', (_) => print(_));
  // ctx.state.socket.on('useLeft', (data) => print(data));
}

void _onDispose(Action action, Context<MainPageState> ctx) async {
  ctx.state.socket.close();
}

void _onBuild(Action action, Context<MainPageState> ctx) async {
  print('build');
}
// void _onInit(Action action, Context<MainPageState> ctx) async {
//   await TMDBApi.instance.init();
//   await UserInfoOperate.whenAppStart();

//   final _preferences = await SharedPreferences.getInstance();

//   final _localNotification = LocalNotification.instance;

//   await _localNotification.init();

//   _localNotification.didReceiveLocalNotification = (id, title, body, payload) =>
//       _didReceiveLocalNotification(id, title, body, payload, ctx);

//   FirebaseMessaging().configure(onMessage: (message) async {
//     NotificationList _list;
//     if (_preferences.containsKey('notifications')) {
//       final String _notifications = _preferences.getString('notifications');
//       _list = NotificationList(_notifications);
//     }
//     if (_list == null) _list = NotificationList.fromParams(notifications: []);
//     final _notificationMessage = NotificationModel.fromMap(message);
//     _list.notifications.add(_notificationMessage);
//     _preferences.setString('notifications', _list.toString());
//     _localNotification.sendNotification(_notificationMessage.notification.title,
//         _notificationMessage.notification?.body ?? '',
//         id: int.parse(_notificationMessage.id),
//         payload: _notificationMessage.type);
//     print(_list.toString());
//   }, onResume: (message) async {
//     _push(message, ctx);
//   }, onLaunch: (message) async {
//     _push(message, ctx);
//   });

//   if (Platform.isAndroid) _bindBackgroundIsolate();

//   FlutterDownloader.registerCallback(DownloaderCallBack.callback);

//   await _checkAppUpdate(ctx);
// }

// void _onDispose(Action action, Context<MainPageState> ctx) {
//   if (Platform.isAndroid) _unbindBackgroundIsolate();
// }

// Future _push(Map<String, dynamic> message, Context<MainPageState> ctx) async {
//   if (message != null) {
//     final _notificationMessage = NotificationModel.fromMap(message);
//     final _messageData = message['data'];
//     var data = {
//       _messageData['type'] == 'movie' ? 'id' : 'tvid':
//           int.parse(_notificationMessage.id.toString()),
//       'bgpic': _notificationMessage.posterPic,
//       _notificationMessage.type == 'movie' ? 'title' : 'name':
//           _notificationMessage.name,
//       'posterpic': _notificationMessage.posterPic
//     };
//     Page page = _notificationMessage.type == 'movie'
//         ? MovieDetailPage()
//         : TvShowDetailPage();
//     await Navigator.of(ctx.state.scaffoldKey.currentContext)
//         .push(PageRouteBuilder(pageBuilder: (context, animation, secAnimation) {
//       return FadeTransition(
//         opacity: animation,
//         child: page.buildPage(data),
//       );
//     }));
//   }
// }

// Future _checkAppUpdate(Context<MainPageState> ctx) async {
//   if (!Platform.isAndroid) return;

//   final _preferences = await SharedPreferences.getInstance();
//   String _ignoreVersion = _preferences.getString('IgnoreVersion') ?? '';

//   final _packageInfo = await PackageInfo.fromPlatform();
//   final _github = GithubApi.instance;
//   final _result = await _github.checkUpdate();
//   if (_result.success) {
//     if (_ignoreVersion == _result.result.tagName) return;
//     final _shouldUpdate = VersionComparison()
//         .compare(_packageInfo.version, _result.result.tagName);
//     final _apk = _result.result.assets.singleWhere(
//         (e) => e.contentType == 'application/vnd.android.package-archive');
//     if (_apk != null && _shouldUpdate) {
//       await showDialog(
//         context: ctx.context,
//         child: UpdateInfoDialog(
//           version: _result.result.tagName,
//           describe: _result.result.body,
//           packageSize: (_apk.size / 1048576),
//           downloadUrl: _apk.browserDownloadUrl,
//         ),
//       );
//     }
//   }
// }

// void _bindBackgroundIsolate() {
//   bool isSuccess = IsolateNameServer.registerPortWithName(
//       _port.sendPort, 'downloader_send_port');
//   if (!isSuccess) {
//     _unbindBackgroundIsolate();
//     _bindBackgroundIsolate();
//     return;
//   }
//   _port.listen((dynamic data) async {
//     String id = data[0];
//     DownloadTaskStatus status = data[1];
//     if (status == DownloadTaskStatus.complete) {
//       List<DownloadTask> _tasks = await FlutterDownloader.loadTasks();
//       final _file = _tasks.singleWhere((e) => e.taskId == id, orElse: null);
//       if (_file.filename.split('.').last == 'apk')
//         await FlutterDownloader.open(taskId: id);
//     }
//     print('UI Isolate Callback: $data');
//   });
// }

// void _unbindBackgroundIsolate() {
//   IsolateNameServer.removePortNameMapping('downloader_send_port');
// }

// Future _didReceiveLocalNotification(int id, String title, String body,
//     String payload, Context<MainPageState> ctx) async {
//   Page page = payload == 'movie' ? MovieDetailPage() : TvShowDetailPage();
//   var data = {
//     payload == 'movie' ? 'id' : 'tvid': id,
//     payload == 'movie' ? 'title' : 'name': title,
//   };
//   await Navigator.of(ctx.state.scaffoldKey.currentContext).push(
//     PageRouteBuilder(
//       pageBuilder: (context, animation, secAnimation) {
//         return FadeTransition(
//           opacity: animation,
//           child: page.buildPage(data),
//         );
//       },
//     ),
//   );
// }
