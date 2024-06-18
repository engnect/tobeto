import 'package:flutter/material.dart';
import 'package:tobeto/src/presentation/widgets/input_field.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';
import 'package:tobeto/src/presentation/widgets/tbt_animated_container.dart';
import 'package:tobeto/src/presentation/widgets/tbt_app_bar_widget.dart';

enum UserRole { admin, instructor, istanbulkodluyor }

class ApplicationsTab extends StatefulWidget {
  const ApplicationsTab({super.key});

  @override
  State<ApplicationsTab> createState() => _ApplicationsTabState();
}

class _ApplicationsTabState extends State<ApplicationsTab> {
  final ScrollController _controller = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey _globalKey = GlobalKey();
  double _containerWidth = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Bu metod, widget ağacı oluşturulduktan sonra çağrılır.
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
  void dispose() {
    super.dispose();
    _controller.dispose();
    _textEditingController.dispose();
  }

  UserRole _selectedRole = UserRole.admin;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TBTAppBar(controller: _controller),
        body: SingleChildScrollView(
          controller: _controller,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              children: [
                TBTAnimatedContainer(
                  height: 450,
                  infoText: 'Yeni Başvuru Yap!',
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20, top: 10),
                            child: Text(
                              "Başvuru Türünü Seçiniz",
                              style: TextStyle(fontFamily: "Poppins"),
                            ),
                          ),
                          RadioListTile<UserRole>(
                            toggleable: true,
                            title: const Text('Admin'),
                            value: UserRole.admin,
                            groupValue: _selectedRole,
                            onChanged: (value) {
                              setState(() {
                                _selectedRole = value!;
                              });
                            },
                          ),
                          RadioListTile<UserRole>(
                            toggleable: true,
                            title: const Text('Egitmen'),
                            value: UserRole.instructor,
                            groupValue: _selectedRole,
                            onChanged: (value) {
                              setState(() {
                                _selectedRole = value!;
                              });
                            },
                          ),
                          RadioListTile<UserRole>(
                            toggleable: true,
                            title: const Text('İstanbul Kodluyor'),
                            value: UserRole.istanbulkodluyor,
                            groupValue: _selectedRole,
                            onChanged: (value) {
                              setState(() {
                                _selectedRole = value!;
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TBTInputField(
                              minLines: 3,
                              hintText: 'Başvuru Açıklaması Giriniz',
                              controller: _textEditingController,
                              onSaved: (p0) {},
                              keyboardType: TextInputType.multiline,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TBTPurpleButton(
                              buttonText: "Başvur",
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Stack(
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
                                  child: const Text(
                                    "Başvuru Başlığıaaaaa",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: _containerWidth * 0.70,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  child: Text(
                                    "Başvuru içeriği asdasaaaaaaaaaaa\n saaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
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
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 7, 107, 52),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            topLeft: Radius.circular(25),
                          ),
                        ),
                        child: const Text(
                          "Kabul Edildi",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 200, //Test için olusturuldu silinecek!!!
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
