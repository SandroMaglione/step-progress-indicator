import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

void main() {
  final int tTotalSteps = 10;

  final double tWidth = 200;
  final double tHeight = 200;

  testWidgets('should build the Container containing the circular indicator',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CircularStepProgressIndicator(
          totalSteps: tTotalSteps,
        ),
      ),
    );

    final container = find.byType(SizedBox);

    expect(
      container,
      findsNWidgets(1),
    );
  });

  testWidgets(
      'should build a Container of the correct specified size (height and width)',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Column(
          children: <Widget>[
            CircularStepProgressIndicator(
              totalSteps: tTotalSteps,
              height: tHeight,
              width: tWidth,
            ),
          ],
        ),
      ),
    );

    final container = find.byType(SizedBox);

    expect(
      container.evaluate().first.size,
      Size(tWidth, tHeight),
    );
  });

  testWidgets(
      'should build a Container of the correct specified size (fallbackHeight)',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Column(
          children: <Widget>[
            CircularStepProgressIndicator(
              totalSteps: tTotalSteps,
              width: tWidth,
              fallbackHeight: tHeight,
            ),
          ],
        ),
      ),
    );

    final container = find.byType(SizedBox);

    expect(
      container.evaluate().first.size.height,
      tHeight,
    );
  });

  testWidgets(
      'should build a Container of the correct specified size (fallBackWidth)',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Row(
          children: <Widget>[
            CircularStepProgressIndicator(
              totalSteps: tTotalSteps,
              height: tHeight,
              fallbackWidth: tWidth,
            ),
          ],
        ),
      ),
    );

    final container = find.byType(SizedBox);

    expect(
      container.evaluate().first.size.width,
      tWidth,
    );
  });

  testWidgets('should build the child Widget given inside the indicator',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Row(
          children: <Widget>[
            CircularStepProgressIndicator(
              totalSteps: tTotalSteps,
              height: tHeight,
              width: tWidth,
              child: Text('text'),
            ),
          ],
        ),
      ),
    );

    final text = find.byType(Text);

    expect(
      text,
      findsNWidgets(1),
    );
  });
}
