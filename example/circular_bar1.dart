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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CircularStepProgressIndicator(
                          totalSteps: 10,
                          currentStep: 6,
                          width: 100,
                          roundedCap: (_, isSelected) => isSelected,
                        ),
                        CircularStepProgressIndicator(
                          totalSteps: 12,
                          currentStep: 6,
                          selectedColor: Colors.redAccent,
                          unselectedColor: Colors.grey[200],
                          selectedStepSize: 10.0,
                          width: 100,
                          gradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.cyan, Colors.orangeAccent],
                          ),
                        ),
                        CircularStepProgressIndicator(
                          totalSteps: 20,
                          currentStep: 6,
                          padding: math.pi / 15,
                          selectedColor: Colors.cyan,
                          unselectedColor: Colors.yellowAccent,
                          selectedStepSize: 3.0,
                          unselectedStepSize: 9.0,
                          width: 100,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CircularStepProgressIndicator(
                          totalSteps: 20,
                          currentStep: 12,
                          stepSize: 20,
                          selectedColor: Colors.red,
                          unselectedColor: Colors.purple[400],
                          padding: math.pi / 80,
                          width: 150,
                          height: 150,
                          startingAngle: -math.pi * 2 / 3,
                          arcSize: math.pi * 2 / 3 * 2,
                          gradientColor: LinearGradient(
                            colors: [Colors.red, Colors.purple[400]],
                          ),
                        ),
                        CircularStepProgressIndicator(
                          totalSteps: 100,
                          currentStep: 74,
                          stepSize: 10,
                          selectedColor: Colors.greenAccent,
                          unselectedColor: Colors.grey[200],
                          padding: 0,
                          width: 150,
                          height: 150,
                          selectedStepSize: 15,
                          roundedCap: (_, __) => true,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
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
                          totalSteps: 30,
                          currentStep: 20,
                          selectedColor: Colors.lightGreen,
                          unselectedColor: Colors.black,
                          padding: math.pi / 60,
                          width: 100,
                          startingAngle: math.pi / 3,
                          arcSize: math.pi,
                          child: CircularStepProgressIndicator(
                            totalSteps: 30,
                            currentStep: 20,
                            selectedColor: Colors.lightBlue,
                            unselectedColor: Colors.black,
                            padding: math.pi / 60,
                            width: 100,
                            startingAngle: math.pi,
                            arcSize: math.pi,
                            child: CircularStepProgressIndicator(
                              totalSteps: 30,
                              currentStep: 20,
                              selectedColor: Colors.yellow,
                              unselectedColor: Colors.black,
                              padding: math.pi / 60,
                              width: 100,
                              startingAngle: -math.pi / 3,
                              arcSize: math.pi,
                              child: CircularStepProgressIndicator(
                                totalSteps: 30,
                                currentStep: 20,
                                selectedColor: Colors.cyanAccent,
                                unselectedColor: Colors.black,
                                padding: math.pi / 60,
                                width: 100,
                                startingAngle: math.pi / 3,
                                arcSize: math.pi,
                                child: CircularStepProgressIndicator(
                                  totalSteps: 30,
                                  currentStep: 20,
                                  selectedColor: Colors.deepOrangeAccent,
                                  unselectedColor: Colors.black,
                                  padding: math.pi / 60,
                                  width: 100,
                                  startingAngle: math.pi,
                                  arcSize: math.pi,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
