import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerScreen extends StatelessWidget {
  final String linkvideo;
  const YoutubePlayerScreen({super.key, required this.linkvideo});

  String getIdVideo() {
    String video = linkvideo;
    RegExp regex = RegExp(
      r'^.*(?:youtu.be\/|v\/|e\/|u\/\w+\/|embed\/|v=)([^#\&\?]*).*',
      caseSensitive: false,
      multiLine: false,
    );
    Match? match = regex.firstMatch(video);
    if (match != null) {
      return match.group(1)!;
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final linkvideo = getIdVideo();
    final controller = YoutubePlayerController(
      initialVideoId: linkvideo,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical:10 ),
      child: YoutubePlayer(controller: controller),
    );
  }
}
