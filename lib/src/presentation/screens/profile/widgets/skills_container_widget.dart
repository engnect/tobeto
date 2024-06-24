import 'package:flutter/material.dart';
import 'package:tobeto/src/models/skill_model.dart';
import 'package:tobeto/src/presentation/screens/profile/profile_details_skills_widget.dart';
import 'package:tobeto/src/presentation/screens/profile/widgets/profile_detail_widget.dart';

class SkillsContainer extends StatelessWidget {
  final List<SkillModel> skillsList;

  const SkillsContainer({
    super.key,
    required this.skillsList,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileDetailCard(
      title: "",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Yetkinliklerim",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Yetkinlikler"),
                        content: SizedBox(
                          width: double.maxFinite,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: skillsList.length,
                            itemBuilder: (context, index) {
                              SkillModel skill = skillsList[index];
                              return SkillsWidget(
                                skill: skill.skillName ?? "",
                              );
                            },
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Kapat'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.visibility_outlined,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ],
          ),
          Divider(
            color: Theme.of(context).colorScheme.onSecondary,
            thickness: 1,
            endIndent: 10,
          ),
          if (skillsList.isEmpty)
            Text(
              'Yetkinlik bilgisi bulunamadı.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: skillsList.length > 4 ? 4 : skillsList.length,
              itemBuilder: (context, index) {
                SkillModel skill = skillsList[index];
                return SkillsWidget(
                  skill: skill.skillName ?? "",
                );
              },
            ),
        ],
      ),
    );
  }
}
