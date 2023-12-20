
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashtanehunar/Utils/utils.dart';
import 'package:dashtanehunar/Widgets/video_player.dart';
import 'package:dashtanehunar/models/feeds_model.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:readmore/readmore.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor.withOpacity(0.04),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FirestorePagination(
                isLive: true,
                viewType: ViewType.list,
                bottomLoader: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.blue,
                  ),
                ),
                query: FirebaseFirestore.instance.collection('feeds').orderBy('feedPlacedOn', descending: true),
                itemBuilder: (context, documentSnapshot, index) {
                  final data = documentSnapshot.data() as Map<String, dynamic>?;
                  if (data == null) return Container();
            
                  // FeedModel? feedModel = feedController.feedList?[index];
                  FeedModel? feedModel = FeedModel.fromMap(data);
                  if (feedModel.feedType == "post") {
                    return feedPostCard(feedModel);
                  }
                  return feedVideoCard(feedModel);
                },
              ),
            ),
            const SizedBox(height: 10,),

            // GetBuilder<FeedsController>(builder: (feedController) {
            //   if(feedController.loading == LoadingState.loading){
            //     return const Expanded(child: Center(child: CircularProgressIndicator(color: primaryColor, strokeWidth: 1,),));
            //   }
            //   if(feedController.feedList?.isEmpty??true){
            //     return const Expanded(child: Center(child: CustomText(text: "No feed found"),));
            //   }
            //   return Expanded(
            //     child: ListView.builder(
            //     shrinkWrap: true,
            //     primary: false,
            //     itemCount: feedController.feedList?.length??0,
            //     itemBuilder: (context, index) {
            //       FeedModel? feedModel = feedController.feedList?[index];
            //     if(feedModel?.feedType=="post"){
            //       return feedPostCard(feedModel);
            //     }
            //     return feedVideoCard(feedModel);

            //               },),
            //   );
            // },)
          ],
        ),
      ),
    );
  }

  Widget feedPostCard(FeedModel? feedModel) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kGrey.withOpacity(0.5), width: 1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.maxFinite,
                height: 400,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  child: Image.network(
                    '${feedModel?.url}',
                    fit: BoxFit.fill,
                    cacheHeight: 400,
                    cacheWidth: int.parse(double.maxFinite.round().toString()),
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/logo.jpeg');
                    },
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/logo.jpeg'),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: feedModel?.title ?? "",
                  fontWeight: FontWeight.bold,
                  fontsize: 18,
                  color: kBlack,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 10,
                ),
                ReadMoreText(
                  feedModel?.description ?? "",
                  trimLines: 2,
                  colorClickableText: primaryColor,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  moreStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                  lessStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );  }

  Widget feedVideoCard(FeedModel? feedModel) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: kGrey.withOpacity(0.5), width: 1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.maxFinite,
            height: 180,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: VideoPlayerScreen(videoUrl: feedModel?.url ?? ""),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomText(
            text: feedModel?.title ?? "",
            fontWeight: FontWeight.bold,
            fontsize: 18,
            color: kBlack,
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 10,
          ),
          ReadMoreText(
            feedModel?.description ?? "",
            trimLines: 2,
            colorClickableText: primaryColor,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Show more',
            trimExpandedText: 'Show less',
            moreStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            lessStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );  }
}
