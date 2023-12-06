part of 'feed_cubit.dart';

class FeedState {

  bool loading;
  List<FeedModel>? feedList;


FeedState({this.loading=false, this.feedList});

FeedState copyWith({
  bool? loading,
  List<FeedModel>? feedList,
}){
  return FeedState(
    feedList: feedList ?? this.feedList,
    loading: loading ?? this.loading,
  );
}
}
