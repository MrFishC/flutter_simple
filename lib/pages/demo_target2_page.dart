import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemoTargetPage2 extends StatefulWidget {
  Map? args;
  DemoTargetPage2({Key? key, this.args}) : super(key: key);

  @override
  State<DemoTargetPage2> createState() => _DemoTargetPageState();
}

class _DemoTargetPageState extends State<DemoTargetPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text("这是第三个页面,数据是:${widget.args?["data"]}"),
            MaterialButton(onPressed: () {})
          ],
        ),
      ),
    );
  }
}
