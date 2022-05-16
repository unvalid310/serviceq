import 'package:flutter/material.dart';
import 'package:serviceq/data/model/response/language_model.dart';
import 'package:serviceq/utill/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext context}) {
    return AppConstants.languages;
  }
}
