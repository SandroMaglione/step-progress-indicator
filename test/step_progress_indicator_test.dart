import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

void main() {
  final int tTotalSteps = 10;
  final int tTotalStepsCustomStep = 3;
  final int tCurrentStep = 6;

  final double tWidth = 100;
  final double tHeight = 100;

  testWidgets('should build all the steps of the indicator',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Container(
          width: tWidth,
          child: StepProgressIndicator(
            totalSteps: tTotalSteps,
          ),
        ),
      ),
    );

    // Build all the step (each step has a GestureDetector)
    final steps = find.byType(GestureDetector);

    // Find all the steps
    expect(
      steps,
      findsNWidgets(tTotalSteps),
    );
  });

  testWidgets('should build all the custom steps of the indicator',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Container(
          width: tWidth,
          child: StepProgressIndicator(
            totalSteps: tTotalSteps,
            customStep: (index, _) => Text('$index'),
          ),
        ),
      ),
    );

    // Build all the step
    final steps = find.byType(Text);

    // Find all the steps
    expect(
      steps,
      findsNWidgets(tTotalSteps),
    );
  });

  testWidgets('should build the correct custom steps content',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Container(
          width: tWidth,
          child: StepProgressIndicator(
            totalSteps: tTotalStepsCustomStep,
            customStep: (index, _) => Text('$index'),
          ),
        ),
      ),
    );

    // Build all the step
    final text1 = find.text('1');
    final text2 = find.text('2');
    final text3 = find.text('3');

    // Find all the steps
    expect(
      text1,
      findsOneWidget,
    );
    expect(
      text2,
      findsOneWidget,
    );
    expect(
      text3,
      findsOneWidget,
    );
  });

  testWidgets('should build the correct selected and unselected color',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Container(
          width: tWidth,
          child: StepProgressIndicator(
            totalSteps: tTotalSteps,
            currentStep: tCurrentStep,
            customStep: (index, color) {
              if (color == Colors.blue) {
                return Text('selected');
              } else {
                return Text('unselected');
              }
            },
          ),
        ),
      ),
    );

    // Build selected and unselected steps
    final textSelected = find.text('selected');
    final textUnselected = find.text('unselected');

    expect(
      textSelected,
      findsNWidgets(tCurrentStep),
    );
    expect(
      textUnselected,
      findsNWidgets(tTotalSteps - tCurrentStep),
    );
  });

  testWidgets('should build the step right-to-left',
      (WidgetTester tester) async {
    int creationIndex = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Container(
          width: tWidth,
          child: StepProgressIndicator(
            totalSteps: tTotalSteps,
            currentStep: tCurrentStep,
            progressDirection: TextDirection.rtl,
            customStep: (index, color) {
              ++creationIndex;
              return Text('$creationIndex-$index');
            },
          ),
        ),
      ),
    );

    // Build all the steps
    final textSelected = find.byType(Text);

    expect(
      textSelected.evaluate().map((element) => (element.widget as Text).data),
      List<String>.generate(
          tTotalSteps, (index) => '${index + 1}-${tTotalSteps - index}'),
    );
  });

  testWidgets('should assign the correct width to the step',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Container(
            height: tHeight,
            child: StepProgressIndicator(
              totalSteps: tTotalSteps,
              direction: Axis.vertical,
              padding: 0.0,
              width: tWidth,
            ),
          ),
        ),
      ),
    );

    // Build all the step (each step has a GestureDetector)
    final steps = find.byType(GestureDetector);

    // Find all the steps
    expect(
      steps.evaluate().map((element) => element.size.width),
      List<double>.filled(tTotalSteps, tWidth),
    );
  });

  testWidgets('should assign the correct height to the step',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Container(
            width: tWidth,
            child: StepProgressIndicator(
              totalSteps: tTotalSteps,
              direction: Axis.horizontal,
              padding: 0.0,
              height: tHeight,
            ),
          ),
        ),
      ),
    );

    // Build all the step (each step has a GestureDetector)
    final steps = find.byType(GestureDetector);

    // Find all the steps
    expect(
      steps.evaluate().map((element) => element.size.height),
      List<double>.filled(tTotalSteps, tHeight),
    );
  });

  testWidgets('should all the steps have the same width',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Container(
            width: tWidth,
            child: StepProgressIndicator(
              totalSteps: tTotalSteps,
              direction: Axis.horizontal,
              padding: 0.0,
            ),
          ),
        ),
      ),
    );

    // Build all the step (each step has a GestureDetector)
    final steps = find.byType(GestureDetector);

    // Find all the steps
    expect(
      steps.evaluate().map((element) => element.size.width),
      List<double>.filled(tTotalSteps, tWidth / tTotalSteps),
    );
  });
}
