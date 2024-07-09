import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tobeto/l10n/l10n_exntesions.dart';

import '../../../common/export_common.dart';
import '../../widgets/export_widgets.dart';
import 'widgets/widgets.dart';

class ForCompaniesScreen extends StatelessWidget {
  const ForCompaniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const TBTDrawer(),
        endDrawer: const TBTEndDrawer(),
        body: CustomScrollView(
          slivers: [
            const TBTSliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 15),
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 55, 45, 85),
                                Color.fromARGB(255, 151, 86, 159),
                              ],
                            ).createShader(bounds);
                          },
                          child: Text(
                            textAlign: TextAlign.center,
                            context.translate.tobeto_mission,
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Container(
                          decoration: const BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.6),
                                blurRadius: 10,
                              )
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            child: Image.asset(Assets.imagesMainHomePage2),
                          ),
                        ),
                      ),
                      ForCompaniesCard(
                        header: context.translate.reach_right_talent,
                        content: context.translate.ready_candidates,
                        color: const Color.fromARGB(255, 97, 4, 190),
                        cardContentList: [
                          ForCompaniesCardContent(
                            header: context.translate.evaluation_header,
                            content: context.translate.evaluation_content,
                          ),
                          ForCompaniesCardContent(
                            header: context.translate.bootcamp_header,
                            content: context.translate.bootcamp_content,
                          ),
                          ForCompaniesCardContent(
                            header: context.translate.matching_header,
                            content: context.translate.matching_content,
                          ),
                        ],
                      ),
                      ForCompaniesCard(
                        header: context.translate.for_employees_tobeto,
                        content: context.translate.support_existing_skills,
                        color: const Color.fromRGBO(29, 68, 153, 1),
                        cardContentList: [
                          ForCompaniesCardContent(
                            header: context.translate.assessment_tools_header,
                            content: context.translate.assessment_tools_content,
                          ),
                          ForCompaniesCardContent(
                            header: context.translate.training_header,
                            content: context.translate.training_content,
                          ),
                          ForCompaniesCardContent(
                            header: context.translate.development_header,
                            content: context.translate.development_content,
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 15,
                        ),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(45),
                          ),
                          border: const GradientBoxBorder(
                            width: 5, //border kalınlığı
                            gradient: SweepGradient(
                              startAngle: 2.3561944902,
                              endAngle: 5.4977871438,
                              colors: [
                                Colors.transparent,
                                Color.fromRGBO(110, 37, 132, 1),
                                Colors.transparent,
                              ],
                              stops: [0.15, 0.5, 0.88],
                              tileMode: TileMode.mirror,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                context.translate.contact_us_title,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            TBTPurpleButton(
                              width: 150,
                              buttonText: context.translate.contact_us_button,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
