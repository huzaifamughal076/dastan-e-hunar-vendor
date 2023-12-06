import 'package:dashtanehunar/Repo/feed_services.dart';
import 'package:dashtanehunar/models/feeds_model.dart';
import 'package:dashtanehunar/Utils/utils.dart';

part 'feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  FeedCubit() : super(FeedState());


  setFeedList(List<FeedModel>? list) async {
    emit(state.copyWith(feedList: list));
  }

  getFeeds(BuildContext context) async {
    emit(state.copyWith(loading: true));
    await FeedServices.getFeeds(context);
    emit(state.copyWith(loading: false));
  }
}
