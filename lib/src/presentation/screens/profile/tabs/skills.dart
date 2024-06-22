import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/src/domain/repositories/skill_repository.dart';
import 'package:tobeto/src/presentation/screens/profile/widgets/edit_skillls_dialog.dart';
import 'package:uuid/uuid.dart';
import '../../../widgets/input_field.dart';
import '../../../widgets/purple_button.dart';
import 'package:tobeto/src/blocs/auth/auth_bloc.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/skill_model.dart';
import 'package:tobeto/src/models/user_model.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  final TextEditingController _skillController = TextEditingController();
  final List<String> _selectedSkills = [];
  final List<String> _availableSkills = [
    'Flutter',
    'Dart',
    'Firebase',
    'Node.js',
    'React',
    'Python',
  ];

  bool isEditing = false;

  @override
  void dispose() {
    _skillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TBTPurpleButton(
                buttonText: "Düzenle",
                onPressed: () {
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
              ),
              if (isEditing) ...[
                AnimatedContainer(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    border: Border(
                      bottom: BorderSide(
                        width: 7,
                        color: Color.fromARGB(255, 153, 51, 255),
                      ),
                    ),
                  ),
                  height: 400,
                  duration: const Duration(seconds: 1),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is Authenticated) {
                        UserModel currentUser = state.userModel;

                        return ListView.builder(
                          itemCount: currentUser.skillsList!.length,
                          itemBuilder: (context, index) {
                            SkillModel skill = currentUser.skillsList![index];
                            return Card(
                              child: ListTile(
                                title: Text(skill.skillName!),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () async {
                                        SkillModel updatedSkill =
                                            await showDialog(
                                          context: context,
                                          builder: (context) =>
                                              EditSkillDialog(skill:skill),
                                        );

                                        if (updatedSkill != null) {
                                          String result =
                                              await SkillRepository()
                                                  .updateSkill(updatedSkill);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(content: Text(result)),
                                          );
                                          setState(() {});
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text("Yeteneği sil"),
                                            content: const Text(
                                                "Bu yeteneği silmek istediğinizden emin misiniz?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text("İptal"),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  String result =
                                                      await SkillRepository()
                                                          .deleteSkill(skill);

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(result)),
                                                  );

                                                  setState(() {});
                                                },
                                                child: const Text('Sil'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 8,
                  children: _selectedSkills
                      .map(
                        (skill) => Chip(
                          label: Text(skill),
                          onDeleted: () {
                            setState(() {
                              _selectedSkills.remove(skill);
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: DropdownButtonFormField<String>(
                  value: null,
                  hint: const Text('Mevcut yetkinlik Seç',),
                  items: _availableSkills.map((String skill) {
                    return DropdownMenuItem<String>(
                      value: skill,
                      child: Text(skill),
                    );
                  }).toList(),
                  onChanged: (selectedSkill) {
                    if (selectedSkill != null) {
                      setState(() {
                        _selectedSkills.add(selectedSkill);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TBTInputField(
                  hintText: "Yetenek Adı",
                  controller: _skillController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TBTPurpleButton(
                  buttonText: 'Kaydet',
                  onPressed: () async {
                    UserModel? userModel =
                        await UserRepository().getCurrentUser();

                    for (String skillName in _selectedSkills) {
                      SkillModel skillModel = SkillModel(
                        skillId: const Uuid().v1(),
                        userId: userModel!.userId,
                        skillName: skillName,
                      );

                      String result =
                          await SkillRepository().addSkill(skillModel);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(result)),
                      );
                    }

                    if (_skillController.text.isNotEmpty) {
                      SkillModel skillModel = SkillModel(
                        skillId: const Uuid().v1(),
                        userId: userModel!.userId,
                        skillName: _skillController.text,
                      );

                      String result =
                          await SkillRepository().addSkill(skillModel);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(result)),
                      );
                    }

                    setState(() {
                      _selectedSkills.clear();
                      _skillController.clear();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



//   Widget _buildEditSkillDialog(SkillModel skill) {
//     TextEditingController editingController =
//         TextEditingController(text: skill.skillName);
//     return AlertDialog(
//       title: const Text("Yetenek Düzenle"),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             controller: editingController,
//             decoration: const InputDecoration(labelText: "Yetenek Adı"),
//           ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text("İptal"),
//         ),
//         TextButton(
//           onPressed: () {
//             SkillModel updatedSkill = SkillModel(
//               skillId: skill.skillId,
//               userId: skill.userId,
//               skillName: editingController.text,
//             );
//             Navigator.pop(context, updatedSkill);
//           },
//           child: const Text("Kaydet"),
//         ),
//       ],
//     );
//   }
// }
}