import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/common/enums/application_status_enum.dart';
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
            decoration: BoxDecoration(
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.4),
                  blurRadius: 5,
                ),
              ],
              border: const Border(
                left: BorderSide(
                  color: Color.fromARGB(255, 7, 107, 52),
                  width: 10,
                ),
              ),
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.all(
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
                    child: Center(
                      child: widget.applicationModel.applicationType ==
                              ApplicationType.admin
                          ? Icon(
                              Icons.admin_panel_settings_outlined,
                              size: 55,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          : widget.applicationModel.applicationType ==
                                  ApplicationType.instructor
                              ? Icon(
                                  Icons.menu_book_outlined,
                                  size: 55,
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              : Image.asset(
                                  Assets.imagesIkLogo,
                                  fit: BoxFit.contain,
                                ),
                    ),
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
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary,
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
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        DateFormat('dd/MM/yyyy').format(
                            widget.applicationModel.applicationCreatedAt),
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.primary,
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
                color: widget.applicationModel.applicationStatus ==
                        ApplicationStatus.approved
                    ? const Color.fromARGB(255, 7, 107, 52)
                    : widget.applicationModel.applicationStatus ==
                            ApplicationStatus.denied
                        ? Colors.red
                        : Colors.amber,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
              ),
              child: Text(
                widget.applicationModel.applicationStatus ==
                        ApplicationStatus.approved
                    ? 'Onaylandı!'
                    : widget.applicationModel.applicationStatus ==
                            ApplicationStatus.denied
                        ? 'Reddedildi'
                        : 'Beklemede',
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
