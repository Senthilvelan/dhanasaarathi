import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInput extends StatelessWidget {
  final int length;
  final Function(String) onChanged;

  const OtpInput({
    Key? key,
    required this.length,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(length),
          FilteringTextInputFormatter.digitsOnly,
        ],
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 0, // Hide the actual text
          letterSpacing: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          filled: false,
          counterText: '',
        ),
        onChanged: onChanged,
      ),
    );
  }
}