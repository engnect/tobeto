import 'package:flutter/material.dart';
import 'package:tobeto/src/common/constants/assets.dart';

class SectorForPersonCard extends StatelessWidget {
  const SectorForPersonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topLeft,
          fit: BoxFit.cover,
          image: AssetImage(Assets.bg1),
        ),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Text(
              textAlign: TextAlign.center,
              "Kariyeriniz için\nen iyi\nyolculuklar",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontSize: 46,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 175,
                  width: 175,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage(Assets.digital),
                    ),
                  ),
                ),
                Container(
                  height: 175,
                  width: 175,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage(Assets.yazilimKalite),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 175,
                  width: 175,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage(Assets.ai),
                    ),
                  ),
                ),
                Container(
                  height: 175,
                  width: 175,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage(Assets.proje),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 175,
                  width: 175,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage(Assets.fullstack),
                    ),
                  ),
                ),
                Container(
                  height: 175,
                  width: 175,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage(Assets.analiz),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
