import 'package:flutter/material.dart';

class TBTInputField extends StatefulWidget {
  final String hintText;
  final bool? isObscure;
  final TextEditingController controller;
  final Function(String?) onSaved;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final int? maxLines;
  final int? minLines;
  final EdgeInsets? padding;
  final bool isGithubField;

  const TBTInputField(
      {super.key,
      required this.hintText,
      this.isObscure,
      required this.controller,
      required this.onSaved,
      required this.keyboardType,
      this.readOnly,
      this.maxLines,
      this.minLines,
      this.isGithubField = false,
      this.padding});

  @override
  State<TBTInputField> createState() => _TBTInputFieldState();
}

class _TBTInputFieldState extends State<TBTInputField> {
  bool showPassword = false;
  String? errorText;

  @override
  void initState() {
    super.initState();
    if (widget.isGithubField) {
      widget.controller.addListener(validateGithubUrl);
    }
  }

  @override
  void dispose() {
    if (widget.isGithubField) {
      widget.controller.removeListener(validateGithubUrl);
    }
    super.dispose();
  }

  void validateGithubUrl() {
    String? text = widget.controller.text.trim();
    
    String a =
        r"^(http(s)?:\/\/)?(www\.)?github\.com\/[a-zA-Z0-9\-_]+(\/[a-zA-Z0-9\-_]+)?\/?$";
    RegExp regex = RegExp(a);

    setState(() {
      if (text.isEmpty || regex.hasMatch(text)) {
        errorText = null; 
      } else {
        errorText = "Geçersiz Github adresi"; 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        readOnly: widget.readOnly ?? false,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        decoration: InputDecoration(
          errorText: widget.isGithubField ? errorText : null,
          suffixIcon: widget.isObscure == null
              ? null
              : showPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: const Icon(
                        Icons.visibility_off_outlined,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: const Icon(
                        Icons.visibility_outlined,
                      ),
                    ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              fontFamily: "Poppins",
              color: Theme.of(context).colorScheme.onSecondary),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(138, 138, 138, 0.4),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: Color.fromRGBO(153, 51, 255, 0.4),
              width: 4,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(112, 112, 112, 0.459),
            ),
          ),
        ),
        autocorrect: false,
        obscureText: widget.isObscure != null ? !showPassword : showPassword,

          onChanged: (value) {
        if (widget.isGithubField) {
          validateGithubUrl();
        }
      },
        // onSaved: onSaved,
      ),
    );
  }
}
