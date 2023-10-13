import '../model.dart';
import 'action.dart';
import 'app_state.dart';

AppState reducer(AppState prev, dynamic action) {
  if (action is UpdateLoadingAction) {
    return AppState(prev.images, action.isLoading);
  }
  if (action is ScrollAction) {
    return AppState(action.images, prev.isLoading);
  }
  if (action is LikeAction) {
    List<ImageData> newImages = List.from(prev.images);
    for (var i = 0; i < newImages.length; i++) {
      if (newImages[i].id == action.image.id) {
        newImages[i] = ImageData(
            url: newImages[i].url,
            id: newImages[i].id,
            like: !newImages[i].like);
      }
    }
    return AppState(newImages, prev.isLoading);
  }
  return prev;
}
