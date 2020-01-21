import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class StaggeredAnimatedColumn extends StatefulWidget {
  const StaggeredAnimatedColumn({
    AnimationController animationController,
    @required this.children,
    Key key,
    this.mainAxisAlignment,
    this.duration,
    this.delay,
    this.crossAxisAlignment,
    this.mainAxisSize,
  })  : _animationController = animationController,
        super(key: key);

  final AnimationController _animationController;
  final List<Widget> children;
  final Duration duration;
  final Duration delay;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  @override
  _StaggeredAnimatedColumnState createState() => _StaggeredAnimatedColumnState();
}

class _StaggeredAnimatedColumnState extends State<StaggeredAnimatedColumn> with TickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    _animationController = widget._animationController ??
        AnimationController(
            vsync: this, duration: widget.duration ?? Duration(milliseconds: widget.children.length * 300));
    if (widget._animationController == null) {
      Future.delayed(widget.delay ?? Duration(milliseconds: 100), () {
        _animationController.forward();
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget._animationController == null) {
      _animationController.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          return Column(
            mainAxisSize: widget.mainAxisSize ?? MainAxisSize.max,
            crossAxisAlignment: widget.crossAxisAlignment ?? CrossAxisAlignment.start,
            mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.start,
            children: <Widget>[
              ...List.generate(widget.children.length, (index) {
                return FadeTransition(
                  opacity: Tween<double>(
                    begin: 0,
                    end: 1,
                  ).animate(
                    CurvedAnimation(
                      curve: Interval(
                        1 / widget.children.length * index * 0.1,
                        1 / widget.children.length * index,
                        curve: Curves.easeInOut,
                      ),
                      parent: _animationController,
                    ),
                  ),
                  child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0.0, 1.0),
                        end: Offset(0.0, 0.0),
                      ).animate(
                        CurvedAnimation(
                          curve: Interval(
                            1 / widget.children.length * index * 0.1,
                            1 / widget.children.length * index,
                            curve: Curves.ease,
                          ),
                          parent: _animationController,
                        ),
                      ),
                      child: widget.children[index]),
                );
              })
            ],
          );
        },
      ),
    );
  }
}
