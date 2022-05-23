
import 'package:flutter/material.dart';

void showSnackBar(String message, context){
  final snackBar = SnackBar(content:Text (message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}