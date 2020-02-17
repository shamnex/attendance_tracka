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

class StaggeredAnimatedList extends StatefulWidget {
  const StaggeredAnimatedList({
    AnimationController animationController,
    @required this.children,
    Key key,
    this.mainAxisAlignment,
    this.duration,
    this.delay,
    this.phyics,
    this.crossAxisAlignment,
    this.mainAxisSize,
  })  : _animationController = animationController,
        super(key: key);

  final AnimationController _animationController;
  final List<Widget> children;
  final Duration duration;
  final Duration delay;
  final ScrollPhysics phyics;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  @override
  _StaggeredAnimatedListState createState() => _StaggeredAnimatedListState();
}

class _StaggeredAnimatedListState extends State<StaggeredAnimatedList> with TickerProviderStateMixin {
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
          return ListView(
            physics: widget.phyics ?? BouncingScrollPhysics(),
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

class StaggeredAnimatedListBuilder extends StatefulWidget {
  const StaggeredAnimatedListBuilder({
    AnimationController animationController,
    @required this.itemBuilder,
    Key key,
    this.mainAxisAlignment,
    this.duration,
    this.delay,
    this.itemCount,
    this.crossAxisAlignment,
    this.mainAxisSize,
  })  : assert(itemBuilder != null),
        _animationController = animationController,
        super(key: key);

  final AnimationController _animationController;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Duration duration;
  final Duration delay;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final int itemCount;

  @override
  _StaggeredAnimatedListBuilderState createState() => _StaggeredAnimatedListBuilderState();
}

class _StaggeredAnimatedListBuilderState extends State<StaggeredAnimatedListBuilder> with TickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    _animationController = widget._animationController ??
        AnimationController(vsync: this, duration: widget.duration ?? Duration(milliseconds: widget.itemCount * 300));
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
          return ListView.builder(
            itemCount: widget.itemCount,
            itemBuilder: (BuildContext context, int index) {
              return FadeTransition(
                opacity: Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(
                  CurvedAnimation(
                    curve: Interval(
                      1 / widget.itemCount * index * 0.1,
                      1 / widget.itemCount * index,
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
                          1 / widget.itemCount * index * 0.1,
                          1 / widget.itemCount * index,
                          curve: Curves.ease,
                        ),
                        parent: _animationController,
                      ),
                    ),
                    child: widget.itemBuilder(context, index)),
              );
            },
          );
        },
      ),
    );
  }
}
