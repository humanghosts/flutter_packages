dynamic doWhen(bool condition, Function whenFunction) {
  if (condition) return whenFunction();
}

dynamic doWhenElse(bool condition, Function whenFunction, Function elseFunction) {
  return condition ? whenFunction() : elseFunction();
}
