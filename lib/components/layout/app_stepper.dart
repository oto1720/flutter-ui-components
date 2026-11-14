import 'package:flutter/material.dart';

/// ステップの並び方向。
enum AppStepperDirection { horizontal, vertical }

/// 1 ステップ分の定義。
class AppStep {
  const AppStep({required this.title, required this.content});

  final String title;
  final Widget content;
}

/// 複数ステップの進行を表す共通ステッパー。
///
/// 設計方針:
/// - 現在のステップ（[currentStep]）は親が持ち、[onStepChanged] で通知する。
/// - [direction] で横並び／縦並びを切り替える。
/// - 標準の [Stepper] をラップし、使う側は AppStep のリストを渡すだけにする。
class AppStepper extends StatelessWidget {
  const AppStepper({
    super.key,
    required this.steps,
    required this.currentStep,
    required this.onStepChanged,
    this.direction = AppStepperDirection.vertical,
  });

  final List<AppStep> steps;
  final int currentStep;
  final ValueChanged<int> onStepChanged;
  final AppStepperDirection direction;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: currentStep,
      type: direction == AppStepperDirection.horizontal
          ? StepperType.horizontal
          : StepperType.vertical,
      onStepTapped: onStepChanged,
      onStepContinue: currentStep < steps.length - 1
          ? () => onStepChanged(currentStep + 1)
          : null,
      onStepCancel: currentStep > 0
          ? () => onStepChanged(currentStep - 1)
          : null,
      steps: [
        for (final step in steps)
          Step(title: Text(step.title), content: step.content),
      ],
    );
  }
}
