import 'package:dashtanehunar/Blocs/Feed%20Cubit/cubit/feed_cubit.dart';
import 'package:dashtanehunar/Utils/utils.dart';
import 'package:dashtanehunar/Widgets/video_player.dart';
import 'package:dashtanehunar/models/feeds_model.dart';
import 'package:readmore/readmore.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
        
            BlocBuilder<FeedCubit,FeedState>(builder: (context, state) {
              if(state.loading){
                return const Expanded(child: Center(child: CustomLoader(),));
              }
              if(state.feedList?.isEmpty??true){
                return const Expanded(child: Center(child: CustomText(text: "No feed found"),));
              }
              return Expanded(
                child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: state.feedList?.length??0,
                itemBuilder: (context, index) {
                  FeedModel? feedModel = state.feedList?[index];
                if(feedModel?.feedType=="post"){
                  return feedPostCard(feedModel);
                }
                return feedVideoCard(feedModel);
                          },),
              );
            },)
            
          ],
        ),
      ),
    );
  }

  Widget feedPostCard(FeedModel? feedModel) {
    return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(12.0),
              decoration:  BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(4), 
              ),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    height: 180,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        '${feedModel?.url}',
                        fit: BoxFit.fill, 
                        cacheHeight: 180, 
                        cacheWidth: int.parse(double.maxFinite.round().toString()),
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/logo.jpeg');
                        },
                        ),
                    ),
                  ), 
                  const SizedBox(height: 10,), 
                  CustomText(text: feedModel?.title??"", fontWeight: FontWeight.bold, fontsize: 18,color: kBlack,textAlign: TextAlign.left,),
                  const SizedBox(height: 10,),
                  ReadMoreText(feedModel?.description??"",
                    trimLines: 2,
                    colorClickableText: primaryColor,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
                ],),
              
            );
  }  
  
  Widget feedVideoCard(FeedModel? feedModel) {
    return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(12.0),
              decoration:  BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(4), 
              ),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    height: 180,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: VideoPlayerScreen(videoUrl: feedModel?.url??""),
                    ),
                  ), 
                  const SizedBox(height: 10,), 
                  CustomText(text: feedModel?.title??"", fontWeight: FontWeight.bold, fontsize: 18,color: kBlack,textAlign: TextAlign.left,),
                  const SizedBox(height: 10,),
                  ReadMoreText(feedModel?.description??"",
                    trimLines: 2,
                    colorClickableText: primaryColor,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
                ],),
              
            );
  }
}