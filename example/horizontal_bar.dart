import 'package:flutter/material.dart';
// TODO: IMPORT THE PACKAGE
// import 'package:#name/packages/step_progress_indicator.dart';

class HorizontalBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 24.0,
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    StepProgressIndicator(
                      totalSteps: 10,
                      currentStep: 6,
                    ),
                    StepProgressIndicator(
                      totalSteps: 16,
                      currentStep: 10,
                      unselectedColor: Colors.red,
                      selectedColor: Colors.yellow,
                      height: 10.0,
                    ),
                    StepProgressIndicator(
                      totalSteps: 6,
                      customColor: (index) =>
                          index % 2 == 0 ? Colors.pink : Colors.black,
                      height: 20.0,
                    ),
                    StepProgressIndicator(
                      totalSteps: 10,
                      currentStep: 9,
                      customStep: (index, color) => Container(
                        color: color,
                        child: Text(
                          '$index',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      height: 20.0,
                    ),
                    StepProgressIndicator(
                      totalSteps: 10,
                      customColor: (index) =>
                          index % 3 == 0 ? Colors.white : Colors.green,
                      progressDirection: TextDirection.rtl,
                      height: 6.0,
                      padding: 10.0,
                    ),
                    StepProgressIndicator(
                      totalSteps: 10,
                      direction: Axis.horizontal,
                      width: 30,
                      progressDirection: TextDirection.rtl,
                      onTap: (index) {
                        return () {
                          print('$index pressed');
                        };
                      },
                      customStep: (index, color) => Container(
                        color: color.withOpacity(index / 10),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          '$index',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 6.0 + (index * 5.2),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      currentStep: 7,
                      customColor: (index) => index % 2 == 0
                          ? Colors.yellow[900]
                          : index % 3 == 0 ? Colors.blue[900] : Colors.black54,
                      padding: 6.0,
                    ),
                  ],
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
