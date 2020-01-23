library step_progress_indicator;

import 'package:flutter/material.dart';

/// Progress indicator that contains a series of steps
///
/// Developed and published by Sandro Maglione
/// https://www.sandromaglione.com
class StepProgressIndicator extends StatelessWidget {
  /// Defines a custom [Widget] to display at each step,
  /// given the current step index and the [Color], which
  /// could be defined with [selectedColor] and [unselectedColor] or
  /// using [customColor]
  ///
  /// ```dart
  /// customStep: (index, color) {
  ///   return Container(
  ///     color: color,
  ///     child: Text('$index'),
  ///   );
  /// }
  /// ```
  ///
  /// If you are not interested in the color:
  /// ```dart
  /// customStep: (index, _) {
  ///   return Text('$index');
  /// }
  /// ```
  final Widget Function(int, Color) customStep;

  /// Defines if indicator is horizontal or vertical
  final Axis direction;

  /// Defines if steps grow from
  /// left-to-right / top-to-bottom [TextDirection.ltr] or
  /// right-to-left / bottom-to-top [TextDirection.rtl]
  final TextDirection progressDirection;

  /// Defines onTap function given index of the pressed step.
  ///
  /// Returns the function to execute when step is pressed.
  ///
  /// For example, if you want to print the index of the pressed step:
  /// ```dart
  /// onTap: (index) => () => print('$index pressed')
  /// ```
  /// or
  /// ```dart
  /// onTap: (index) {
  ///   return () {
  ///     print('$index pressed');
  ///   };
  /// },
  /// ```
  final void Function() Function(int) onTap;

  /// Number of steps to underline, all the steps with
  /// index <= [currentStep] will have [Color] equal to
  /// [selectedColor]
  ///
  /// Only used when [customColor] is [null]
  final int currentStep;

  /// Total number of step of the complete indicator
  final int totalSteps;

  /// Spacing between each step
  final double padding;

  /// Height of the indicator
  ///
  /// Only used when [direction] is [Axis.horizontal]
  final double height;

  /// Width of the indicator
  ///
  /// Only used when [direction] is [Axis.vertical]
  final double width;

  /// Assign a custom [Color] for each step
  ///
  /// Takes a [int], index of the current step, and
  /// must return a [Color]
  ///
  /// If provided, it overrides
  /// [selectedColor] and [unselectedColor]
  final Color Function(int) customColor;

  /// [Color] of the selected steps
  ///
  /// All the steps with index <= [currentStep]
  final Color selectedColor;

  /// [Color] of the unselected steps
  ///
  /// All the steps with index between
  /// [currentStep] and [totalSteps]
  final Color unselectedColor;

  StepProgressIndicator({
    Key key,
    @required this.totalSteps,
    this.customStep,
    this.onTap,
    this.customColor,
    this.direction = Axis.horizontal,
    this.progressDirection = TextDirection.ltr,
    this.height = 4.0,
    this.width = 4.0,
    this.currentStep = 0,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
    this.padding = 2.0,
  })  : assert(totalSteps > 0),
        assert(currentStep >= 0),
        assert(height > 0.0),
        assert(padding >= 0.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: direction == Axis.horizontal ? double.infinity : width,
      height: direction == Axis.horizontal ? height : double.infinity,
      duration: const Duration(
        milliseconds: 300,
      ),
      child: LayoutBuilder(
        builder: (ctx, constraits) {
          if (direction == Axis.horizontal) {
            return Row(
              children: _buildSteps(
                width: (constraits.maxWidth - (padding * totalSteps * 2)) /
                    totalSteps,
              ),
            );
          } else {
            return Column(
              children: _buildSteps(
                height: (constraits.maxHeight - (padding * totalSteps * 2)) /
                    totalSteps,
              ),
            );
          }
        },
      ),
    );
  }

  /// Choose what [Color] to assign
  /// given current [step] index
  Color _chooseStepColor(int step) {
    if (customColor != null) {
      return customColor(step);
    }

    if (progressDirection == TextDirection.ltr
        ? step > currentStep
        : step < totalSteps - currentStep) {
      return unselectedColor;
    } else {
      return selectedColor;
    }
  }

  /// Build the list of [_ProgressStep],
  /// based on [totalSteps] and
  List<Widget> _buildSteps({double width, double height}) {
    List<Widget> stepList = [];
    int step = progressDirection == TextDirection.ltr ? 1 : totalSteps;

    for (;
        progressDirection == TextDirection.ltr ? step <= totalSteps : step > 0;
        progressDirection == TextDirection.ltr ? ++step : --step) {
      final Color stepColor = _chooseStepColor(
        progressDirection == TextDirection.ltr ? step : totalSteps - step,
      );
      stepList.add(
        _ProgressStep(
          direction: direction,
          width: width,
          height: height,
          padding: padding,
          customStep: customStep != null ? customStep(step, stepColor) : null,
          onTap: onTap != null ? onTap(step) : null,
          color: stepColor,
        ),
      );
    }

    return stepList;
  }
}

class _ProgressStep extends StatelessWidget {
  final Axis direction;
  final double width;
  final double height;
  final Color color;
  final double padding;
  final Widget customStep;
  final void Function() onTap;

  const _ProgressStep({
    Key key,
    @required this.direction,
    @required this.color,
    @required this.padding,
    @required this.width,
    @required this.height,
    this.customStep,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: direction == Axis.horizontal ? padding : 0.0,
        vertical: direction == Axis.vertical ? padding : 0.0,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: customStep == null
            ? AnimatedContainer(
                width: direction == Axis.horizontal ? width : null,
                height: direction == Axis.vertical ? height : null,
                color: color,
                duration: const Duration(
                  milliseconds: 300,
                ),
              )
            : SizedBox(
                width: direction == Axis.horizontal ? width : null,
                height: direction == Axis.vertical ? height : null,
                child: customStep,
              ),
      ),
    );
  }
}
