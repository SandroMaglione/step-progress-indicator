import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'dart:math' as math;

class CircularBar1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 24.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularStepProgressIndicator(
                      totalSteps: 10,
                      currentStep: 6,
                      width: 100,
                    ),
                    CircularStepProgressIndicator(
                      totalSteps: 30,
                      currentStep: 12,
                      stepSize: 20,
                      selectedColor: Colors.red,
                      unselectedColor: Colors.grey[200],
                      padding: math.pi / 80,
                      width: 150,
                      height: 150,
                    ),
                    CircularStepProgressIndicator(
                      totalSteps: 100,
                      currentStep: 72,
                      selectedColor: Colors.yellow,
                      unselectedColor: Colors.lightBlue,
                      padding: 0,
                      width: 100,
                      child: Icon(
                        Icons.tag_faces,
                        color: Colors.red,
                        size: 84,
                      ),
                    ),
                    CircularStepProgressIndicator(
                      totalSteps: 20,
                      stepSize: 20,
                      customColor: (index) => index % 3 == 0
                          ? Colors.deepPurple
                          : index % 2 == 0
                              ? Colors.deepOrange
                              : Colors.grey[100],
                      width: 250,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'https//www.sandromaglione.com',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
