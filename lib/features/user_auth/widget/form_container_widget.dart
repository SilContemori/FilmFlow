import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormContainerWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fielKey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;

  const FormContainerWidget({
    super.key,
    this.controller,
    this.fielKey,
    this.isPasswordField,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.inputType,
  });

  @override
  State<FormContainerWidget> createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.35),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.white,
          width: 1.5,
        ),
      ),
      child: TextFormField(
        style: GoogleFonts.ebGaramond(color: Colors.white, fontSize: 12),
        controller: widget.controller,
        keyboardType: widget.inputType,
        key: widget.fielKey,
        obscureText: widget.isPasswordField == true ? obscureText : false,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          border:
              UnderlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.white),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            child: widget.isPasswordField == true
                ? Icon(
                    obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: obscureText == false ? Colors.white : Colors.grey,
                  )
                : Text(""),
          ),
        ),
      ),
    );
  }
}
