class IsolateModel {
  final List<Function> functions;
  final List<Map<String, dynamic>>? arguments;
  final int iteration;

  IsolateModel(this.functions, this.arguments, this.iteration);

  Map<String, dynamic> toJson() {
    return {
      'arguments': arguments,
      'iteration': iteration,
    };
  }
}