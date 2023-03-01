abstract class Demo {
  int? storedNullableValue;

  /// If [storedNullableValue] is currently `null`,
  /// set it to the result of [calculateValue]
  /// or `0` if [calculateValue] returns `null`.
  void updateStoredValue() {
    storedNullableValue ??= calculateValue() ?? 0;
  }

  /// Calculates a value to be used,
  /// potentially `null`.
  int? calculateValue();
}

class DemoImpl extends Demo {
  @override
  int? calculateValue() => null;
}

int? getLength(String? str) {
  return str?.length ?? 0;
}

int? getLength1({String? str}) {
  return str?.length ?? 0;
}

int? getLength2(String? str) {
  if (str == null) throw Exception('str is null.');
  return str?.length;
}

class Meal {
  late String _description;

  // late final String _description;

  set description(String desc) {
    _description = 'Meal description: $desc';
  }

  String get description => _description;
}

void main() {
  final demoImpl = DemoImpl();
  print('storedNullableValue ： ${demoImpl.storedNullableValue}');

  String text = '';

  // if (DateTime.now().hour < 12) {
  //  text = "It's morning! Let's make aloo paratha!";
  // } else {
  //  text = "It's afternoon! Let's make biryani!";
  // }

  print(text);
  print(text.length);

  print('getLength：${getLength(null)}');
  print('getLength1(): ${getLength1()}');
  try {
    print('getLength2(): ${getLength2(null)}');
  } on Exception catch (e) {
    print('exception: ${e.toString()}');
  }

  final myMeal = Meal();
  myMeal.description = 'test!';
  myMeal.description = 'ttttt';
  print(myMeal.description);

}
