import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerMovie extends StatefulWidget {
  const TrailerMovie({super.key, required this.snapshot});
  final AsyncSnapshot snapshot;
  @override
  State<TrailerMovie> createState() => _TrailerMovieState();
}

class _TrailerMovieState extends State<TrailerMovie> {
  late YoutubePlayerController controller;
  late String key;
  late String videoUrl;

  @override
  void initState() {
    super.initState();
    key = "";
    key = widget.snapshot.data[0].key;
    videoUrl = "https://www.youtube.com/watch?v=$key";
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: true,
        bottomActions: [
          CurrentPosition(),
          ProgressBar(
            isExpanded: true,
            colors: const ProgressBarColors(
                playedColor: Colors.red, handleColor: Colors.red),
          ),
          const PlaybackSpeedButton(),
          // FullScreenButton(
            
          // )
        ],
      ),
    );
  }
}
