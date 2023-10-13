import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../resources/feed.dart';
import '../app_state.dart';
import '../fetch_images_middleware.dart';
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
        title: const Text(UIFeed.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (_, state) {
                  if (state.images.isEmpty && !state.isLoading) {
                    StoreProvider.of<AppState>(context).dispatch(fetchImages);
                  }
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: state.images.length + (state.isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == state.images.length - 1 &&
                          !state.isLoading) {
                        StoreProvider.of<AppState>(context)
                            .dispatch(fetchImages);
                      }

                      if (index < state.images.length) {
                        return GestureDetector(
                          child: CardInFeed(
                            image: state.images[index],
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return StoreConnector<AppState, AppState>(
                                converter: (store) => store.state,
                                builder: (_, state) {
                                  return CardFullScreen(
                                    image: state.images[index],
                                  );
                                },
                              );
                            }));
                          },
                        );
                      } else if (state.isLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
