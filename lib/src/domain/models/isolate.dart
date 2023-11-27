class IsolateModel {
  final List<Function> functions;
  final int iteration;

  IsolateModel(this.functions, this.iteration);

  Map<String, dynamic> toJson() {
    return {
      'iteration': iteration,
    };
  }
}