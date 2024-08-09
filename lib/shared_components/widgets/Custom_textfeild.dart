import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomTextField extends StatefulWidget {
  final String labeltext;
  final String? errorText;
  final bool obscuretext;
  final bool isPassword;
  final TextInputType? keytype;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  CustomTextField({
    Key? key,
    required this.labeltext,
    this.obscuretext = true,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.errorText,
    this.keytype,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscuretext;

  @override
  void initState() {
    super.initState();
    _obscuretext = widget.obscuretext;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keytype,
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return ("Please enter ${widget.labeltext}");
        }
        return null;
      },
      obscureText: widget.isPassword ? _obscuretext : false,
      decoration: InputDecoration(
        labelText: widget.labeltext,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: primaryColors)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: primaryColors),
        ),
        fillColor: Colors.white,
        filled: true,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscuretext ? Icons.visibility_off : Icons.visibility,
                  color: primaryColors,
                ),
                onPressed: () {
                  setState(() {
                    _obscuretext = !_obscuretext;
                  });
                },
              )
            : null,
        errorText: widget.errorText,
      ),
    );
  }
}
