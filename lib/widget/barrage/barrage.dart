import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_simple/model/barrage_model.dart';
import 'package:flutter_simple/widget/barrage/barrage_item.dart';
import 'barrage_view_util.dart';

enum BarrageStatus { play, pause }

abstract class IBarrage {
  void send(String message);

  void pause();

  void play();
}

class Barrage extends StatefulWidget {
  final int lineCount;
  final String vid;
  final int speed;
  final double top;
  final bool autoPlay;

  const Barrage(
      {Key? key,
        this.lineCount = 4,
        required this.vid,
        this.speed = 500,
        this.top = 0,
        this.autoPlay = false})
      : super(key: key);

  @override
  State<Barrage> createState() => BarrageState();
}

class BarrageState extends State<Barrage> implements IBarrage {

  //宽高
  late double _height;
  late double _width;

  //弹幕widget集合，显示具体对应弹幕的
  List<BarrageItem> _barrageItemList = [];
  //弹幕模型
  List<BarrageModel> _barrageModelList = [];

  //第几条弹幕
  int _barrageIndex = 0;
  //工具，用来生成ID的
  Random _random = Random();
  //当前组件状态
  BarrageStatus? _barrageStatus;

  //事件异步处理,控制弹幕生成速度
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    //若是从服务器推送过来的弹幕数据，则需要接入websocket
    // _fwSocket = FwSocket();
    // _fwSocket.open(widget.vid).listen((value) {
    //   _handleMessage(value);
    // });
  }

  @override
  void dispose() {
    super.dispose();
    // _fwSocket.close();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // print("查看更新的次数 3");
    _width = MediaQuery.of(context).size.width;
    _height = _width / 16 * 9;
    return SizedBox(
      width: _width,
      height: _height,
      //用一个栈堆叠
      child: Stack(
        children: [
          //防止Stack的child为空
          Container()
        ]..addAll(_barrageItemList),
      ),
    );
  }

  void _handleMessage(List<BarrageModel> value, {bool instant = false}) {

    print("消息过来没有");
    if (instant) {
      _barrageModelList.insertAll(0, value);
    } else {
      _barrageModelList.addAll(value);
    }
    //如果说是播放的状态
    if (_barrageStatus == BarrageStatus.play) {
      play();
      return;
    }
    //收到新弹幕后进行播放
    if (widget.autoPlay && _barrageStatus != BarrageStatus.pause) {
      play();
    }
  }


  /// 播放
  @override
  void play() {
    _barrageStatus = BarrageStatus.play;
    //利用Timer，进行间隔生成对应的Item
    if (_timer != null && (_timer?.isActive ?? false)) return;
    //Timer.periodic  创建一个重复的计时器
    _timer = Timer.periodic(Duration(milliseconds: widget.speed), (timer) {
      if (_barrageModelList.isNotEmpty) {
        var temp = _barrageModelList.removeAt(0);
        // print("查看更新的次数");
        addBarrage(temp);
      } else {
        _timer?.cancel();
      }
    });
  }

  /// 添加一个弹幕组件上去
  void addBarrage(model) {
    double perRowHeight = 30;
    var line = _barrageIndex % widget.lineCount;
    _barrageIndex++;
    var top = line * perRowHeight + widget.top;
    //为每条弹幕生成一个id
    String id = '${_random.nextInt(10000)}:${model.content}';
    var item = BarrageItem(
      id: id,
      top: top,
      child: BarrageViewUtil.barrageView(model),
      onComplete: _onComplete,
    );
    _barrageItemList.add(item);

    // print("查看更新的次数 1");
    setState(() {});
  }

  void _onComplete(id) {
    // print('Done:$id');
    //弹幕播放完毕将其从弹幕widget集合中剔除
    _barrageItemList.removeWhere((element) => element.id == id);
  }

  @override
  void pause() {
    _barrageStatus = BarrageStatus.pause;

    //清空屏幕上的弹幕
    _barrageItemList.clear();
    setState(() {});
    _timer?.cancel();
  }

  @override
  void send(String message) {
    if (message == null) return;
    //上报服务器，有新弹幕
    // _fwSocket.send(message);

    //这个弹幕本地显示
    _handleMessage(
        [BarrageModel(content: message, vid: '-1', priority: 1, type: 1)]);
  }
}