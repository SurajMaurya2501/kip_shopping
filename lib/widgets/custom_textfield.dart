import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller; // TextEditingController to be passed
  final String title; // Optional: for customizing placeholder
  bool isPassword; // Optional: for password fields
  final bool showIcon;

  CustomTextField(
      {super.key,
      required this.controller, // The controller is required
      required this.title,
      this.isPassword = false,
      required this.showIcon});

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
              style: const TextStyle(fontSize: 16.0, color: Color(0xFF858597)),
              textAlign: TextAlign.left,
            ),
          ),
          TextFormField(
            obscureText: widget.isPassword,
            controller: widget.controller,
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
            ),
          ),
        ],
      ),
    );
  }
}
