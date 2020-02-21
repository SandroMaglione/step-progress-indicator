library circular_step_progress_indicator;

import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Circular Progress indicator made of a series of steps.
/// It can contain a child [Widget] inside.
///
/// Developed and published by Sandro Maglione
/// https://www.sandromaglione.com
///
/// Check out the official tutorial on
/// https://www.sandromaglione.com/blog
class CircularStepProgressIndicator extends StatelessWidget {
  /// Defines if steps grow from
  /// clockwise [CircularDirection.clockwise] or
  /// counterclockwise [CircularDirection.counterclockwise]
  final CircularDirection circularDirection;

  /// Number of steps to underline, all the steps with
  /// index <= [currentStep] will have [Color] equal to
  /// [selectedColor]
  ///
  /// Only used when [customColor] is [null]
  ///
  /// Default value: 0
  final int currentStep;

  /// Total number of step of the complete indicator
  final int totalSteps;

  /// Radial spacing between each step. Remember to
  /// define the value in radiant units
  ///
  /// Default value: math.pi / 20
  final double padding;

  /// Height of the indicator box container
  final double height;

  /// Width of the indicator box container
  final double width;

  // Style
  /// Assign a custom [Color] for each step
  ///
  /// Takes a [int], index of the current step starting from 0, and
  /// must return a [Color]
  ///
  /// If provided, it overrides
  /// [selectedColor] and [unselectedColor]
  final Color Function(int) customColor;

  /// [Color] of the selected steps
  ///
  /// All the steps with index <= [currentStep]
  ///
  /// Default value: [Colors.blue]
  final Color selectedColor;

  /// [Color] of the unselected steps
  ///
  /// All the steps with index between
  /// [currentStep] and [totalSteps]
  ///
  /// Default value: [Colors.grey]
  final Color unselectedColor;

  /// The size of a single step in the indicator
  ///
  /// Default value: 6.0
  final double stepSize;

  /// [Widget] contained inside the circular indicator
  final Widget child;

  /// Height of the indicator container in case no [height] parameter
  /// given and parent height is [double.infinity]
  ///
  /// Default value: 100.0
  final double fallbackHeight;

  /// Height of the indicator container in case no [width] parameter
  /// given and parent height is [double.infinity]
  ///
  /// Default value: 100.0
  final double fallbackWidth;

  // TODO: final bool isRadial;

  CircularStepProgressIndicator({
    @required this.totalSteps,
    this.child,
    this.circularDirection = CircularDirection.clockwise,
    this.height,
    this.width,
    this.customColor,
    this.fallbackHeight = 100.0,
    this.fallbackWidth = 100.0,
    this.currentStep = 0,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
    this.padding = math.pi / 20,
    this.stepSize = 6.0,
    Key key,
  })  : assert(totalSteps > 0,
            "Number of total steps (totalSteps) of the CircularStepProgressIndicator must be greater than 0"),
        assert(currentStep >= 0,
            "Current step (currentStep) of the CircularStepProgressIndicator must be greater than or equal to 0"),
        assert(padding >= 0.0,
            "Padding (padding) of the CircularStepProgressIndicator must be greater or equal to 0"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        // Apply fallback for both height and width
        // if their value is null and no parent size limit
        height: height != null
            ? height
            : constraints.maxHeight != double.infinity
                ? constraints.maxHeight
                : fallbackHeight,
        width: width != null
            ? width
            : constraints.maxWidth != double.infinity
                ? constraints.maxWidth
                : fallbackWidth,
        child: CustomPaint(
          painter: _CircularIndicatorPainter(
            totalSteps: totalSteps,
            currentStep: currentStep,
            customColor: customColor,
            padding: padding,
            circularDirection: circularDirection,
            selectedColor: selectedColor,
            unselectedColor: unselectedColor,
            stepSize: stepSize,
          ),
          // Padding needed to show the indicator when child is placed on top of it
          child: Padding(
            padding: EdgeInsets.all(stepSize),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _CircularIndicatorPainter implements CustomPainter {
  final int totalSteps;
  final int currentStep;
  final double padding;
  final Color selectedColor;
  final Color unselectedColor;
  final double stepSize;
  final Color Function(int) customColor;
  final CircularDirection circularDirection;

  _CircularIndicatorPainter({
    @required this.totalSteps,
    @required this.circularDirection,
    @required this.customColor,
    @required this.currentStep,
    @required this.selectedColor,
    @required this.unselectedColor,
    @required this.padding,
    @required this.stepSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    /* Step length is the full circle length (2 * math.pi)
    divided by the total number of steps (each step same size) */
    final stepLength = (2 * math.pi) / totalSteps;

    // Define general arc paint
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stepSize;

    final rect = Rect.fromCenter(
      // Rect created from the center of the widget
      center: Offset(w / 2, h / 2),
      // For both height and width, subtract stepSize to fit indicator inside the parent container
      height: h - stepSize,
      width: w - stepSize,
    );

    // Change color selected or unselected based on the circularDirection
    final isClockwise = circularDirection == CircularDirection.clockwise;

    // Draw a series of circular arcs to compose the indicator
    for (var stepAngle = -math.pi / 2, step = 0;
        step < totalSteps;
        stepAngle += stepLength, ++step) {
      // Use customColor if defined
      final stepColor = customColor != null
          ? customColor(step)
          : isClockwise
              ? (step + 1) <= currentStep ? selectedColor : unselectedColor
              : (step + 1) <= (totalSteps - currentStep)
                  ? unselectedColor
                  : selectedColor;

      // Draw arc steps of the indicator
      canvas.drawArc(
        rect,
        stepAngle,
        // Draw arc in the opposite direction whencounterclockwise
        stepLength - padding,
        false /*isRadial*/,
        paint..color = stepColor,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;

  @override
  bool hitTest(Offset position) => false;

  @override
  void addListener(listener) {}

  @override
  void removeListener(listener) {}

  @override
  get semanticsBuilder => null;

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) => false;
}

enum CircularDirection {
  clockwise,
  counterclockwise,
}
