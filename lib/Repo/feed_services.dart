import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashtanehunar/Blocs/Feed%20Cubit/cubit/feed_cubit.dart';
import 'package:dashtanehunar/Utils/utils.dart';
import 'package:dashtanehunar/models/feeds_model.dart';

class FeedServices {

  static Future<void> getFeeds(BuildContext context) async {
    FirebaseFirestore.instance.collection('feeds').orderBy('feedPlacedOn', descending: true).snapshots().listen((event) {
      List<FeedModel>? feedsList = [];

      for (var element in event.docs) {
        FeedModel feedModel = FeedModel.fromMap(element.data());
        feedsList.add(feedModel);
      }
      context.read<FeedCubit>().setFeedList(feedsList);
    });
  }
}
