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

  /// Height of the indicator's box container
  final double height;

  /// Width of the indicator's box container
  final double width;

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

  /// Specify a custom size for selected steps
  ///
  /// Only applicable when not custom setting (customColor, customStepSize) is defined
  ///
  /// This value will replace the [stepSize] only for selected steps
  final double selectedStepSize;

  /// Specify a custom size for unselected steps
  ///
  /// Only applicable when not custom setting (customColor, customStepSize) is defined
  ///
  /// This value will replace the [stepSize] only for unselected steps
  final double unselectedStepSize;

  /// Assign a custom size [double] for each step
  ///
  /// Function takes a [int], index of the current step starting from 0, and
  /// must return a [double] size of the step
  ///
  /// If provided, it overrides [stepSize]
  final double Function(int) customStepSize;

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

  /// Angle in radiants in which the first step of the indicator is placed.
  /// The initial value is on the top of the indicator (- math.pi / 2)
  /// - 0 => TOP
  /// - math.pi / 2 => LEFT
  /// - math.pi => BOTTOM
  /// - math.pi / 2 * 3 => RIGHT
  /// - math.pi / 2 => TOP (again)
  final double startingAngle;

  /// Angle in radiants which represents the size of the arc used to display the indicator.
  /// It allows you to draw a semi-circle instead of a full 360° (math.pi * 2) circle.
  final double arcSize;

  // TODO: final bool isRadial;

  CircularStepProgressIndicator({
    @required this.totalSteps,
    this.child,
    this.height,
    this.width,
    this.customColor,
    this.customStepSize,
    this.selectedStepSize,
    this.unselectedStepSize,
    this.circularDirection = CircularDirection.clockwise,
    this.fallbackHeight = 100.0,
    this.fallbackWidth = 100.0,
    this.currentStep = 0,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
    this.padding = math.pi / 20,
    this.stepSize = 6.0,
    this.startingAngle = 0,
    this.arcSize = math.pi * 2,
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
    // Print warning when arcSize greater than math.pi * 2 which causes steps to overlap
    if (arcSize > math.pi * 2)
      print(
          "WARNING (step_progress_indicator): arcSize of CircularStepProgressIndicator is greater than 360° (math.pi * 2), this will cause some steps to overlap!");

    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
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
            arcSize: arcSize,
            stepSize: stepSize,
            customStepSize: customStepSize,
            maxDefinedSize: maxDefinedSize,
            selectedStepSize: selectedStepSize,
            unselectedStepSize: unselectedStepSize,
            startingAngle: startingAngleTopOfIndicator,
          ),
          // Padding needed to show the indicator when child is placed on top of it
          child: Padding(
            padding: EdgeInsets.all(maxDefinedSize),
            child: child,
          ),
        ),
      ),
    );
  }

  /// Compute the maximum possible size of the indicator between
  /// [stepSize] and [customStepSize]
  double get maxDefinedSize {
    if (customStepSize == null) {
      return math.max(stepSize, math.max(selectedStepSize ?? 0, unselectedStepSize ?? 0));
    }

    // When customSize defined, compute and return max possible size
    double currentMaxSize = 0;

    for (int step = 0; step < totalSteps; ++step) {
      final customSizeValue = customStepSize(step);
      if (customSizeValue > currentMaxSize) {
        currentMaxSize = customSizeValue;
      }
    }

    return currentMaxSize;
  }

  /// Make [startingAngle] to top-center of indicator (0°) by default
  double get startingAngleTopOfIndicator => startingAngle - math.pi / 2;
}

class _CircularIndicatorPainter implements CustomPainter {
  final int totalSteps;
  final int currentStep;
  final double padding;
  final Color selectedColor;
  final Color unselectedColor;
  final double stepSize;
  final double selectedStepSize;
  final double unselectedStepSize;
  final double Function(int) customStepSize;
  final double maxDefinedSize;
  final Color Function(int) customColor;
  final CircularDirection circularDirection;
  final double startingAngle;
  final double arcSize;

  _CircularIndicatorPainter({
    @required this.totalSteps,
    @required this.circularDirection,
    @required this.customColor,
    @required this.currentStep,
    @required this.selectedColor,
    @required this.unselectedColor,
    @required this.padding,
    @required this.stepSize,
    @required this.selectedStepSize,
    @required this.unselectedStepSize,
    @required this.customStepSize,
    @required this.startingAngle,
    @required this.arcSize,
    @required this.maxDefinedSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Step length is user-defined arcSize
    // divided by the total number of steps (each step same size)
    final stepLength = arcSize / totalSteps;

    // Define general arc paint
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = maxDefinedSize;

    final rect = Rect.fromCenter(
      // Rect created from the center of the widget
      center: Offset(w / 2, h / 2),
      // For both height and width, subtract maxDefinedSize to fit indicator inside the parent container
      height: h - maxDefinedSize,
      width: w - maxDefinedSize,
    );

    // Change color selected or unselected based on the circularDirection
    final isClockwise = circularDirection == CircularDirection.clockwise;

    // Make a continuous arc without rendering all the steps when possible
    if (padding == 0 && customColor == null && customStepSize == null) {
      _drawContinuousArc(canvas, paint, rect, isClockwise);
    } else {
      _drawStepArc(canvas, paint, rect, isClockwise, stepLength);
    }
  }

  /// Draw a series of arcs, each composing the full steps of the indicator
  void _drawStepArc(Canvas canvas, Paint paint, Rect rect, bool isClockwise,
      double stepLength) {
    // Draw a series of circular arcs to compose the indicator
    // Starting based on startingAngle attribute
    for (var stepAngle = startingAngle, step = 0;
        step < totalSteps;
        stepAngle += stepLength, ++step) {
      final isSelectedColor = _isSelectedColor(step, isClockwise);

      // Size of the step
      final indexStepSize = customStepSize != null
          ? customStepSize(isClockwise ? step : totalSteps - step - 1)
          : isSelectedColor
              ? selectedStepSize ?? stepSize
              : unselectedStepSize ?? stepSize;

      // Use customColor if defined
      final stepColor = customColor != null
          ? customColor(step)
          : isSelectedColor ? selectedColor : unselectedColor;

      // Draw arc steps of the indicator
      canvas.drawArc(
        rect,
        stepAngle,
        stepLength - padding,
        false /*isRadial*/,
        paint
          ..color = stepColor
          ..strokeWidth = indexStepSize,
      );
    }
  }

  /// Draw optimized continuous indicator instead of multiple steps
  void _drawContinuousArc(
      Canvas canvas, Paint paint, Rect rect, bool isClockwise) {
    // Compute color of the selected and unselected bars
    final firstStepColor = isClockwise ? selectedColor : unselectedColor;
    final secondStepColor = !isClockwise ? selectedColor : unselectedColor;

    // Selected and unselected step sizes if defined, otherwise use stepSize
    final firstStepSize = isClockwise
        ? selectedStepSize ?? stepSize
        : unselectedStepSize ?? stepSize;
    final secondStepSize = !isClockwise
        ? selectedStepSize ?? stepSize
        : unselectedStepSize ?? stepSize;

    // Compute length and starting angle of the selected and unselected bars
    final firstArcLength = arcSize * (currentStep / totalSteps);
    final secondArcLength = arcSize - firstArcLength;

    // firstArcStartingAngle = startingAngle
    final secondArcStartingAngle = startingAngle + firstArcLength;

    // First arc, selected when clockwise, unselected otherwise
    canvas.drawArc(
      rect,
      startingAngle,
      firstArcLength,
      false /*isRadial*/,
      paint
        ..color = firstStepColor
        ..strokeWidth = firstStepSize,
    );

    // Second arc, selected when counterclockwise, unselected otherwise
    canvas.drawArc(
      rect,
      secondArcStartingAngle,
      secondArcLength,
      false /*isRadial*/,
      paint
        ..color = secondStepColor
        ..strokeWidth = secondStepSize,
    );
  }

  bool _isSelectedColor(int step, bool isClockwise) => isClockwise
      ? (step + 1) <= currentStep
      : (step + 1) > (totalSteps - currentStep);

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

/// Used to define the [circularDirection] attribute of the [CircularStepProgressIndicator]
enum CircularDirection {
  clockwise,
  counterclockwise,
}
