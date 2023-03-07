import 'package:chewie/chewie.dart' hide MaterialControls;
import 'package:f_util_go/util/color.dart';
import 'package:f_util_go/util/view_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple/widget/video_controls.dart';
import 'package:video_player/video_player.dart';


class VideoViewClass extends StatefulWidget {
  //URL
  final String url;

  //封面的图片
  final String cover;

  //是否自动播放
  final bool autoPlay;

  //是否循环播放
  final bool looping;

  //比例 16/9
  final double aspectRatio;

  //浮层
  final Widget? overlayUI;

  //弹幕
  final Widget? barrageUI;

  const VideoViewClass(this.url,
      {Key? key,
      required this.cover,
      this.autoPlay = false,
      this.looping = false,
      this.aspectRatio = 16 / 9,
      this.overlayUI,
      this.barrageUI})
      : super(key: key);

  @override
  State<VideoViewClass> createState() => _VideoViewClassState();
}

class _VideoViewClassState extends State<VideoViewClass> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  //封面
  get _placeholder => FractionallySizedBox(
        widthFactor: 1,
        child: cachedImage(widget.cover),
      );

  //进度条颜色配置
  get _progressColors => ChewieProgressColors(
      playedColor: primary,
      handleColor: primary,
      backgroundColor: Colors.grey,
      bufferedColor: primary[50]!);

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: widget.aspectRatio,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        placeholder: _placeholder,
        customControls: MaterialControls(
            showLoadingOnInitialize: false,
            showBigPlayIcon: false,
            bottomGradient: blackLinearGradient(),
            overlayUI: widget.overlayUI,
            barrageUI: widget.barrageUI),
        materialProgressColors: _progressColors);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double playerHeight = screenWidth / widget.aspectRatio;
    return Container(
      width: screenWidth,
      height: playerHeight,
      color: Colors.grey,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
}
