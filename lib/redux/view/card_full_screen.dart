import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../model.dart';
import '../../resources/card_full_screen.dart';
import '../../resources/common.dart';
import '../action.dart';
import '../app_state.dart';

class CardFullScreen extends StatelessWidget {
  final ImageData image;

  const CardFullScreen({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Image.network(
          image.url,
          fit: BoxFit.fitWidth,
        ),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: UICardResources.likeBackgroundColor),
            onPressed: () {
              var store = StoreProvider.of<AppState>(context);
              store.dispatch(LikeAction(image));
            },
            child: Icon(
              image.like ? UICommon.likeEnabledIcon : UICommon.likeDisabledIcon,
              color: UICommon.likeColorIcon,
              size: UICommon.likeSizeIcon,
            )),
      ]),
    ]));
  }
}
