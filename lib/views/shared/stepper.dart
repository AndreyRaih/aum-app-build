import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const String STEPPER_DIR_VALUE_NEXT = 'next';
const String STEPPER_DIR_VALUE_PREV = 'prev';
const String STEPPRT_DIR_VALUE_DEFAULT = 'initial';

class AumStepper extends StatefulWidget {
  final int step;
  final List<Widget> steps;
  final bool wideIndicators;
  final Function onStepsEnd;
  const AumStepper({this.step = 0, this.steps, this.wideIndicators = false, this.onStepsEnd});
  _AumStepperState createState() => _AumStepperState();
}

class _AumStepperState extends State<AumStepper> with SingleTickerProviderStateMixin {
  int _currentStep = 0;
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setStep(widget.step);
    _initAnimation();
    _setAnimationDirection(STEPPRT_DIR_VALUE_DEFAULT);
  }

  void _setStep(int step) => setState(() => _currentStep = step);

  void _initAnimation() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
  }

  void _changeStep(int step) async {
    int _max = widget.steps.length;
    String _direction = step > _currentStep ? STEPPER_DIR_VALUE_NEXT : STEPPER_DIR_VALUE_PREV;
    if (step < _max) {
      _setAnimationDirection(_direction);
      await _controller.forward();
      _setStep(step);
      await _controller.reverse();
    } else {
      widget.onStepsEnd();
    }
  }

  void _setAnimationDirection(String direction) {
    Offset _offset;
    switch (direction) {
      case 'next':
        _offset = Offset(1.5, 0);
        break;
      case 'prev':
        _offset = Offset(-1.5, 0);
        break;
      case 'initial':
        _offset = Offset(-1.5, 0);
        break;
      default:
        _offset = Offset(-1.5, 0);
        break;
    }
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: _offset,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutExpo,
    ));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Expanded(
              child: SlideTransition(
            position: _offsetAnimation,
            child: widget.steps[_currentStep],
          )),
          _Controlls(
            step: _currentStep,
            steps: widget.steps.length,
            wideIndicators: widget.wideIndicators,
            onChangeStep: (step) => _changeStep(step),
          )
        ],
      );
}

class _Controlls extends StatelessWidget {
  final int step;
  final int steps;
  final Function(int) onChangeStep;
  final bool wideIndicators;
  _Controlls({this.step, this.steps, this.onChangeStep, this.wideIndicators});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _Action(
          text: 'Prev',
          onTap: () => onChangeStep(step - 1),
          disabled: step == 0,
        ),
        AumIndicatorsDots(step: step, steps: steps, wideIndicators: wideIndicators),
        _Action(
          text: 'Next',
          onTap: () => onChangeStep(step + 1),
        ),
      ],
    );
  }
}

class _Action extends StatelessWidget {
  final Function onTap;
  final String text;
  final bool disabled;
  _Action({@required this.text, this.onTap, this.disabled = false});

  @override
  Widget build(BuildContext context) {
    Widget _text = AumText.bold(
      text.toUpperCase(),
      size: 24,
      color: AumColor.accent,
    );
    return !disabled
        ? GestureDetector(onTap: onTap, child: _text)
        : Opacity(
            opacity: 0.5,
            child: _text,
          );
  }
}

class AumIndicatorsDots extends StatelessWidget {
  final int step;
  final int steps;
  final bool wideIndicators;
  AumIndicatorsDots({this.step, this.steps, this.wideIndicators = false});

  List<int> _buildIndicatorsList(int count) => new List.generate(count, (index) => index++);

  @override
  Widget build(BuildContext context) {
    List<int> _indicators = _buildIndicatorsList(steps);
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _indicators.map((index) => _IndicatorDot(isActive: index == step, isWide: wideIndicators)).toList());
  }
}

class _IndicatorDot extends StatelessWidget {
  final double _width = 12;
  final double _wideWidth = 28;
  final double _height = 12;
  final Color _activeColor = AumColor.accent;
  final Color _color = Colors.black.withOpacity(0.25);
  final bool isActive;
  final bool isWide;
  _IndicatorDot({this.isActive = false, this.isWide = false});

  @override
  Widget build(BuildContext context) {
    double _currentWidth = isActive && isWide ? _wideWidth : _width;
    Color _currentColor = isActive ? _activeColor : _color;
    return AnimatedContainer(
        margin: EdgeInsets.symmetric(horizontal: 2),
        duration: Duration(milliseconds: 200),
        width: _currentWidth,
        height: _height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: _currentColor,
        ));
  }
}
