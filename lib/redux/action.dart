import '../model.dart';

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

class UpdateLoadingAction {
  final bool isLoading;

  UpdateLoadingAction(this.isLoading);
}
