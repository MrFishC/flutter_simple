import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../fnavigator/fn_navigator.dart';
import '../model/home_model.dart';
import '../model/video_model.dart';
import '../theme/theme_provider.dart';
import '../util/format_util.dart';
import '../util/view_util.dart';

///视频卡片
class VideoCard extends StatelessWidget {
  // HomeMo? model;
  final VideoModel videoMo;

  VideoCard({Key? key, required this.videoMo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    Color textColor = themeProvider.isDark() ? Colors.white70 : Colors.black87;

    return InkWell(
        //InkWell组件:在用户点击时出现“水波纹”效果
        onTap: () {
          FnNavigator.getInstance()
              .onJumpTo(RouteStatus.vedioDeatil, args: {"video": videoMo});
        },
        child: SizedBox(
          // 与 Container 不同，SizedBox 是一个透明的盒子，不能为其设置样式(例如，背景颜色、边距、填充等)。
          // 如果为 SizedBox 指定特定大小，则该大小也将应用于其子小部件。否则，如果未指定 SizedBox 的宽度或为 null，
          // 则其子小部件的宽度将通过其自己的设置或等于 0(如果未设置)。随着高度也有类似的行为。
          // 更多请阅读：https://www.yiibai.com/flutter/flutter-sizedbox.html
          // Container https://blog.csdn.net/qq_34202054/article/details/116022039

          height: 200,
          child: Card(
            //取消卡片默认边距

            // EdgeInsets 方法提供的四个属性
            // fromLTRB(double left, double top, double right, doublebottom)：分别指定四个方向的填充。
            // all(double value) : 所有方向均使用相同数值的填充。
            // only({left, top, right ,bottom })：可以设置具体某个方向的填充(可以同时指定多个方向)。
            // symmetric({vertical, horizontal})：用于设置对称方向的填充，vertical指top和bottom，horizontal指left和right。
            // https://api.flutter-io.cn/flutter/painting/EdgeInsets-class.html
            margin: EdgeInsets.only(left: 4, right: 4, bottom: 8),
            // ClipRRect:给子组件裁剪为给定的矩形大小   http://events.jianshu.io/p/ee2c0257d057
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              // Column意为垂直布局，可以使其包含的子控件按照垂直方向排列  https://blog.csdn.net/u013474690/article/details/123780420
              child: Column(
                // crossAxisAlignment:CrossAxisAlignment.start 水平顶部。
                // https://blog.csdn.net/qq_34707150/article/details/123247280
                crossAxisAlignment: CrossAxisAlignment.start,
                // children: [_itemImage(context), _infoText()],
                children: [_itemImage(context),_infoText(textColor)],
              ),
            ),
          ),
        ));
  }

  _itemImage(BuildContext context) {
    // MediaQuery 适配    获取所用设备的信息以及用户设置的偏好信息
    final size = MediaQuery.of(context).size;
    // Stack：可以容纳多个组件，以叠加的方式摆放子组件，后者居上  https://blog.csdn.net/u013290250/article/details/121751397
    return Stack(
      children: [
        // cachedImage(model?.pic ?? "", width: size.width / 2 - 10, height: 120),
        cachedImage(videoMo.cover ?? "",
            width: size.width / 2 - 10, height: 120),
        Positioned(
            //组件Positioned：精准堆叠布局内部，子组件的位置与排列
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 8, bottom: 3, top: 5),
              decoration: BoxDecoration(
                  //渐变色
                  //线性渐变: https://www.jianshu.com/p/ba7eb561ba17
                  gradient: LinearGradient(
                      //AlignmentGeometry类型:https://blog.csdn.net/a136447572/article/details/128261622
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black54, Colors.transparent])),
              child: Row(
                // MainAxisAlignment（主轴）就是与当前控件方向一致的轴
                // 在水平方向控件中，例如Row          默认起始位置在左边，排列方向为从左至右
                // 在垂直方向的控件中，例如Column     MainAxisAlignment是垂直的，默认起始位置在上边，排列方向为从上至下
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //MainAxisAlignment.spaceBetween:将主轴空白位置进行均分,排列子元素,首尾子控件距边缘没有间隙
                children: [
                  _iconText(Icons.ondemand_video, videoMo.view),
                  _iconText(Icons.favorite_border, videoMo.favorite),
                  _iconText(null, videoMo.duration)
                  // _iconText(Icons.ondemand_video, count: model?.aid ?? 0),
                  // _iconText(Icons.favorite_border,
                  //     count: model?.favorites ?? 0),
                  // _iconText(null, duration: model?.duration),
                ],
              ),
            ))
      ],
    );
  }

  //方法中使用{} :可选命名参数，另外使用[]，可选位置参数。  使用注意事项：  https://blog.csdn.net/u013095264/article/details/101290135
  _iconText(IconData? iconData, int count) {
    // _iconText(IconData? iconData, {int? count, String? duration}) {
    //   String views = "";
    //   if (iconData != null) {
    //     views = count != null ? countFormat(count) : "";
    //   } else {
    //     views = model?.duration ?? "00:00";
    //   }
    //   return Row(
    //     children: [
    //       if (iconData != null) Icon(iconData, color: Colors.white, size: 12),
    //       Padding(
    //           padding: EdgeInsets.only(left: 3),
    //           child: Text(views,
    //               style: TextStyle(color: Colors.white, fontSize: 10)))
    //     ],
    //   );
    String views = "";
    if (iconData != null) {
      views = countFormat(count);
    } else {
      views = durationTransform(videoMo.duration);
    }
    return Row(
      children: [
        if (iconData != null) Icon(iconData, color: Colors.white, size: 12),
        Padding(
            padding: EdgeInsets.only(left: 3),
            child: Text(views,
                style: TextStyle(color: Colors.white, fontSize: 10)))
      ],
    );
  }

  _infoText(textColor) {
    // 【flutter】Expanded组件 ： https://blog.csdn.net/devnn/article/details/105892081
    //copy from @{ https://blog.csdn.net/devnn/article/details/105892081}： Expanded组件是flutter中使用率很高的一个组件，
    // 它可以动态调整child组件沿主轴的尺寸，比如填充剩余空间，比如设置尺寸比例。它常常和Row或Column组合起来使用。

    // return Expanded(
    //     child: Container(
    //   padding: EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 5),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Text(
    //         model?.title ?? "",
    //         maxLines: 2,
    //         overflow: TextOverflow.ellipsis,
    //         style: TextStyle(fontSize: 12, color: Colors.black87),
    //       ),
    //       //作者
    //       _owner()
    //     ],
    //   ),
    // ));

    return Expanded(
        child: Container(
      padding: EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            videoMo.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
          //作者
          _owner(textColor)
        ],
      ),
    ));
  }

  _owner(textColor) {
    var owner = videoMo.owner;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: cachedImage(owner.face, height: 24, width: 24)),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                owner.name,
                style: TextStyle(fontSize: 11, color: Colors.black87),
              ),
            )
          ],
        ),
        Icon(
          Icons.more_vert_sharp,
          size: 15,
          color: Colors.grey,
        )
      ],
    );
  }
}
