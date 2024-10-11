import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller; // TextEditingController to be passed
  final String title; // Optional: for customizing placeholder
  bool isPassword; // Optional: for password fields
  final bool showIcon;
  String? Function()? validator;

  CustomTextField({
    super.key,
    required this.controller, // The controller is required
    required this.title,
    this.isPassword = false,
    required this.showIcon,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 3.0),
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 16.0, color: Color(0xFF858597,),),
              textAlign: TextAlign.left,
            ),
          ),
          TextFormField(
            obscureText: widget.isPassword,
            controller: widget.controller,
            style: GoogleFonts.abyssinicaSil(
              fontSize: 15,
              color: const Color.fromARGB(
                255,
                93,
                93,
                93,
              ),
            ),
            validator: (value) {
              return widget.validator!();
            },
            decoration: InputDecoration(
              suffixIcon: widget.showIcon
                  ? IconButton(
                      onPressed: () {
                        widget.isPassword = !widget.isPassword;
                        setState(() {});
                      },
                      icon: Icon(
                        widget.isPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    )
                  : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                borderSide: const BorderSide(
                  width: 0.2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                borderSide: const BorderSide(
                  width: 0.2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                borderSide: const BorderSide(
                  width: 0.2,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                borderSide: const BorderSide(
                  width: 0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
