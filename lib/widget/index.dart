import 'package:flutter/material.dart';

//自定义按钮
class GradientButton extends StatelessWidget {
  const GradientButton(
      {Key? key,
      this.colors,
      this.width,
      this.height,
      this.onPressed,
      this.borderRadius,
      required this.child})
      : super(key: key);

  final List<Color>? colors;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final GestureTapCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<Color> _colors =
        colors ?? [theme.primaryColor, theme.primaryColorDark];

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: _colors),
        borderRadius: borderRadius,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TurnBox extends StatefulWidget {

  final double turns;
  final int speed;
  final Widget child;

  const TurnBox({Key? key,this.turns = .0,this.speed = 200,required this.child}):super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TurnBoxState();
  }
}

class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin{

  late AnimationController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = AnimationController(
  //       vsync: this,
  //       lowerBound: -double.infinity,
  //       upperBound: double.infinity
  //   );
  //   _controller.value = widget.turns;
  // }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        lowerBound: -double.infinity,
        upperBound: double.infinity,
        vsync: this);
    _controller.value = widget.turns;
    // super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    //旋转角度发生变化时执行过渡动画
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(
        widget.turns,
        duration: Duration(milliseconds: widget.speed??200),
        curve: Curves.easeOut,
      );
    }
  }

}