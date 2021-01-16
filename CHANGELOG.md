## [0.2.6+9]
- Added `removeRoundedCapExtraAngle` to `CircularStepProgressIndicator` to remove extra angle caused by `StrokeCap.butt` when `roundedCap` is applied ([#20](https://github.com/SandroMaglione/step-progress-indicator/issues/20#issue-786114745))
- Added the option to specify alignment for `StepProgressIndicator` (Thanks to [@faridg18](https://github.com/faridg18) for his contribution ([#15](https://github.com/SandroMaglione/step-progress-indicator/pull/15)))
- Added `blendMode` for gradient of `StepProgressIndicator` ([#16](https://github.com/SandroMaglione/step-progress-indicator/issues/16))

## [0.2.5+8] - 01 December 2020
- Fixed issue when adding `roundedEdges` with only one step ([#12](https://github.com/SandroMaglione/step-progress-indicator/issues/12))
- Added more widget tests

## [0.2.4+7] - 25 August 2020
- Added `roundedCap` property to `CircularStepProgressIndicator` ([#7](https://github.com/SandroMaglione/step-progress-indicator/issues/7))
- Added `gradientColor` property to `CircularStepProgressIndicator`, and `gradientColor`, `selectedGradientColor` and `unselectedGradientColor` to `StepProgressIndicator` ([#8](https://github.com/SandroMaglione/step-progress-indicator/issues/8))
- Fixed `customStepSize` when `circularDirection` is `CircularDirection.counterclockwise`: now the step indexes start at 0 from the left to the right as expected
- Added `isSelected` bool parameter to `customStepSize`, used to change the step size based on the selected/unselected status of the current step (**breaking change**)
- Updated and expanded documentation examples
- Fixed documentations updates

## [0.2.3+6] - 20 May 2020
- Added `arcSize` property to `CircularStepProgressIndicator` that allows you to draw semi-circle indicators ([#3](https://github.com/SandroMaglione/step-progress-indicator/issues/3))
- Adjusted default `startingAngle` to 0 instead of `-math.pi / 2` (**breaking change**)
- Fixed imports and small issues

## [0.2.2+5] - 26 April 2020
- Added material ripple effect on step tap (Thanks to [@rodineijf](https://github.com/rodineijf) for his contribution ([#1](https://github.com/SandroMaglione/step-progress-indicator/pull/1)))
- Implemented `roundedEdges` property to add rounded edge corners to first and last step of the indicator ([#2](https://github.com/SandroMaglione/step-progress-indicator/issues/2))
- Updated and improved documentation and [examples](https://github.com/SandroMaglione/step-progress-indicator/tree/master/example)

## [0.2.1+4] - 25 Febraury 2020
- Updated LICENSE, from GPL3 to MIT

## [0.2.0+3] - 24 Febraury 2020
- Added **CircularStepProgressIndicator**
- Added optimized support for **Continuous Progress Indicators** (by setting `padding` to 0 and not using custom attributes)
- Added more attributes
  * `customSize`
  * `selectedSize`
  * `unselectedSize`
  * `fallbackLength`
- Made indicator custom attributes (`customStep`, `customColor`, `onTap`, `customSize`) zero-based (**breaking change**)
- Added more [examples](https://github.com/SandroMaglione/step-progress-indicator/tree/master/example)
- Updated the documentation with more screens and detailed examples
- Added CircularStepProgressIndicator [animation example](https://github.com/SandroMaglione/step-progress-indicator/blob/master/example/circular_animation1.dart)
- Bug fixing

## [0.1.1+2] - 24 January 2020
- Completed documentation
- [New tutorial article](https://www.sandromaglione.com/blog/2020/01/24/step-progress-indicator-flutter-package-tutorial/)

## [0.1.0+1] - 23 January 2020
Initial release
