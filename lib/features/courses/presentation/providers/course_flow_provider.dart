import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CourseFlowStep { country, category, stage, grade, finalInfo }

class CourseFlowState {
  final CourseFlowStep currentStep;
  final String? selectedCountry;
  final String? selectedCategory; // مناهج دراسية vs كورسات
  final String? selectedStage; // الابتدائية vs الاعدادية
  final String? selectedGrade;

  CourseFlowState({
    this.currentStep = CourseFlowStep.country,
    this.selectedCountry,
    this.selectedCategory,
    this.selectedStage,
    this.selectedGrade,
  });

  CourseFlowState copyWith({
    CourseFlowStep? currentStep,
    String? selectedCountry,
    String? selectedCategory,
    String? selectedStage,
    String? selectedGrade,
  }) {
    return CourseFlowState(
      currentStep: currentStep ?? this.currentStep,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedStage: selectedStage ?? this.selectedStage,
      selectedGrade: selectedGrade ?? this.selectedGrade,
    );
  }
}

class CourseFlowNotifier extends StateNotifier<CourseFlowState> {
  CourseFlowNotifier() : super(CourseFlowState());

  void selectCountry(String country) {
    state = state.copyWith(
      selectedCountry: country,
      currentStep: CourseFlowStep.category,
    );
  }

  void selectCategory(String category) {
    if (category == 'مناهج دراسية') {
      state = state.copyWith(
        selectedCategory: category,
        currentStep: CourseFlowStep.stage,
      );
    } else {
      // For general courses, we skip to final or handle differently
      state = state.copyWith(
        selectedCategory: category,
        currentStep: CourseFlowStep.finalInfo,
      );
    }
  }

  void selectStage(String stage) {
    state = state.copyWith(
      selectedStage: stage,
      currentStep: CourseFlowStep.grade,
    );
  }

  void selectGrade(String grade) {
    state = state.copyWith(
      selectedGrade: grade,
      currentStep: CourseFlowStep.finalInfo,
    );
  }

  void reset() {
    state = CourseFlowState();
  }

  void goBack() {
    switch (state.currentStep) {
      case CourseFlowStep.category:
        state = state.copyWith(currentStep: CourseFlowStep.country);
        break;
      case CourseFlowStep.stage:
        state = state.copyWith(currentStep: CourseFlowStep.category);
        break;
      case CourseFlowStep.grade:
        state = state.copyWith(currentStep: CourseFlowStep.stage);
        break;
      case CourseFlowStep.finalInfo:
        if (state.selectedCategory == 'كورسات') {
          state = state.copyWith(currentStep: CourseFlowStep.category);
        } else {
          state = state.copyWith(currentStep: CourseFlowStep.grade);
        }
        break;
      case CourseFlowStep.country:
        break;
    }
  }
}

final courseFlowProvider = StateNotifierProvider<CourseFlowNotifier, CourseFlowState>((ref) {
  return CourseFlowNotifier();
});
