class AppState {
  final List<ImageData> _images;

  List<ImageData> get images => _images;

  AppState(this._images);

  AppState.initialState() : _images = List.empty();
}

class ImageData {
  final String url;
  final String id;
  final bool like;

  ImageData({required this.url, required this.id, required this.like});

  static List<ImageData> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return ImageData.fromJson(data);
    }).toList();
  }

  factory ImageData.fromJson(dynamic value) {
    return ImageData(
      url: value['urls']['small'] as String,
      id: value['id'] as String,
      like: false,
    );
  }

  @override
  String toString() {
    return 'ImageData(url: $url, id: $id, like: $like)';
  }
}
