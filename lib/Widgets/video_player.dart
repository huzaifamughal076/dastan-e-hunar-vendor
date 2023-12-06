import 'package:dashtanehunar/Utils/utils.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl; // The URL of the video

  const VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  VideoPlayerScreenState createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.addListener(() {
      if (_controller.value.isPlaying) {
        setState(() {
          isPlaying = true;
        });
      } else {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: CustomText(text: 'ERROR'));
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return InkWell(
                    onTap: () {
                      if (_controller.value.isPlaying) {
                        setState(() {
                          _controller.pause();
                        });
                      } else {
                        setState(() {
                          _controller.play();
                        });
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                        ),
                        Positioned(
                          child: (_controller.value.isPlaying)?const SizedBox.shrink():Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: kWhite.withOpacity(0.7),
                              shape: BoxShape.circle,
                            ),
                            child: (_controller.value.isPlaying)
                                ? const Icon(
                                    Icons.pause,
                                    size: 30,
                                  )
                                : const Icon(
                                    Icons.play_arrow,
                                    size: 30,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
