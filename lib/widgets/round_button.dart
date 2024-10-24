import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {super.key,
      required this.title,
      required this.ontap,
      this.loading = false});
  final String title;
  final VoidCallback ontap;
  final bool loading;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: loading
              ? CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white60,
                  strokeAlign: BorderSide.strokeAlignCenter,
                )
              : Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ),
        ),
      ),
    );
  }
}
