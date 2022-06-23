String? intBetweenValidator(String? value, int min, int max, [String? givenMsg]) {
  if (value != null && value.isNotEmpty) {
    int intVal = int.parse(value);
    if (intVal < min || intVal > max) {
      return givenMsg ?? "Bist du sicher?";
    }

    return null;
  } else {
    return "";
  }
}

String? doubleBetweenValidator(String? value, double min, double max, [String? givenMsg]) {
  if (value != null && value.isNotEmpty) {
    double doubleVal = double.parse(value);
    if (doubleVal < min || doubleVal > max) {
      return givenMsg ?? "Bist du sicher?";
    }

    return null;
  } else {
    return "";
  }
}

String? notEmptyValidator(String? value, [String? givenMsg]) {
  if (value == null || value.isEmpty) {
    return "";
  } else {
    return null;
  }
}
