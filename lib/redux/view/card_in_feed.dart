import 'package:first/resources/common.dart';
import 'package:first/resources/feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../model.dart';
import '../action.dart';
import '../app_state.dart';

class CardInFeed extends StatelessWidget {
  final ImageData image;

  const CardInFeed({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: UIFeed.cardBorderColor, width: UIFeed.cardBorderWidth)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / UIFeed.cardProportion,
              child: Image.network(
                image.url,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: UIFeed.likeBottom,
            left: UIFeed.likeLeft,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.transparent),
              onPressed: () {
                var store = StoreProvider.of<AppState>(context);
                store.dispatch(LikeAction(image));
              },
              child: Icon(
                image.like
                    ? UICommon.likeEnabledIcon
                    : UICommon.likeDisabledIcon,
                color: UICommon.likeColorIcon,
                size: UICommon.likeSizeIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
