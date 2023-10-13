import '../model.dart';

class AppState {
  final List<ImageData> _images;

  List<ImageData> get images => _images;
  bool isLoading;

  AppState(this._images, this.isLoading);

  AppState.initialState()
      : _images = List.empty(),
        isLoading = false;
}
