import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/screens/students_page/students_edit.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/screens/students_page/students_fake_data.dart';
import 'package:tobeto/src/presentation/screens/endDrawer/screens/students_page/students_model.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  final List<StudentsModel> _allNames = studentsFakeData;
  // ignore: unused_field
  String _searchQuery = '';
  List<StudentsModel> _filteredNames = [];

  @override
  void initState() {
    super.initState();
    _filteredNames = _allNames;
  }

  void _filterNames(String query) {
    final filteredNames = _allNames.where((person) {
      final firstNameLower = person.name.toLowerCase();
      final lastNameLower = person.surname.toLowerCase();
      final queryLower = query.toLowerCase();

      return firstNameLower.contains(queryLower) ||
          lastNameLower.contains(queryLower);
    }).toList();

    setState(() {
      _searchQuery = query;
      _filteredNames = filteredNames;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Öğrenciler'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: _filterNames,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredNames.length,
              itemBuilder: (context, index) {
                final person = _filteredNames[index];
                return Slidable(
                  key: ValueKey(index),
                  endActionPane: ActionPane(
                    extentRatio: 0.6,
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          if (kDebugMode) {
                            print("Sile tıklandı");
                          }
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Sil',
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          if (kDebugMode) {
                            print("Düzenleye tıklandı");
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const StudentsEdit(),
                          ));
                        },
                        backgroundColor: const Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Düzenle',
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 2,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(Assets
                              .imagesDefaultAvatar), //Firebase modeli ile güncellenicek!
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: SizedBox(
                            width: 250,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    "${person.name} ${person.surname}",
                                    style: const TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    textAlign: TextAlign.left,
                                    person.classname,
                                    softWrap: true,
                                    style: const TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        color:
                                            Color.fromRGBO(135, 135, 135, 1)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
