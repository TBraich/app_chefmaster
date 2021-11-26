class RecipeStep {
  final int step;
  final String description;

  RecipeStep({this.step, this.description});

  factory RecipeStep.fromJson(Map<String, dynamic> json) {
    return RecipeStep(
      step: json["step"],
      description: json["stepDescription"],
    );
  }

  Map<String, dynamic> toJson() =>
      {'step': step, 'stepDescription': description};
}