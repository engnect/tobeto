import 'package:flutter/material.dart';
import 'package:tobeto/src/common/enums/application_type_enum.dart';

import 'package:tobeto/src/models/application_model.dart';

class ApplicationCard extends StatefulWidget {
  final ApplicationModel applicationModel;
  const ApplicationCard({
    super.key,
    required this.applicationModel,
  });

  @override
  State<ApplicationCard> createState() => _ApplicationCardState();
}

class _ApplicationCardState extends State<ApplicationCard> {
  final GlobalKey _globalKey = GlobalKey();
  double _containerWidth = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getContainerSize();
    });
  }

  void _getContainerSize() {
    final RenderBox renderBox =
        _globalKey.currentContext!.findRenderObject() as RenderBox;
    setState(() {
      _containerWidth = renderBox.size.width;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        key: _globalKey,
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.4),
                  blurRadius: 5,
                ),
              ],
              border: Border(
                left: BorderSide(
                  color: Color.fromARGB(255, 7, 107, 52),
                  width: 10,
                ),
              ),
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            height: 125,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: _containerWidth * 0.2,
                    height: _containerWidth * 0.2,
                    child: const Placeholder(),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: _containerWidth * 0.4,
                        child: Text(
                          widget.applicationModel.applicationType
                              .toNameCapitalize(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: _containerWidth * 0.70,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        child: Text(
                          widget.applicationModel.applicationContent,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: -10,
            top: 10,
            child: Container(
              margin: const EdgeInsets.only(right: 4),
              padding: const EdgeInsets.only(
                left: 12,
                right: 25,
                bottom: 2,
                top: 2,
              ),
              decoration: BoxDecoration(
                color: widget.applicationModel.didApplicationApproved == false
                    ? Colors.grey
                    : const Color.fromARGB(255, 7, 107, 52),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
              ),
              child: Text(
                widget.applicationModel.didApplicationApproved == false
                    ? 'Beklemede'
                    : "Kabul Edildi",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: "Poppins",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
