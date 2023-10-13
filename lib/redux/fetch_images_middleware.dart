import 'package:redux/redux.dart';
import '../data_source.dart';
import '../model.dart';
import 'action.dart';
import 'app_state.dart';

void fetchImages(Store<AppState> store) {
  store.dispatch((Store<AppState> store) async {
    store.dispatch(UpdateLoadingAction(true));

    final data = await fetchImagesUnsplash();

    var recipesFromSnapshot = ImageData.recipesFromSnapshot(data);
    List<ImageData> result = [];
    result.addAll(store.state.images);
    result.addAll(recipesFromSnapshot);

    store.dispatch(ScrollAction(result));

    store.dispatch(UpdateLoadingAction(false));
  });
}
