import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:toneup/model/workouts.dart';

class ExercsieScreeen extends StatefulWidget {
  final Exercise exercise;
  final int totalSet;
  const ExercsieScreeen({
    super.key,
    required this.exercise,
    required this.totalSet,
  });

  @override
  State<ExercsieScreeen> createState() => _ExercsieScreeenState();
}

class _ExercsieScreeenState extends State<ExercsieScreeen> {
  int _totalSet = 0;
  int _totalTime = 0;
  int _oneSetTime = 0;
  late Timer _timer;
  bool _isTimerStart = false;

  @override
  void initState() {
    super.initState();
    _oneSetTime = widget.exercise.time.toInt() * 60 +
        ((widget.exercise.time - widget.exercise.time.toInt()) * 100).toInt();
    setState(() {
      _totalSet = widget.totalSet;
      _totalTime = _oneSetTime * _totalSet;
    });
  }

  void _timerController() {
    if (!_isTimerStart) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _isTimerStart = true;
        });
        if (_totalTime == 0) {
          setState(() {
            _isTimerStart = false;
            _totalTime = 0;
          });
          _timer.cancel();
          return;
        }
        setState(() {
          _totalTime--;
        });
        if (_totalTime == 0) {
          _timer.cancel();
        }
      });
    } else {
      _timer.cancel();
      setState(() {
        _isTimerStart = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.exercise.getName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.background,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: Theme.of(context).colorScheme.background,
                    size: 20,
                  ),
                  Text(
                    ": ${widget.exercise.calBurn * _totalSet} cal",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.background,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const VerticalDivider(),
                  Text(
                    "Count: $_totalSet",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.background,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                child: InkWell(
                  onTap: () {
                    _timerController();
                  },
                  child: CircularPercentIndicator(
                    radius: 120,
                    lineWidth: 15,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Theme.of(context).colorScheme.background,
                    percent: _totalSet != 0
                        ? _totalTime / (_oneSetTime * _totalSet)
                        : 1,
                    center: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          _isTimerStart
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 150,
                        ),
                        Text(
                          _totalTime.toString(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.background,
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _totalTime = 0;
                        });
                      },
                      icon: Icon(
                        Icons.skip_next_rounded,
                        color: Theme.of(context).colorScheme.background,
                        size: 53,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _totalTime = _oneSetTime * _totalSet;
                        });
                      },
                      icon: Icon(
                        Icons.replay_rounded,
                        color: Theme.of(context).colorScheme.background,
                        size: 43,
                      )),
                ],
              )
            ],
          )),
    );
  }
}

class VerticalDivider extends StatelessWidget {
  const VerticalDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1,
          height: 18,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          color: Theme.of(context).colorScheme.background,
        ),
      ],
    );
  }
}
