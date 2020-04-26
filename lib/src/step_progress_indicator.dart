library step_progress_indicator;

import 'dart:math';

import 'package:flutter/material.dart';

/// (Linear) Progress indicator made of a series of steps
///
/// Developed and published by Sandro Maglione
/// https://www.sandromaglione.com
///
/// Check out the official tutorial on
/// https://www.sandromaglione.com/blog
class StepProgressIndicator extends StatelessWidget {
  /// Defines a custom [Widget] to display at each step instead of a simple container,
  /// given the current step index, the [Color] of the step, which
  /// could be defined with [selectedColor] and [unselectedColor] or
  /// using [customColor], and its size [double], which could be defined
  /// using [size], [selectedSize], [unselectedSize], or [customSize].
  /// When [progressDirection] is [TextDirection.rtl], the index
  /// count starts from the last step i.e. the right-most step in the indicator has index 0
  ///
  /// ```dart
  /// customStep: (index, color, size) {
  ///   return Container(
  ///     color: color,
  ///     child: Text('$index $size'),
  ///   );
  /// }
  /// ```
  ///
  /// If you are not interested in the color and the size:
  /// ```dart
  /// customStep: (index, _, __) {
  ///   return Text('$index');
  /// }
  /// ```
  final Widget Function(int, Color, double) customStep;

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

  /// Height (when [direction] is [Axis.horizontal]) or
  /// width (when [direction] is [Axis.vertical]) of a single indicator step
  ///
  /// Overrided by selectedSize and unselected size when those values are applicable
  /// i.e. when not custom setting (customColor, customStep, customSize, onTap) is defined
  ///
  /// Default value: 4.0
  final double size;

  /// Specify a custom size for selected steps
  ///
  /// Only applicable when not custom setting (customColor, customStep, customSize, onTap) is defined
  ///
  /// This value will replace the [size] only for selected steps
  final double selectedSize;

  /// Specify a custom size for unselected steps
  ///
  /// Only applicable when not custom setting (customColor, customStep, customSize, onTap) is defined
  ///
  /// This value will replace the [size] only for unselected steps
  final double unselectedSize;

  /// Assign a custom size [double] for each step
  ///
  /// Function takes a [int], index of the current step starting from 0, and
  /// must return a [double] size of the step
  ///
  /// If provided, it overrides
  /// [size], [selectedSize], and [unselectedSize]
  final double Function(int) customSize;

  /// Assign a custom [Color] for each step
  ///
  /// Function takes a [int], index of the current step starting from 0, and
  /// must return a [Color]
  ///
  /// If provided, it overrides
  /// [selectedColor] and [unselectedColor]
  /// ```
  /// customColor: (index) => index == 0 ? Colors.red : Colors.blue,
  /// ```
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

  /// Length of the progress indicator in case the main axis
  /// (based on [direction] attribute) has no size limit i.e. [double.infinity]
  ///
  /// Default value: 100.0
  final double fallbackLength;

  /// Added rounded corners to the first and last step of the indicator
  final Radius roundedEdges;

  StepProgressIndicator({
    @required this.totalSteps,
    this.customStep,
    this.onTap,
    this.customColor,
    this.customSize,
    this.selectedSize,
    this.unselectedSize,
    this.roundedEdges,
    this.direction = Axis.horizontal,
    this.progressDirection = TextDirection.ltr,
    this.size = 4.0,
    this.currentStep = 0,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
    this.padding = 2.0,
    this.fallbackLength = 100.0,
    Key key,
  })  : assert(totalSteps > 0,
            "Number of total steps (totalSteps) of the StepProgressIndicator must be greater than 0"),
        assert(currentStep >= 0,
            "Current step (currentStep) of the StepProgressIndicator must be greater than or equal to 0"),
        assert(padding >= 0.0,
            "Padding (padding) of the StepProgressIndicator must be greater or equal to 0"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraits) => SizedBox(
        width: _sizeOrMaxLength(
          direction == Axis.horizontal,
          constraits.maxWidth,
        ),
        height: _sizeOrMaxLength(
          direction == Axis.vertical,
          constraits.maxHeight,
        ),
        child: LayoutBuilder(
          builder: (ctx, constraits) {
            if (direction == Axis.horizontal) {
              // If horizontal indicator, then use a Row
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: !_isOptimizable
                    ? _buildSteps(
                        // Use fallbackLength when no constraint exists
                        _stepHeightOrWidthValue(
                          constraits.maxWidth,
                        ),
                      )
                    : _buildOptimizedSteps(
                        _maxHeightOrWidthValue(
                          constraits.maxWidth,
                        ),
                      ),
              );
            } else {
              // If vertical indicator, then use a Column
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // Use fallbackLength when no constraint exists
                children: !_isOptimizable
                    ? _buildSteps(
                        _stepHeightOrWidthValue(
                          constraits.maxHeight,
                        ),
                      )
                    : _buildOptimizedSteps(
                        _maxHeightOrWidthValue(
                          constraits.maxHeight,
                        ),
                      ),
              );
            }
          },
        ),
      ),
    );
  }

  /// Compute the maximum possible size of the indicator between
  /// [size], [selectedSize], [unselectedSize], and [customSize]
  double get maxDefinedSize {
    // If customSize not defined, use size, selectedSize, unselectedSize
    if (customSize == null) {
      return max(size, max(selectedSize ?? 0, unselectedSize ?? 0));
    }

    // When customSize defined, compute max possible size
    double currentMaxSize = 0;

    for (int step = 0; step < totalSteps; ++step) {
      final customSizeValue = customSize(step);
      if (customSizeValue > currentMaxSize) {
        currentMaxSize = customSizeValue;
      }
    }

    return currentMaxSize;
  }

  /// As much space as possible when size not unbounded, otherwise use fallbackLength.
  /// If indicator is in the opposite direction, then use size
  double _sizeOrMaxLength(bool isCorrectDirection, double maxLength) =>
      isCorrectDirection
          // If space is not unbounded, then fill it with the indicator
          ? maxLength != double.infinity ? double.infinity : fallbackLength
          : maxDefinedSize;

  /// Draw just two containers in case no specific step setting is required
  /// i.e. it becomes a linear progress indicator with two steps: selected and unselected
  bool get _isOptimizable =>
      padding == 0 &&
      customColor == null &&
      customStep == null &&
      customSize == null &&
      onTap == null;

  /// Compute single step length, based on total length available
  double _stepHeightOrWidthValue(double maxSize) =>
      (_maxHeightOrWidthValue(maxSize) - (padding * 2 * totalSteps)) /
      totalSteps;

  /// Total length (horizontal or vertical) available for the indicator
  double _maxHeightOrWidthValue(double maxSize) =>
      maxSize != double.infinity ? maxSize : fallbackLength;

  /// Choose what [Color] to assign
  /// given current [step] index (zero-based)
  Color _chooseStepColor(int step, int stepIndex) {
    // Assign customColor if not null
    if (customColor != null) {
      return customColor(stepIndex);
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

  /// true if color of the step given index is [selectedColor]
  bool _isSelectedColor(int step) =>
      customColor == null &&
      !(progressDirection == TextDirection.ltr
          ? step > currentStep
          : step < totalSteps - currentStep);

  /// Build only two steps when the condition of [_isOptimizable] is verified
  List<Widget> _buildOptimizedSteps(double indicatorLength) {
    List<Widget> stepList = [];
    final isLtr = progressDirection == TextDirection.ltr;
    final isHorizontal = direction == Axis.horizontal;

    final firstStepLength = indicatorLength * (currentStep / totalSteps);
    final secondStepLength = indicatorLength - firstStepLength;

    // Add first step
    stepList.add(
      _ProgressStep(
        direction: direction,
        padding: padding,
        color: isLtr ? selectedColor : unselectedColor,
        width: isHorizontal
            ? isLtr ? firstStepLength : secondStepLength
            : isLtr ? selectedSize ?? size : unselectedSize ?? size,
        height: !isHorizontal
            ? isLtr ? firstStepLength : secondStepLength
            : isLtr ? selectedSize ?? size : unselectedSize ?? size,
        roundedEdges: roundedEdges,
        isFirstStep: true,
      ),
    );

    // Add second step
    stepList.add(
      _ProgressStep(
        direction: direction,
        padding: padding,
        color: !isLtr ? selectedColor : unselectedColor,
        width: isHorizontal
            ? isLtr ? secondStepLength : firstStepLength
            : !isLtr ? selectedSize ?? size : unselectedSize ?? size,
        height: !isHorizontal
            ? isLtr ? secondStepLength : firstStepLength
            : !isLtr ? selectedSize ?? size : unselectedSize ?? size,
        roundedEdges: roundedEdges,
        isLastStep: true,
      ),
    );

    return stepList;
  }

  /// Build the list of [_ProgressStep],
  /// based on number of [totalSteps]
  List<Widget> _buildSteps(double stepLength) {
    List<Widget> stepList = [];
    final isLtr = progressDirection == TextDirection.ltr;
    final isHorizontal = direction == Axis.horizontal;

    // From 0 to totalStep if TextDirection.ltr, from (totalSteps - 1) to 0 otherwise
    int step = isLtr ? 0 : totalSteps - 1;

    // Add steps to the list, based on the progressDirection attribute
    for (; isLtr ? step < totalSteps : step >= 0; isLtr ? ++step : --step) {
      // currentStep = 6, then 6 selected and 4 not selected
      final loopStep = isLtr ? step + 1 : totalSteps - step - 1;

      // customColor if not null, otherwise selected or unselected color
      final stepColor = _chooseStepColor(loopStep, step);

      // If defined and applicable, apply customSize or
      // different sizes for selected and unselected
      final stepSize = customSize != null
          ? customSize(step)
          : _isSelectedColor(loopStep)
              ? selectedSize ?? size
              : unselectedSize ?? size;

      stepList.add(
        _ProgressStep(
          direction: direction,
          padding: padding,
          color: stepColor,
          width: isHorizontal ? stepLength : stepSize,
          height: !isHorizontal ? stepLength : stepSize,
          customStep:
              customStep != null ? customStep(step, stepColor, stepSize) : null,
          onTap: onTap != null ? onTap(step) : null,
          isFirstStep: step == 0,
          isLastStep: step == totalSteps - 1,
          roundedEdges: roundedEdges,
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
  final bool isFirstStep;
  final bool isLastStep;
  final Radius roundedEdges;

  const _ProgressStep({
    @required this.direction,
    @required this.color,
    @required this.padding,
    @required this.width,
    @required this.height,
    this.customStep,
    this.onTap,
    this.isFirstStep = false,
    this.isLastStep = false,
    this.roundedEdges,
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
      // If first or last step and rounded edges enabled, apply
      // rounded edges using ClipRRect
      // Different corners based on first/last step and indicator's direction
      // - First step + horizontal: top-left, bottom-left
      // - First step + vertical: top-left, top-right
      // - Last step + horizontal: top-right, bottom-right
      // - Last step + vertical: bottom-left, bottom-right
      child: (isFirstStep || isLastStep) && roundedEdges != null
          ? ClipRRect(
              borderRadius: isFirstStep
                  ? direction == Axis.horizontal
                      ? BorderRadius.only(
                          topLeft: roundedEdges,
                          bottomLeft: roundedEdges,
                        )
                      : BorderRadius.only(
                          topLeft: roundedEdges,
                          topRight: roundedEdges,
                        )
                  : isLastStep
                      ? direction == Axis.horizontal
                          ? BorderRadius.only(
                              topRight: roundedEdges,
                              bottomRight: roundedEdges,
                            )
                          : BorderRadius.only(
                              bottomLeft: roundedEdges,
                              bottomRight: roundedEdges,
                            )
                      : BorderRadius.zero,
              child: _buildStep,
            )
          : _buildStep,
    );
  }

  /// Build the actual single step [Widget]
  Widget get _buildStep => onTap != null && customStep != null
      ? Material(
          color: color,
          child: InkWell(
            onTap: onTap,
            // Container (simple rectangle) when no customStep defined
            // SizedBox containing the customStep otherwise
            child: _stepContainer(),
          ),
        )
      : onTap == null && customStep != null
          ? SizedBox(
              width: width,
              height: height,
              child: GestureDetector(
                onTap: onTap,
                child: customStep,
              ),
            )
          : _buildStepContainer;

  /// Build [_stepContainer] based on input parameters:
  /// - [Container] with background color when [customStep] is not defined
  /// - [SizedBox] with [customStep] when defined
  Widget get _buildStepContainer => customStep == null
      ? _stepContainer(color)
      : SizedBox(
          width: width,
          height: height,
          child: customStep,
        );

  /// Single step [Container]
  Widget _stepContainer([Color color]) => Container(
        width: width,
        height: height,
        color: color,
      );
}
