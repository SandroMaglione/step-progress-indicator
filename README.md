# Step Progress Indicator
<p>
  <img src="https://img.shields.io/badge/version-0.2.0%2B3-blue.svg" />
  <img src="https://img.shields.io/badge/flutter-v1.12.13%2Bhotfix.8-blue.svg" />
  <a href="https://github.com/SandroMaglione">
    <img alt="GitHub: SandroMaglione" src="https://img.shields.io/github/followers/SandroMaglione?label=Follow&style=social" target="_blank" />
  </a>
  <a href="https://twitter.com/SandroMaglione">
    <img alt="Twitter: SandroMaglione" src="https://img.shields.io/twitter/follow/SandroMaglione.svg?style=social" target="_blank" />
  </a>
</p>

Open source Flutter package, bar indicator made of a series of selected and unselected steps.

Made by Sandro Maglione, check out his personal official website [sandromaglione.com](https://www.sandromaglione.com)

**[Check out the full step_progress_indicator tutorial](http://www.sandromaglione.com/blog/2020/01/24/step-progress-indicator-flutter-package-tutorial/)**

See the full example [here](https://github.com/SandroMaglione/step-progress-indicator/tree/master/example)

Check out the official dartdoc for the package [here](https://pub.dev/documentation/step_progress_indicator/latest/step_progress_indicator/StepProgressIndicator-class.html)

## Screenshots
Install and import the package. Then just customize its parameters.

```yaml
dependencies:
  flutter:
    sdk: flutter
  step_progress_indicator: ^0.2.0+3
```
---

Horizontal             |  Vertical
:-------------------------:|:-------------------------:
![Horizontal indicator screen](https://raw.githubusercontent.com/SandroMaglione/step-progress-indicator/master/doc/screenshots/screen1.png)  |  ![Vertical indicator screen](https://raw.githubusercontent.com/SandroMaglione/step-progress-indicator/master/doc/screenshots/screen2.png)

---

## Examples

#### StepProgressIndicator - Example 1
![Step Progress Indicator - Example 1](https://raw.githubusercontent.com/SandroMaglione/step-progress-indicator/master/doc/screenshots/step_progress_indicator/linear_bar_example1.png)

```dart
StepProgressIndicator(
    totalSteps: 10,
)
```

#### StepProgressIndicator - Example 2
![Step Progress Indicator - Example 2](https://raw.githubusercontent.com/SandroMaglione/step-progress-indicator/master/doc/screenshots/step_progress_indicator/linear_bar_example2.png)

```dart
StepProgressIndicator(
    totalSteps: 10,
    currentStep: 6,
    selectedColor: Colors.red,
    unselectedColor: Colors.yellow,
)
```

#### StepProgressIndicator - Example 3
![Step Progress Indicator - Example 3](https://raw.githubusercontent.com/SandroMaglione/step-progress-indicator/master/doc/screenshots/step_progress_indicator/linear_bar_example3.png)

```dart
StepProgressIndicator(
    totalSteps: 20,
    currentStep: 6,
    size: 10,
    selectedColor: Colors.purple,
    unselectedColor: Colors.transparent,
)
```

#### StepProgressIndicator - Example 4
![Step Progress Indicator - Example 4](https://raw.githubusercontent.com/SandroMaglione/step-progress-indicator/master/doc/screenshots/step_progress_indicator/linear_bar_example4.png)

```dart
StepProgressIndicator(
    totalSteps: 100,
    currentStep: 32,
    size: 6,
    padding: 0,
    selectedColor: Colors.yellow,
    unselectedColor: Colors.cyan,
)
```

#### StepProgressIndicator - Example 5
![Step Progress Indicator - Example 5](https://raw.githubusercontent.com/SandroMaglione/step-progress-indicator/master/doc/screenshots/step_progress_indicator/linear_bar_example5.png)

```dart
StepProgressIndicator(
    totalSteps: 12,
    currentStep: 4,
    padding: 6.0,
    size: 12,
    progressDirection: TextDirection.rtl,
    selectedColor: Colors.green,
    unselectedColor: Colors.black12,
)
```

#### StepProgressIndicator - Example 6
![Step Progress Indicator - Example 6](https://raw.githubusercontent.com/SandroMaglione/step-progress-indicator/master/doc/screenshots/step_progress_indicator/linear_bar_example6.png)

```dart
StepProgressIndicator(
    totalSteps: 5,
    padding: 20.0,
    size: 20,
    customColor: (index) => index == 0
        ? Colors.redAccent
        : index == 4 ? Colors.blueAccent : Colors.deepOrange,
)
```

#### StepProgressIndicator - Example 7
![Step Progress Indicator - Example 7](https://raw.githubusercontent.com/SandroMaglione/step-progress-indicator/master/doc/screenshots/step_progress_indicator/linear_bar_example7.png)

```dart
StepProgressIndicator(
    totalSteps: 6,
    currentStep: 4,
    size: 36,
    selectedColor: Colors.black,
    unselectedColor: Colors.grey[200],
    customStep: (index, color, _) => color == Colors.black
        ? Container(
            color: color,
            child: Icon(
            Icons.check,
            color: Colors.white,
            ),
        )
        : Container(
            color: color,
            child: Icon(
            Icons.remove,
            ),
        ),
)
```

#### StepProgressIndicator - Example 8
![Step Progress Indicator - Example 8](https://raw.githubusercontent.com/SandroMaglione/step-progress-indicator/master/doc/screenshots/step_progress_indicator/linear_bar_example8.png)

```dart
StepProgressIndicator(
    totalSteps: 10,
    currentStep: 7,
    selectedColor: Colors.pink,
    unselectedColor: Colors.amber,
    customSize: (index) => (index + 1) * 10.0,
)
```

---

## Parameters

| Parameter       	| Type | Description | Default |
|-------------------|------|-------------|---------|
| totalSteps    | `int` | Total number of step of the complete indicator. | `@required` |
| currentStep 	| `int` | Number of steps to underline, all the steps with index <= currentStep will have Color equal to selectedColor. | 0 |
| customStep`(int, Color, double)` | `Widget` | Defines a custom Widget to display at each step, given the current step index, the Color, which could be defined with selectedColor and unselectedColor or using customColor, and its size, which could be defined using size, selectedSize, unselectedSize, or customSize. | - |
| onTap`(int)`         	| `void Function()` | Defines onTap function given index of the pressed step. | - |
| customColor`(int)`         	| `Color` | Assign a custom Color for each step. | - |
| customSize`(int)`         	| `double` | Assign a custom size for each step. | - |
| selectedColor         	| `Color` | Color of the selected steps. | `Colors.blue` |
| unselectedColor         	| `Color` | Color of the unselected steps. | `Colors.grey` |
| direction         	| `Axis` | Defines if indicator is horizontal or vertical. | `Axis.horizontal` |
| progressDirection         	| `TextDirection` | Defines if steps grow from left-to-right / top-to-bottom `TextDirection.ltr` or right-to-left / bottom-to-top `TextDirection.rtl`. | `TextDirection.ltr` |
| Size   | `double` | Size of the indicator (height if `direction` is `Axis.horizontal`, width if `Axis.vertical`). | 4.0 |
| padding         	| `double` | Spacing between each step. | 2.0 |
| fallbackLength         	| `double` | Length of the progress indicator in case the main axis (based on `direction` attribute) has no size limit i.e. `double.infinity`. | 100.0 |
| selectedSize         	| `double` | Specify a custom size for selected steps. | - |
| unselectedSize         	| `double` | Specify a custom size for unselected steps. | - |

## Ideas
I am always open for suggestions and ideas for possible improvements or fixes.

Here below a list of coming/future improvements:
- Adding support for animations

## Versioning
- v0.1.1+2 - 24 January 2020
- v0.1.0+1 - 23 January 2020

## License
GNU General Public License v3.0, see the [LICENSE.md](https://github.com/SandroMaglione/step-progress-indicator/blob/master/LICENSE) file for details.