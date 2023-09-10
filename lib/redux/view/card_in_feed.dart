import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
      decoration:
          BoxDecoration(border: Border.all(color: Colors.white, width: 2)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2.5,
              child: Image.network(
                image.url,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            left: 10.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.transparent),
              onPressed: () {
                var store = StoreProvider.of<AppState>(context);
                store.dispatch(LikeAction(image));
              },
              child: Icon(
                image.like ? Icons.favorite : Icons.favorite_outline,
                color: Colors.red,
                size: 50.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
