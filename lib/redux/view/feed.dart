import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../action.dart';
import '../app_state.dart';
import 'card_in_feed.dart';
import 'card_full_screen.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  FeedState createState() => FeedState();
}

class FeedState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Бесконечная лента"),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
            child: StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (_, state) {
                var store = StoreProvider.of<AppState>(context);
                if (state.images.isEmpty) {
                  store.dispatch(fetchImages);
                }
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: state.images.length,
                  itemBuilder: (context, index) {
                    if (index == state.images.length - 1) {
                      store.dispatch(fetchImages);
                    }
                    return GestureDetector(
                      child: CardInFeed(
                        image: state.images[index],
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return StoreConnector<AppState, AppState>(
                              converter: (store) => store.state,
                              builder: (_, state) {
                                return CardFullScreen(
                                  image: state.images[index],
                                );
                              });
                        }));
                      },
                    );
                  },
                );
              },
            ),
          )
        ])));
    //
  }
}
