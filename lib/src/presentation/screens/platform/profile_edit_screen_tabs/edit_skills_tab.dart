import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/src/common/utilities/utilities.dart';
import 'package:tobeto/src/domain/repositories/skill_repository.dart';
import 'package:tobeto/src/presentation/screens/platform/widgets/edit_skillls_dialog.dart';
import 'package:uuid/uuid.dart';
import '../../../widgets/tbt_input_field.dart';
import '../../../widgets/tbt_purple_button.dart';
import 'package:tobeto/src/blocs/auth/auth_bloc.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/skill_model.dart';
import 'package:tobeto/src/models/user_model.dart';

class EditSkillsTab extends StatefulWidget {
  const EditSkillsTab({super.key});

  @override
  State<EditSkillsTab> createState() => _EditSkillsTabState();
}

class _EditSkillsTabState extends State<EditSkillsTab> {
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
  bool isEditing = true;

  Future<void> _saveSkill({
    required List<String> selectedSkills,
    required String skillName,
    required BuildContext context,
  }) async {
    UserModel? userModel = await UserRepository().getCurrentUser();

    for (String skillName in selectedSkills) {
      SkillModel skillModel = SkillModel(
        skillId: const Uuid().v1(),
        userId: userModel!.userId,
        skillName: skillName,
      );

      String result = await SkillRepository().addSkill(skillModel);
      if (!context.mounted) return;
      Utilities.showSnackBar(snackBarMessage: result, context: context);
    }

    if (skillName.isNotEmpty) {
      SkillModel skillModel = SkillModel(
        skillId: const Uuid().v1(),
        userId: userModel!.userId,
        skillName: skillName,
      );

      String result = await SkillRepository().addSkill(skillModel);

      if (!context.mounted) return;
      Utilities.showSnackBar(snackBarMessage: result, context: context);
    }
  }

  void _editSkill({
    required SkillModel skill,
    required BuildContext context,
  }) async {
    SkillModel updatedSkill = await showDialog(
      context: context,
      builder: (context) => EditSkillDialog(skill: skill),
    );

    String result = await SkillRepository().updateSkill(updatedSkill);

    if (!context.mounted) return;
    Utilities.showSnackBar(snackBarMessage: result, context: context);
  }

  void _deleteSkill(
      {required SkillModel skill, required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Yeteneği sil",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        content: Text(
          "Bu yeteneği silmek istediğinizden emin misiniz?",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "İptal",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              String result = await SkillRepository().deleteSkill(skill);

              if (!context.mounted) return;
              Utilities.showSnackBar(snackBarMessage: result, context: context);
            },
            child: Text(
              'Sil',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }

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
                  height: 350,
                  duration: const Duration(seconds: 1),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is Authenticated) {
                        UserModel currentUser = state.userModel;

                        return currentUser.skillsList!.isEmpty
                            ? const Center(
                                child: Text("Eklenmiş yetenek bulunamadı!",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              )
                            : ListView.builder(
                                itemCount: currentUser.skillsList!.length,
                                itemBuilder: (context, index) {
                                  SkillModel skill =
                                      currentUser.skillsList![index];
                                  return Card(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    child: ListTile(
                                      title: Text(skill.skillName!),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                            ),
                                            onPressed: () async {
                                              _editSkill(
                                                skill: skill,
                                                context: context,
                                              );
                                              setState(() {});
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                            ),
                                            onPressed: () async {
                                              _deleteSkill(
                                                skill: skill,
                                                context: context,
                                              );
                                              setState(() {});
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
                  hint: Text(
                    'Mevcut yetkinlik Seç',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  items: _availableSkills.map((String skill) {
                    return DropdownMenuItem<String>(
                      value: skill,
                      child: Text(
                        skill,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
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
                    await _saveSkill(
                      selectedSkills: _selectedSkills,
                      skillName: _skillController.text,
                      context: context,
                    );
                    setState(() {
                      _selectedSkills.clear();
                      _skillController.clear();
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}