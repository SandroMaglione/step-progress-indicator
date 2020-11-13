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
            onTap: (_) => () {},
          ),
        ),
      ),
    );

    // Build all the step
    final steps = find.byType(Container);

    // Find all the steps (plus the indicator container)
    expect(
      steps,
      findsNWidgets(tTotalSteps + 1),
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
            customStep: (index, _, __) => Text('$index'),
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
            customStep: (index, _, __) => Text('$index'),
          ),
        ),
      ),
    );

    // Build all the step
    final text1 = find.text('0');
    final text2 = find.text('1');
    final text3 = find.text('2');

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

  testWidgets('should build the correct selected and unselected colors',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Container(
          width: tWidth,
          child: StepProgressIndicator(
            totalSteps: tTotalSteps,
            currentStep: tCurrentStep,
            selectedColor: Colors.red,
            customStep: (index, color, _) {
              if (color == Colors.red) {
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

  testWidgets('should build the step right-to-left correctly',
      (WidgetTester tester) async {
    int creationIndex = -1;
    await tester.pumpWidget(
      MaterialApp(
        home: Container(
          width: tWidth,
          child: StepProgressIndicator(
            totalSteps: tTotalSteps,
            currentStep: tCurrentStep,
            progressDirection: TextDirection.rtl,
            customStep: (index, color, _) {
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
          tTotalSteps, (index) => '$index-${tTotalSteps - index - 1}'),
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
              size: tWidth,
            ),
          ),
        ),
      ),
    );

    // Build all the step
    final steps = find.byType(Container);

    // Find all the steps (skip the indicator container)
    expect(
      steps.evaluate().skip(1).map((element) => element.size.width),
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
              size: tHeight,
            ),
          ),
        ),
      ),
    );

    // Build all the step
    final steps = find.byType(Container);

    // Find all the steps (skip the indicator container)
    expect(
      steps.evaluate().skip(1).map((element) => element.size.height),
      List<double>.filled(tTotalSteps, tHeight),
    );
  });

  testWidgets(
      'should build only two steps (selected and unselected) when no custom setting and padding is 0.0',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Container(
            width: tWidth,
            child: StepProgressIndicator(
              totalSteps: tTotalSteps,
              currentStep: tCurrentStep,
              padding: 0.0,
            ),
          ),
        ),
      ),
    );

    // Build all the step
    final steps = find.byType(Container);

    // Find all the steps (plus the container of the indicator)
    expect(
      steps,
      findsNWidgets(3),
    );
  });

  testWidgets(
      'should all the steps have the same width (considered the extra padding)',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Container(
            width: tWidth,
            child: StepProgressIndicator(
              totalSteps: tTotalSteps,
              direction: Axis.horizontal,
              padding: 2.0,
            ),
          ),
        ),
      ),
    );

    // Build all the step
    final steps = find.byType(Container);

    // Find all the steps (skip the indicator container)
    expect(
      steps.evaluate().skip(1).map((element) => element.size.width),
      List<double>.filled(
          tTotalSteps, (tWidth - (tTotalSteps * 2.0 * 2)) / tTotalSteps),
    );
  });

  testWidgets('should use fallbackLength when size is unbounded',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Row(
            children: <Widget>[
              StepProgressIndicator(
                totalSteps: tTotalSteps,
                fallbackLength: 150,
              ),
            ],
          ),
        ),
      ),
    );

    final steps = find.byType(StepProgressIndicator);

    expect(
      steps.evaluate().first.size.width,
      150,
    );
  });

  testWidgets('should build a Column when the indicator direction is vertical',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Row(
            children: <Widget>[
              StepProgressIndicator(
                totalSteps: tTotalSteps,
                direction: Axis.vertical,
              ),
            ],
          ),
        ),
      ),
    );

    final steps = find.byType(Column);
    final stepsRow = find.byType(Row);

    expect(
      steps,
      findsWidgets,
    );
    expect(
      stepsRow,
      findsNWidgets(1),
    );
  });

  testWidgets(
      'should apply the correct defined size to the height of the step when horizontal',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Row(
            children: <Widget>[
              StepProgressIndicator(
                totalSteps: tTotalSteps,
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
    );

    final steps = find.byType(Container);

    expect(steps.evaluate().map((element) => element.size.height),
        List<double>.filled(tTotalSteps, 30.0));
  });

  testWidgets(
      'should apply the correct defined size to the width of the step when vertical',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Row(
            children: <Widget>[
              StepProgressIndicator(
                totalSteps: tTotalSteps,
                direction: Axis.vertical,
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
    );

    final steps = find.byType(Container);

    expect(steps.evaluate().map((element) => element.size.width),
        List<double>.filled(tTotalSteps, 30.0));
  });

  testWidgets(
      'should apply selected and unselected specific sizes when specified',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Row(
            children: <Widget>[
              StepProgressIndicator(
                totalSteps: 10,
                currentStep: 6,
                selectedSize: 20,
                unselectedSize: 10,
              ),
            ],
          ),
        ),
      ),
    );

    final steps = find.byType(Container);

    expect(
      steps.evaluate().where((element) => element.size.height == 20).length,
      6,
    );

    expect(
      steps.evaluate().where((element) => element.size.height == 10).length,
      4,
    );
  });

  testWidgets(
      'should apply customColor(s) and customStep(s) correctly (zero-based indexing)',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Row(
            children: <Widget>[
              StepProgressIndicator(
                totalSteps: tTotalSteps,
                customColor: (index) => index == 0
                    ? Colors.red
                    : index == 9
                        ? Colors.black
                        : Colors.blue,
                customStep: (index, color, _) {
                  if ((index == 0 && color == Colors.red) ||
                      (index == 9 && color == Colors.black) ||
                      (index != 0 && index != 9 && color == Colors.blue)) {
                    return Text('correct');
                  } else {
                    return Text('incorrect');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );

    final textCorrect = find.text('correct');
    final textIncorrect = find.text('incorrect');

    expect(
      textCorrect,
      findsNWidgets(tTotalSteps),
    );
    expect(
      textIncorrect,
      findsNWidgets(0),
    );
  });

  testWidgets('should apply customSize(s) correctly (zero-based indexing)',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Row(
            children: <Widget>[
              StepProgressIndicator(
                totalSteps: tTotalSteps,
                customSize: (index, _) => index == 0
                    ? 20
                    : index == 9
                        ? 2
                        : 10,
              ),
            ],
          ),
        ),
      ),
    );

    final steps = find.byType(Container);

    expect(
      steps.evaluate().where((element) => element.size.height == 20).length,
      1,
    );

    expect(
      steps.evaluate().where((element) => element.size.height == 2).length,
      1,
    );

    expect(
      steps.evaluate().where((element) => element.size.height == 10).length,
      tTotalSteps - 2,
    );
  });

  group('roundedEdges', () {
    final double tEdgesValue = 20;
    final Radius tRoundedEdges = Radius.circular(tEdgesValue);
    final StepProgressIndicator tStepProgressIndicatorDefault =
        StepProgressIndicator(
      totalSteps: tTotalSteps,
      roundedEdges: tRoundedEdges,
    );

    Future<void> init(WidgetTester tester,
            [StepProgressIndicator stepProgressIndicator]) =>
        tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Row(
                children: <Widget>[
                  stepProgressIndicator ?? tStepProgressIndicatorDefault,
                ],
              ),
            ),
          ),
        );

    testWidgets('should apply roundedEdges when defined',
        (WidgetTester tester) async {
      await init(tester);
      final steps = find.byType(ClipRRect);
      expect(steps.evaluate().length, 2);
    });

    testWidgets('should not apply roundedEdges when not defined',
        (WidgetTester tester) async {
      await init(tester, StepProgressIndicator(totalSteps: 10));
      final steps = find.byType(ClipRRect);
      expect(steps.evaluate().isEmpty, true);
    });

    testWidgets('should have correct radius', (WidgetTester tester) async {
      await init(tester);

      final steps = find.byType(ClipRRect);
      final firstClipRRect = steps.evaluate().first.widget as ClipRRect;
      final lastClipRRect = steps.evaluate().last.widget as ClipRRect;

      expect(
        steps.evaluate().length,
        2,
      );

      expect(
        firstClipRRect.borderRadius.topLeft.x == tEdgesValue &&
            firstClipRRect.borderRadius.bottomLeft.x == tEdgesValue &&
            firstClipRRect.borderRadius.topLeft.y == tEdgesValue &&
            firstClipRRect.borderRadius.bottomLeft.y == tEdgesValue,
        true,
      );

      expect(
        lastClipRRect.borderRadius.topRight.x == tEdgesValue &&
            lastClipRRect.borderRadius.bottomRight.x == tEdgesValue &&
            lastClipRRect.borderRadius.topRight.y == tEdgesValue &&
            lastClipRRect.borderRadius.bottomRight.y == tEdgesValue,
        true,
      );
    });

    testWidgets('should apply correct radius when only one step',
        (WidgetTester tester) async {
      await init(
        tester,
        StepProgressIndicator(
          totalSteps: 1,
          roundedEdges: tRoundedEdges,
        ),
      );

      final steps = find.byType(ClipRRect);
      final firstClipRRect = steps.evaluate().first.widget as ClipRRect;

      expect(
        steps.evaluate().length,
        1,
      );

      expect(
        firstClipRRect.borderRadius.topLeft.x == tEdgesValue &&
            firstClipRRect.borderRadius.bottomLeft.x == tEdgesValue &&
            firstClipRRect.borderRadius.topLeft.y == tEdgesValue &&
            firstClipRRect.borderRadius.bottomLeft.y == tEdgesValue &&
            firstClipRRect.borderRadius.topRight.x == tEdgesValue &&
            firstClipRRect.borderRadius.bottomRight.x == tEdgesValue &&
            firstClipRRect.borderRadius.topRight.y == tEdgesValue &&
            firstClipRRect.borderRadius.bottomRight.y == tEdgesValue,
        true,
      );
    });
  });

  testWidgets('should apply gradient when defined',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Row(
            children: <Widget>[
              StepProgressIndicator(
                totalSteps: tTotalSteps,
                gradientColor: LinearGradient(
                  colors: [Colors.orange, Colors.white],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final steps = find.byType(ShaderMask);

    expect(
      steps.evaluate().length,
      1,
    );
  });
}
