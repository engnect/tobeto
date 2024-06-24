import 'package:flutter/material.dart';

class SectionContainer extends StatelessWidget {
  final String title;
  final List? itemList;
  final Widget? emptyWidget;
  final Widget Function(BuildContext context, int index) itemBuilder;

  const SectionContainer({
    Key? key,
    required this.title,
    this.itemList,
    this.emptyWidget,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Divider(
            color: Theme.of(context).colorScheme.onSecondary,
            thickness: 1,
            endIndent: 10,
          ),
          if (itemList == null)
            const Center(child: CircularProgressIndicator())
          else if (itemList!.isEmpty)
            emptyWidget ??
                Text(
                  "Veri bulunamadı.",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: itemList!.length,
              itemBuilder: itemBuilder,
            ),
        ],
      ),
    );
  }
}
