import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'dart:math' as math;

class CircularBar2 extends StatelessWidget {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CircularStepProgressIndicator(
                          totalSteps: 15,
                          currentStep: 3,
                          stepSize: 20,
                          width: 50,
                          height: 50,
                          unselectedColor: Colors.transparent,
                        ),
                        CircularStepProgressIndicator(
                          totalSteps: 15,
                          currentStep: 9,
                          stepSize: 10,
                          width: 50,
                          height: 50,
                          unselectedColor: Colors.transparent,
                        ),
                        CircularStepProgressIndicator(
                          totalSteps: 15,
                          currentStep: 12,
                          stepSize: 4,
                          width: 50,
                          height: 50,
                          unselectedColor: Colors.transparent,
                        ),
                        CircularStepProgressIndicator(
                          totalSteps: 15,
                          currentStep: 14,
                          stepSize: 1,
                          width: 50,
                          height: 50,
                          unselectedColor: Colors.transparent,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CircularStepProgressIndicator(
                          totalSteps: 40,
                          stepSize: 10,
                          padding: math.pi / 80,
                          width: 80,
                          height: 80,
                          customColor: (index) => index < 10
                              ? Colors.red[300]
                              : index < 20
                                  ? Colors.red[500]
                                  : index < 30
                                      ? Colors.red[900]
                                      : Colors.red[100],
                        ),
                        CircularStepProgressIndicator(
                          totalSteps: 30,
                          stepSize: 12,
                          padding: math.pi / 20,
                          width: 80,
                          height: 80,
                          customColor: (index) => index < 10
                              ? Colors.red[300]
                              : index < 20
                                  ? Colors.red[500]
                                  : index < 30
                                      ? Colors.red[900]
                                      : Colors.red[100],
                        ),
                        CircularStepProgressIndicator(
                          totalSteps: 20,
                          stepSize: 20,
                          padding: math.pi / 15,
                          width: 80,
                          height: 80,
                          customColor: (index) => index < 10
                              ? Colors.red[300]
                              : index < 15
                                  ? Colors.red[500]
                                  : Colors.red[100],
                        ),
                        CircularStepProgressIndicator(
                          totalSteps: 6,
                          currentStep: 3,
                          stepSize: 30,
                          padding: math.pi / 18,
                          width: 80,
                          height: 80,
                          selectedColor: Colors.red[800],
                          unselectedColor: Colors.red[100],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CircularStepProgressIndicator(
                          totalSteps: 100,
                          currentStep: 63,
                          selectedColor: Colors.teal,
                          unselectedColor: Colors.transparent,
                          padding: 0,
                          width: 100,
                          stepSize: 27,
                          child: CircleAvatar(
                            backgroundColor: Colors.teal,
                            child: Icon(
                              Icons.thumb_up,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        CircularStepProgressIndicator(
                          totalSteps: 100,
                          currentStep: 90,
                          selectedColor: Colors.lime[900],
                          unselectedColor: Colors.transparent,
                          padding: 0,
                          width: 100,
                          stepSize: 6,
                          child: CircularStepProgressIndicator(
                            totalSteps: 100,
                            currentStep: 80,
                            selectedColor: Colors.lime[800],
                            unselectedColor: Colors.transparent,
                            padding: 0,
                            stepSize: 6,
                            child: CircularStepProgressIndicator(
                              totalSteps: 100,
                              currentStep: 70,
                              selectedColor: Colors.lime[700],
                              unselectedColor: Colors.transparent,
                              padding: 0,
                              stepSize: 6,
                              child: CircularStepProgressIndicator(
                                totalSteps: 100,
                                currentStep: 60,
                                selectedColor: Colors.lime[600],
                                unselectedColor: Colors.transparent,
                                padding: 0,
                                stepSize: 6,
                                child: CircularStepProgressIndicator(
                                  totalSteps: 100,
                                  currentStep: 50,
                                  selectedColor: Colors.lime[500],
                                  unselectedColor: Colors.transparent,
                                  padding: 0,
                                  stepSize: 6,
                                  child: CircularStepProgressIndicator(
                                    totalSteps: 100,
                                    currentStep: 40,
                                    selectedColor: Colors.lime[400],
                                    unselectedColor: Colors.transparent,
                                    padding: 0,
                                    stepSize: 6,
                                    child: CircularStepProgressIndicator(
                                      totalSteps: 100,
                                      currentStep: 30,
                                      selectedColor: Colors.lime[300],
                                      unselectedColor: Colors.transparent,
                                      padding: 0,
                                      stepSize: 6,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        CircularStepProgressIndicator(
                          totalSteps: 100,
                          currentStep: 50,
                          selectedColor: Colors.cyan,
                          unselectedColor: Colors.transparent,
                          padding: 0,
                          stepSize: 6,
                          child: CircularStepProgressIndicator(
                            totalSteps: 100,
                            currentStep: 50,
                            selectedColor: Colors.cyan,
                            unselectedColor: Colors.transparent,
                            padding: 0,
                            stepSize: 6,
                            circularDirection:
                                CircularDirection.counterclockwise,
                            child: CircularStepProgressIndicator(
                              totalSteps: 100,
                              currentStep: 50,
                              selectedColor: Colors.cyan,
                              unselectedColor: Colors.transparent,
                              padding: 0,
                              stepSize: 12,
                              child: CircularStepProgressIndicator(
                                totalSteps: 100,
                                currentStep: 50,
                                selectedColor: Colors.cyan,
                                unselectedColor: Colors.transparent,
                                padding: 0,
                                stepSize: 6,
                                circularDirection:
                                    CircularDirection.counterclockwise,
                                child: CircularStepProgressIndicator(
                                  totalSteps: 100,
                                  currentStep: 50,
                                  selectedColor: Colors.cyan,
                                  unselectedColor: Colors.transparent,
                                  padding: 0,
                                  stepSize: 8,
                                  child: CircularStepProgressIndicator(
                                    totalSteps: 100,
                                    currentStep: 50,
                                    selectedColor: Colors.cyan,
                                    unselectedColor: Colors.transparent,
                                    padding: 0,
                                    stepSize: 6,
                                    circularDirection:
                                        CircularDirection.counterclockwise,
                                    child: CircularStepProgressIndicator(
                                      totalSteps: 100,
                                      currentStep: 50,
                                      selectedColor: Colors.cyan,
                                      unselectedColor: Colors.transparent,
                                      padding: 0,
                                      stepSize: 6,
                                      child: CircularStepProgressIndicator(
                                        totalSteps: 100,
                                        currentStep: 50,
                                        selectedColor: Colors.cyan,
                                        unselectedColor: Colors.transparent,
                                        padding: 0,
                                        stepSize: 6,
                                        circularDirection:
                                            CircularDirection.counterclockwise,
                                        child: CircularStepProgressIndicator(
                                          totalSteps: 100,
                                          currentStep: 50,
                                          selectedColor: Colors.cyan,
                                          unselectedColor: Colors.transparent,
                                          padding: 0,
                                          stepSize: 6,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CircularStepProgressIndicator(
                          totalSteps: 20,
                          stepSize: 20,
                          customColor: (index) => index % 3 == 0
                              ? Colors.deepPurple
                              : index % 2 == 0
                                  ? Colors.deepOrange
                                  : Colors.grey[100],
                          width: 60,
                          height: 60,
                        ),
                        CircularStepProgressIndicator(
                          totalSteps: 6,
                          stepSize: 6,
                          customColor: (index) => index % 3 == 0
                              ? Colors.deepPurple
                              : index % 2 == 0
                                  ? Colors.deepOrange
                                  : Colors.grey[100],
                          width: 60,
                          height: 60,
                        ),
                        CircularStepProgressIndicator(
                          totalSteps: 20,
                          customColor: (index) =>
                              (index > 6 && index < 10) || index > 16
                                  ? Colors.deepPurple
                                  : Colors.deepOrange,
                          width: 60,
                          height: 60,
                        ),
                        CircularStepProgressIndicator(
                          totalSteps: 3,
                          currentStep: 2,
                          selectedColor: Colors.deepOrange,
                          unselectedColor: Colors.deepPurple,
                          stepSize: 10,
                          width: 60,
                          height: 60,
                        ),
                      ],
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
