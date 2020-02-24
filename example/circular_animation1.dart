import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CircularAnimation1 extends StatefulWidget {
  @override
  _CircularAnimation1State createState() => _CircularAnimation1State();
}

class _CircularAnimation1State extends State<CircularAnimation1>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 6000,
      ),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 10000,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 24.0,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularStepProgressIndicator(
                      totalSteps: 10000,
                      currentStep: _animation.value.toInt(),
                      selectedColor: Colors.blueAccent,
                      unselectedColor: Colors.grey[100],
                      width: 200,
                      height: 200,
                      padding: 0,
                      selectedStepSize: 10.0,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
