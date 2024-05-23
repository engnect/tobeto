import 'package:flutter/material.dart';
import '../constants/assets.dart';

class TbtDrawer extends StatelessWidget {
  const TbtDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.70, //Açılan ekranın genişliğini  ayarlamak için
      child: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          children: [
            SizedBox(
              height: 75,
              child: DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      Assets.imagesTobetoLogo,
                      width: 150,
                    ),
                    GestureDetector(
                      child: const Icon(Icons.close),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Biz Kimiz?"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Neler Sunuyoruz?"),
              onTap: () {},
            ),
            ListTile(
              title: const Text("Eğitimlerimiz"),
              onTap: () {},
            ),
            ListTile(
              title: const Text("Tobeto'da Neler Oluyor?"),
              onTap: () {},
            ),
            ListTile(
              title: const Text("İletişim"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
