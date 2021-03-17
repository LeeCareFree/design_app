import 'package:bluespace/pages/personal_page/appbar_component/component.dart';
import 'package:bluespace/pages/personal_page/appbar_component/state.dart';
import 'package:bluespace/pages/personal_page/bg_component/component.dart';
import 'package:bluespace/pages/personal_page/bg_component/state.dart';
import 'package:bluespace/pages/personal_page/personal_list_component/component.dart';
import 'package:bluespace/pages/personal_page/personal_list_component/state.dart';
// import 'package:bluespace/pages/personal_page/list_component/component.dart';
// import 'package:bluespace/pages/personal_page/list_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PersonalPage extends Page<PersonalState, Map<String, dynamic>>
    with TickerProviderMixin {
  PersonalPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PersonalState>(
              adapter: null,
              slots: <String, Dependent<PersonalState>>{
                'bg': BgConnector() + BgComponent(),
                'appBar': AppBarConnector() + AppBarComponent(),
                'personalList':
                    PersonalListConnector() + PersonalListComponent()
              }),
          middleware: <Middleware<PersonalState>>[],
        );
}
