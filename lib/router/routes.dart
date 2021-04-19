/*
 * @Author: your name
 * @Date: 2020-10-09 16:43:57
 * @LastEditTime: 2020-10-09 17:30:44
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\router\routes.dart
 */
import 'package:bluespace/globalState/state.dart';
import 'package:bluespace/globalState/store.dart';
import 'package:bluespace/pages/pages.dart';
import 'package:fish_redux/fish_redux.dart';

class Routes {
  static final PageRoutes routes = PageRoutes(
    pages: <String, Page<Object, dynamic>>{
      'startPage': StartPage(),
      'mainPage': MainPage(),
      'homePage': HomePage(),
      'sortPage': SortPage(),
      'createPage': CreatePage(),
      'chatPage': ChatPage(),
      'chatDetailPage': ChatDetailPage(),
      'minePage': MinePage(),
      'appSettingPage': AppSettingPage(),
      'publishPage': PublishPage(),
      'articleDetailPage': ArticleDetailPage(),
      'personalPage': PersonalPage(),
      'personalSettingPage': PersonalSettingPage(),
      'myhomeSettingPage': MyhomeSettingPage(),
      'decoratePage': DecoratePage(),
      'userListPage': UserListPage(),
      'videoPage': VideoPage(),
    },
    visitor: (String path, Page<Object, dynamic> page) {
      if (page.isTypeof<GlobalBaseState>()) {
        page.connectExtraStore<GlobalState>(GlobalStore.store,
            (Object pagestate, GlobalState appState) {
          final GlobalBaseState p = pagestate;
          if (p.themeColor != appState.themeColor ||
              p.userInfo != appState.userInfo ||
              p.socket != appState.socket ||
              p.messageList != appState.messageList) {
            if (pagestate is Cloneable) {
              final Object copy = pagestate.clone();
              final GlobalBaseState newState = copy;
              newState.themeColor = appState.themeColor;
              newState.socket = appState.socket;
              newState.messageList = appState.messageList;
              newState.userInfo = appState.userInfo;
              return newState;
            }
          }
          return pagestate;
        });
      }
      page.enhancer.append(
        /// View AOP
        viewMiddleware: <ViewMiddleware<dynamic>>[
          safetyView<dynamic>(),
        ],

        /// Adapter AOP
        adapterMiddleware: <AdapterMiddleware<dynamic>>[
          safetyAdapter<dynamic>()
        ],

        /// Effect AOP
        effectMiddleware: [
          _pageAnalyticsMiddleware<dynamic>(),
        ],

        /// Store AOP
        middleware: <Middleware<dynamic>>[
          logMiddleware<dynamic>(tag: page.runtimeType.toString()),
        ],
      );
    },
  );
}

EffectMiddleware<T> _pageAnalyticsMiddleware<T>() {
  return (AbstractLogic<dynamic> logic, Store<T> store) {
    return (Effect<dynamic> effect) {
      return (Action action, Context<dynamic> ctx) {
        if (logic is Page<dynamic, dynamic> && action.type is Lifecycle) {
          print('${logic.runtimeType} ${action.type.toString()} ');
        }
        return effect?.call(action, ctx);
      };
    };
  };
}
