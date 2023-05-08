import 'package:flutter/material.dart';

class Validators {
  static FormFieldValidator<String> password(int min, int max, String message) {
    return (String? v) {
      if (v?.isEmpty ?? true) return null;
      if ((v?.length ?? 0) < min) return message;
      if ((v?.length ?? 0) > max) return message;
      return null;
    };
  }
}
