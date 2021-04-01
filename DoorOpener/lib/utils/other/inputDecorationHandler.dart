import 'package:flutter/material.dart';
import 'package:raspberry_pi_door_opener/frontend/constants.dart';
import 'package:raspberry_pi_door_opener/utils/localizations/app_localizations.dart';

InputDecoration inputDecorationHandler(BuildContext context, String labelText, String hintText) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        20,
      ),
      borderSide: BorderSide(
          color:
          kDarkDefaultColor.withOpacity(.9),
          style: BorderStyle.solid),
    ),
    focusColor: kDarkDefaultColor,
    fillColor: kDarkDefaultColor,
    labelStyle: Theme.of(context)
        .textTheme
        .bodyText1
        .copyWith(
      color: Colors.white.withOpacity(.87),
    ),
    labelText: AppLocalizations.of(context)
        .translate(
        labelText,
    ),
    hintStyle: Theme.of(context)
        .textTheme
        .bodyText1
        .copyWith(
      color: Colors.white.withOpacity(.55),
    ),
    hintText: AppLocalizations.of(context)
        .translate(
        hintText),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );
}