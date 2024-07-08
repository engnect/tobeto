import 'package:flutter/material.dart';
import 'dart:math';

import 'package:tobeto/src/presentation/widgets/export_widgets.dart';

class CaptchaVerification extends StatefulWidget {
  const CaptchaVerification({super.key, required this.onVerified});
  final ValueChanged<bool> onVerified;
  @override
  State<CaptchaVerification> createState() => _CaptchaVerificationState();
}

class _CaptchaVerificationState extends State<CaptchaVerification> {
  String randomString = "";
  bool isVerified = false;
  TextEditingController controller = TextEditingController();

  // Logic for creating Captcha
  void buildCaptcha() {
    const letters =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    const length = 6;
    final random = Random();
    randomString = String.fromCharCodes(
      List.generate(
        length,
        (index) => letters.codeUnitAt(
          random.nextInt(letters.length),
        ),
      ),
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    buildCaptcha();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        border: Border.all(
            width: 1, color: Theme.of(context).colorScheme.secondary),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                randomString,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(60, 60, 60, 1),
                ),
              ),
              IconButton(
                onPressed: () {
                  buildCaptcha();
                  isVerified = false;
                  widget.onVerified(false);
                },
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          TextField(
            style: const TextStyle(
              color: Color.fromRGBO(60, 60, 60, 1),
            ),
            maxLength: 6,
            onChanged: (value) {
              setState(() {
                isVerified = false;
                widget.onVerified(false);
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(153, 51, 255, 0.4), width: 4.0),
              ),
              hintText: "Doğrulama kodunu girin",
              labelText: "Doğrulama kodunu girin",
              labelStyle: TextStyle(color: Color.fromRGBO(60, 60, 60, 1)),
            ),
            controller: controller,
          ),
          TBTPurpleButton(
            buttonText: "Kontrol et",
            onPressed: () {
              setState(() {
                isVerified = controller.text == randomString;
                widget.onVerified(isVerified);
              });
            },
          ),
          if (isVerified)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.verified),
                Text(
                  "Onaylandı",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                )
              ],
            )
          else
            const Text(
              "Lütfen gördüğünüz değeri doğru girin.",
              style: TextStyle(color: Color.fromRGBO(60, 60, 60, 1)),
            ),
        ],
      ),
    );
  }
}
