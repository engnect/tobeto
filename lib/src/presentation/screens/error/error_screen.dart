import 'package:flutter/material.dart';
import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/common/router/app_route_names.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(Assets.imageError),
              const Text(
                'Oops!..',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                  fontSize: 25,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRouteNames.homeRoute);
                },
                child: const Text(
                  "Ana Sayfa",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
