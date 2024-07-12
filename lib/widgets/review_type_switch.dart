import 'dart:ui';

import 'package:dears/models/review_type.dart';
import 'package:flutter/material.dart';

const double _trackWidth = 150;
const double _trackHeight = 36;
const double _trackRadius = _trackHeight / 2;

const double _thumbWidth = 72;
const double _thumbHeight = 32;
const double _thumbRadius = _thumbHeight / 2;
const double _thumbExtension = 4;

const double _trackPadding = _trackRadius - _thumbRadius;
const double _trackInnerWidth = _trackWidth - 2 * _trackPadding;
const double _trackAvailableLength =
    _trackInnerWidth - (_thumbWidth + _thumbExtension);

const Duration _toggleDuration = Duration(milliseconds: 200);
const Duration _reactionDuration = Duration(milliseconds: 300);

class ReviewTypeSwitch extends StatefulWidget {
  final ReviewType value;
  final ValueChanged<ReviewType> onChanged;

  const ReviewTypeSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<ReviewTypeSwitch> createState() => _ReviewTypeSwitchState();
}

class _ReviewTypeSwitchState extends State<ReviewTypeSwitch>
    with TickerProviderStateMixin {
  late final AnimationController positionController;
  late final CurvedAnimation position;

  late final AnimationController reactionController;
  late final CurvedAnimation reaction;

  // A non-null boolean value that changes to true at the end of a drag if the
  // switch must be animated to the position indicated by the widget's value.
  bool needsPositionAnimation = false;

  @override
  void initState() {
    super.initState();

    positionController = AnimationController(
      vsync: this,
      duration: _toggleDuration,
    );
    position = CurvedAnimation(
      parent: positionController,
      curve: Curves.linear,
    );

    reactionController = AnimationController(
      vsync: this,
      duration: _reactionDuration,
    );
    reaction = CurvedAnimation(
      parent: reactionController,
      curve: Curves.ease,
    );
  }

  @override
  void didUpdateWidget(ReviewTypeSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (needsPositionAnimation || widget.value != oldWidget.value) {
      resumePositionAnimation(isLinear: needsPositionAnimation);
    }
  }

  @override
  void dispose() {
    positionController.dispose();
    reactionController.dispose();

    super.dispose();
  }

  // `isLinear` must be true if the position animation is trying to move the
  // thumb to the closest end after the most recent drag animation, so the curve
  // does not change when the controller's value is not 0 or 1.
  //
  // It can be set to false when it's an implicit animation triggered by
  // widget.value changes.
  void resumePositionAnimation({bool isLinear = true}) {
    needsPositionAnimation = false;
    position
      ..curve = isLinear ? Curves.linear : Curves.ease
      ..reverseCurve = isLinear ? Curves.linear : Curves.ease.flipped;
    switch (widget.value) {
      case ReviewType.consulting:
        positionController.reverse();
      case ReviewType.matching:
        positionController.forward();
    }
  }

  void onTapDown(TapDownDetails details) {
    needsPositionAnimation = false;
    reactionController.forward();
  }

  void onTapUp(TapUpDetails details) {
    needsPositionAnimation = false;
    reactionController.reverse();
  }

  void onTap() {
    widget.onChanged(widget.value.inversed);
  }

  void onTapCancel() {
    reactionController.reverse();
  }

  void onHorizontalDragStart(DragStartDetails details) {
    needsPositionAnimation = false;
    reactionController.forward();
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    position
      ..curve = Curves.linear
      ..reverseCurve = Curves.linear;

    final primaryDelta = details.primaryDelta;
    if (primaryDelta == null) {
      return;
    }
    positionController.value += primaryDelta / _trackAvailableLength;
  }

  void onHorizontalDragEnd(DragEndDetails details) {
    // Deferring the animation to the next build phase.
    setState(() {
      needsPositionAnimation = true;
    });

    // Call onChanged when the user's intent to change value is clear.
    if (position.value >= 0.5 != (widget.value == ReviewType.values.last)) {
      widget.onChanged(widget.value.inversed);
    }

    reactionController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    if (needsPositionAnimation) {
      resumePositionAnimation();
    }

    return GestureDetector(
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTap: onTap,
      onTapCancel: onTapCancel,
      onHorizontalDragStart: onHorizontalDragStart,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd,
      child: Container(
        padding: const EdgeInsets.all(_trackPadding),
        width: _trackWidth,
        height: _trackHeight,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(235, 236, 237, 1),
          borderRadius: BorderRadius.circular(_trackRadius),
        ),
        child: AnimatedBuilder(
          animation: Listenable.merge([position, reaction]),
          builder: (context, child) {
            final currentThumbExtension = _thumbExtension * reaction.value;
            final currentThumbWidth = _thumbWidth + currentThumbExtension;

            return Stack(
              children: [
                Positioned(
                  left: lerpDouble(
                    0,
                    _trackInnerWidth - currentThumbWidth,
                    position.value,
                  ),
                  child: Container(
                    width: currentThumbWidth,
                    height: _thumbHeight,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(_thumbRadius),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "${ReviewType.consulting}",
                          style: TextStyle(
                            fontWeight: widget.value == ReviewType.consulting
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: Color.lerp(
                              Colors.black,
                              Colors.blue,
                              (1 - position.value) * (1 - reaction.value),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "${ReviewType.matching}",
                          style: TextStyle(
                            fontWeight: widget.value == ReviewType.matching
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: Color.lerp(
                              Colors.black,
                              Colors.blue,
                              position.value * (1 - reaction.value),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
