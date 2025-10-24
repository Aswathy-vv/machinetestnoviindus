import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StyledVideoContainer extends StatefulWidget {
  final String videoUrl;
  const StyledVideoContainer({super.key, required this.videoUrl});

  @override
  State<StyledVideoContainer> createState() => _StyledVideoContainerState();
}

class _StyledVideoContainerState extends State<StyledVideoContainer> {
  late VideoPlayerController _controller;
  static _StyledVideoContainerState? _currentlyPlaying;
  @override
  void initState() {
    super.initState();

  
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {});
        _controller.setLooping(true);
      }).catchError((error) {
        debugPrint("Video player initialization error: $error");
      });
  
  }

  @override
  void dispose() {
    if (_currentlyPlaying == this) {
      _currentlyPlaying = null;
    }
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      _currentlyPlaying = null;
    } else {
      // Pause any currently playing video
      _currentlyPlaying?._controller.pause();

      // Set this as currently playing
      _currentlyPlaying = this;
      _controller.play();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      // clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: _controller.value.isInitialized
          ? Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                GestureDetector(
                  onTap: _togglePlayPause,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    radius: 30,
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
    );
  }
}
