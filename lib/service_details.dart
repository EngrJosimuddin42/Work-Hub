import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'Service.dart';

class ServiceDetailsPage extends StatefulWidget {
  final Service service;

  const ServiceDetailsPage({super.key, required this.service});

  @override
  State<ServiceDetailsPage> createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {
  late VideoPlayerController _videoController;
  bool _isVideoLoading = true;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(widget.service.videoAsset)
      ..initialize().then((_) {
        setState(() {
          _isVideoLoading = false;
        });
      });

    // ভিডিও শেষ হলে রিসেট
    _videoController.addListener(() {
      if (_videoController.value.position == _videoController.value.duration) {
        _videoController.seekTo(Duration.zero);
      }
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _toggleVideo() {
    setState(() {
      _videoController.value.isPlaying
          ? _videoController.pause()
          : _videoController.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.service.title),
        backgroundColor: widget.service.color,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Image.asset(widget.service.imageAsset, width: 50, height: 50),
            ),
            const SizedBox(height: 20),
            Text(
              widget.service.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: widget.service.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              widget.service.description,
              style: const TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // GIF
            Image.asset(widget.service.gifAsset, width: 200, height: 200),
            const SizedBox(height: 20),

            // ভিডিও প্লেয়ার
            _isVideoLoading
                ? const CircularProgressIndicator()
                : Column(
              children: [
                AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(_videoController),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _toggleVideo,
                  child: Text(
                    _videoController.value.isPlaying ? "Pause Video" : "Play Video",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
