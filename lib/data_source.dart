import 'dart:convert';

import 'package:http/http.dart' as http;

Future Function() fetchImagesUnsplash = () async {
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
    return data;
  } else {
    print(response.body);
  }
  return;
};
