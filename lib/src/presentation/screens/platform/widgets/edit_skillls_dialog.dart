import 'package:flutter/material.dart';
import 'package:tobeto/src/models/skill_model.dart';

class EditSkillDialog extends StatefulWidget {
  final SkillModel skill;

  const EditSkillDialog({super.key, required this.skill});

  @override
  State<EditSkillDialog> createState() => _EditSkillDialogState();
}

class _EditSkillDialogState extends State<EditSkillDialog> {
  late TextEditingController _editingController;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: widget.skill.skillName);
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Yetenek Düzenle"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _editingController,
            decoration: const InputDecoration(labelText: "Yetenek Adı"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("İptal"),
        ),
        TextButton(
          onPressed: () {
            SkillModel updatedSkill = SkillModel(
              skillId: widget.skill.skillId,
              userId: widget.skill.userId,
              skillName: _editingController.text,
            );
            Navigator.pop(context, updatedSkill);
          },
          child: const Text("Kaydet"),
        ),
      ],
    );
  }
}
