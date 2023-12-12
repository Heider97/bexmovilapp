class IsolateModel {
  final List<Function> functions;
  final List<String>? arguments;
  final int iteration;

  IsolateModel(this.functions, this.arguments, this.iteration);

  Map<String, dynamic> toJson() {
    return {
      'arguments': arguments,
      'iteration': iteration,
    };
  }
}