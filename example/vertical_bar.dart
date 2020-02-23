import 'package:flutter/material.dart';
import '../lib/step_progress_indicator.dart';

class VerticalBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 24.0,
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                StepProgressIndicator(
                  totalSteps: 10,
                  direction: Axis.vertical,
                  currentStep: 2,
                ),
                StepProgressIndicator(
                  totalSteps: 20,
                  direction: Axis.vertical,
                  currentStep: 2,
                  selectedColor: Colors.amber,
                  unselectedColor: Colors.black12,
                  size: 10.0,
                ),
                StepProgressIndicator(
                  totalSteps: 25,
                  direction: Axis.vertical,
                  customColor: (index) => Colors.deepOrange,
                  customStep: (index, color, _) => Icon(
                    Icons.tag_faces,
                    color: color,
                  ),
                ),
                StepProgressIndicator(
                  totalSteps: 10,
                  direction: Axis.vertical,
                  padding: 6.0,
                  size: 30.0,
                  customColor: (index) => Colors.lightBlue,
                  customStep: (index, color, _) => Container(
                    color: color,
                    alignment: Alignment.center,
                    child: Text('$index'),
                  ),
                ),
                StepProgressIndicator(
                  totalSteps: 20,
                  direction: Axis.vertical,
                  padding: 3.0,
                  size: 40.0,
                  progressDirection: TextDirection.rtl,
                  customColor: (index) => Colors.lightGreen,
                  customStep: (index, color, _) => Container(
                    color: color,
                    alignment: Alignment.center,
                    child: Text('$index'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.0,
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
    );
  }
}
