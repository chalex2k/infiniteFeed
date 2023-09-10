import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart' as http;

import 'app_state.dart';

class ScrollAction {
  final List<ImageData> _images;

  List<ImageData> get images => _images;

  ScrollAction(this._images);
}

class LikeAction {
  final ImageData _image;

  ImageData get image => _image;

  LikeAction(this._image);
}

ThunkAction<AppState> fetchImages = (Store<AppState> store) async {
  // вызывается когда отрисовываем последний виджет
  final Uri uri = Uri.https(
    'api.unsplash.com',
    '/photos/random',
    {
      'query': 'landscape',
      'orientation': 'landscape',
      'count': '5',
    },
  );

  final response = await http.get(
    uri,
    headers: {
      'Authorization': 'Client-ID fl-JJIyc6LYgSC9STSyGMRdFl9pN3cBAGRPo9WL0KEo',
      // TODO вынести в .env
    },
  );
  print('ok');
  List<Map<String, dynamic>> imageUrls = [];
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print('loaded: ${data.length}');

    for (var item in data) {
      if (item is Map<String, dynamic> && item.containsKey('urls')) {
        final Map<String, dynamic> imageUrl = item['urls'];
        imageUrls.add(imageUrl);
      }
    }
    // print(imageUrls);

    var recipesFromSnapshot = ImageData.recipesFromSnapshot(data);
    List<ImageData> result = [];
    result.addAll(store.state.images);
    result.addAll(recipesFromSnapshot);
    store.dispatch(ScrollAction(result));
  } else {
    print(response.body);
  }
};
