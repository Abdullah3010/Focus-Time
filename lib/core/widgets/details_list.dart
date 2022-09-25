import 'package:flutter/material.dart';
import 'package:focus_time/core/models/details_list_item.dart';
import 'package:focus_time/core/utils/app_colors.dart';

class DetailsList extends StatelessWidget {
  final List<DetailsListItem> items;

  const DetailsList({super.key, required this.items});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(22),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 7,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < items.length; i++)
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(i == 0 ? 5 : 0),
                topRight: const Radius.circular(20),
                bottomLeft: const Radius.circular(20),
                bottomRight: Radius.circular(i == items.length - 1 ? 5 : 0),
              ),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {
                  if (items[i].onTap == null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => items[i].route!,
                      ),
                    );
                  } else {
                    items[i].onTap!();
                  }
                },
                splashColor: AppColors.primary.withOpacity(0.2),
                highlightColor: Colors.grey.withOpacity(0.1),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              items[i].icon,
                              color: AppColors.accent,
                              size: 28,
                            ),
                          ),
                          Text(
                            items[i].title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.black26,
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                    if (i != items.length - 1)
                      const Divider(
                        height: 1,
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
