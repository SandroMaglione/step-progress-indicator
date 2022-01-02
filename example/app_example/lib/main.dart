import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Step Progress Indicator Example",
      home: GradientRoundedEdge(),
    );
  }
}

class GradientRoundedEdge extends StatelessWidget {
  const GradientRoundedEdge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            Container(
              color: Colors.grey[600],
              padding: const EdgeInsets.all(10),
              child: const StepProgressIndicator(
                totalSteps: 100,
                currentStep: 40,
                size: 30,
                padding: 0,
                roundedEdges: Radius.circular(100), // Needed
                selectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0XFFFFE2CD),
                    Color(0XFFFEC2E7),
                    Color(0XFFC9E7FF),
                    Color(0XFF86FEF4),
                  ],
                ),
                unselectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0XFF171C21),
                    Colors.black,
                  ],
                ), // Needed
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class WithLabelSizedIndicator extends StatelessWidget {
  const WithLabelSizedIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            // With custom step
            StepProgressIndicator(
              totalSteps: 20,
              currentStep: 4,
              size: 30,
              customStep: (index, _, __) => Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: Column(
                  children: [
                    Text('$index'),
                    Container(
                      height: 10,
                      color: Colors.yellow,
                    )
                  ],
                ),
              ),
            ),

            // Spacing
            const SizedBox(height: 30),

            // With double indicator
            Column(
              children: [
                StepProgressIndicator(
                  totalSteps: 20,
                  currentStep: 4,
                  size: 20,
                  customStep: (index, _, __) => Text('$index'),
                ),
                const StepProgressIndicator(
                  totalSteps: 20,
                  currentStep: 4,
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}

class ScrollContainerSize extends StatelessWidget {
  const ScrollContainerSize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 300,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Box(height: 500),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FixedContainerSize extends StatelessWidget {
  const FixedContainerSize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Box(height: 100),
            Box(height: 200),
            Box(height: 300),
            Box(height: 400),
            Box(height: 500),
          ],
        ),
      ),
    );
  }
}

class Box extends StatelessWidget {
  final double height;
  const Box({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      width: 100,
      height: height,
      child: const Indicator(),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const StepProgressIndicator(
      totalSteps: 10,
      currentStep: 5,
      size: 20,
      direction: Axis.vertical,
    );
  }
}
