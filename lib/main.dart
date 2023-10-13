import 'package:first/resources/common.dart';
import 'package:flutter/material.dart';
import 'package:first/redux/app_state.dart';
import 'package:first/redux/reducer.dart';
import 'package:first/redux/view/feed.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() => runApp(FirstApp());

class FirstApp extends StatelessWidget {
  final store = Store(reducer,
      initialState: AppState.initialState(), middleware: [thunkMiddleware]);

// root widget
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: const MaterialApp(
        title: UICommon.appTitle,
        home: Feed(),
      ),
    );
  }
}
