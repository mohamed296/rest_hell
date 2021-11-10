import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget defoletTextForm({
  required context,
  required TextEditingController controller,
  required String? Function(String?)? validat,
  required TextInputType type,
  Function()? onTap,
  Function(String)? oFS,
  bool isShow = false,
  required String label,
  required IconData pIcon,
  IconData? sIcon,
  Function()? sOnTap,
  bool isClickable = true,
  String? hint,
}) {
  return TextFormField(
    controller: controller,
    validator: validat,
    onTap: onTap,
    enabled: isClickable,
    onFieldSubmitted: oFS,
    obscureText: isShow,
    keyboardType: type,
    style: TextStyle(color: Colors.green[900]),
    decoration: InputDecoration(
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
          borderSide:
              BorderSide(color: Colors.black.withOpacity(0.2), width: 3.0)),
      enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
          borderSide:
              BorderSide(color: Colors.black.withOpacity(0.2), width: 3.0)),
      fillColor: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
      filled: true,
      label: Text(label),
      labelStyle: TextStyle(color: Colors.green[900]),
      hintText: hint,
      prefixIcon: Icon(
        pIcon,
        color: Colors.green[900],
      ),
      suffixIcon: IconButton(
        onPressed: sOnTap,
        icon: Icon(
          sIcon,
          color: Colors.green[900],
        ),
      ),
    ),
  );
}

Widget defoltElvationBottom({
  required Function()? onTap,
  required String text,
}) {
  return ElevatedButton(
    onPressed: onTap,
    child: Text(text),
  );
}

Widget defoltTextBottom({
  required Function()? onTap,
  required String text,
}) {
  return TextButton(
    onPressed: onTap,
    child: Text(
      text,
      style: TextStyle(color: Colors.green[400]),
    ),
  );
}

void navigateaAndFinsh(context, Widget widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => widget),
      (route) => false);
}

void navigateTo(context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => widget,
    ),
  );
}

void showSnakBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.all(30.0),
      content: Text(message, style: const TextStyle(color: Colors.white)),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red[900],
    ),
  );
}
