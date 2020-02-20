library step_progress_indicator;

import 'package:flutter/material.dart';

// TODO: Handle size limit of the step when too many step, bind together multiple steps with similar colors

/// (Linear) Progress indicator made of a series of steps
///
/// Developed and published by Sandro Maglione
/// https://www.sandromaglione.com
///
/// Check out the official tutorial on
/// https://www.sandromaglione.com/blog
class StepProgressIndicator extends StatelessWidget {
  /// Defines a custom [Widget] to display at each step instead of a simple container,
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

  /// Defines if indicator is
  /// horizontal [Axis.horizontal] or
  /// vertical [Axis.vertical]
  ///
  /// Default value: [Axis.horizontal]
  final Axis direction;

  /// Defines if steps grow from
  /// left-to-right / top-to-bottom [TextDirection.ltr] or
  /// right-to-left / bottom-to-top [TextDirection.rtl]
  ///
  /// Default value: [TextDirection.ltr]
  final TextDirection progressDirection;

  /// Defines onTap function given index of the pressed step.
  ///
  /// Returns the function to execute when the step with given index is pressed.
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
  ///
  /// Default value: 0
  final int currentStep;

  /// Total number of step of the complete indicator
  final int totalSteps;

  /// Spacing between each step
  ///
  /// Default value: 2.0
  final double padding;

  /// Height of the indicator
  ///
  /// Only used when [direction] is [Axis.horizontal]
  ///
  /// Default value: 4.0
  final double height;

  /// Width of the indicator
  ///
  /// Only used when [direction] is [Axis.vertical]
  ///
  /// Default value: 4.0
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

  StepProgressIndicator({
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
    return AnimatedContainer(
      width: direction == Axis.horizontal ? double.infinity : width,
      height: direction == Axis.vertical ? double.infinity : height,
      duration: const Duration(
        milliseconds: 300,
      ),
      child: LayoutBuilder(
        builder: (ctx, constraits) {
          if (direction == Axis.horizontal) {
            // If horizontal indicator, then use a Row
            return Row(
              children: _buildSteps(
                width: (constraits.maxWidth - (padding * totalSteps * 2)) /
                    totalSteps,
              ),
            );
          } else {
            // If vertical indicator, then use a Column
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
  /// given current [step] index (zero-based)
  Color _chooseStepColor(int step) {
    // Assign customColor if not null
    if (customColor != null) {
      return customColor(step);
    }

    // Selected or Unselected color based on the progressDirection
    if (progressDirection == TextDirection.ltr
        ? step > currentStep
        : step < totalSteps - currentStep) {
      return unselectedColor;
    } else {
      return selectedColor;
    }
  }

  /// Build the list of [_ProgressStep],
  /// based on number of [totalSteps]
  List<Widget> _buildSteps({double width, double height}) {
    List<Widget> stepList = [];
    final isLtr = progressDirection == TextDirection.ltr;

    // From 0 to totalStep if TextDirection.ltr, from (totalSteps - 1) to 0 otherwise
    int step = isLtr ? 0 : totalSteps;

    for (; isLtr ? step < totalSteps : step >= 0; isLtr ? ++step : --step) {
      final Color stepColor = _chooseStepColor(
        isLtr ? step : totalSteps - step,
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

/// Single step of the indicator
class _ProgressStep extends StatelessWidget {
  final Axis direction;
  final double width;
  final double height;
  final Color color;
  final double padding;
  final Widget customStep;
  final void Function() onTap;

  const _ProgressStep({
    @required this.direction,
    @required this.color,
    @required this.padding,
    @required this.width,
    @required this.height,
    this.customStep,
    this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Assign given padding
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: direction == Axis.horizontal ? padding : 0.0,
        vertical: direction == Axis.vertical ? padding : 0.0,
      ),
      child: GestureDetector(
        onTap: onTap,
        // AnimatedContainer (simple rectangle) when no customStep defined
        // SizedBox containing the customStep otherwise
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
