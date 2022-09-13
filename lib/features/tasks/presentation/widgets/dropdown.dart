import 'package:flutter/material.dart';
import 'package:focus_time/core/task/task_importance.dart';
import 'package:focus_time/core/utils/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mirai_dropdown_menu/mirai_dropdown_menu.dart';

class MiraiImportanceDropdownWidget<String> extends StatelessWidget {
  MiraiImportanceDropdownWidget({
    Key? key,
    required this.valueNotifier,
    required this.itemWidgetBuilder,
    required this.children,
    required this.onChanged,
    this.focused = false,
    this.showSeparator = true,
    this.exit = MiraiExit.fromAll,
    this.chevronDownColor,
    this.showMode = MiraiShowMode.bottom,
    this.maxHeight,
    this.showSearchTextField = false,
    this.showOtherAndItsTextField = false,
    this.other,
  }) : super(key: key);

  final ValueNotifier<String> valueNotifier;
  final MiraiDropdownBuilder<String> itemWidgetBuilder;
  final List<String> children;
  final ValueChanged<String> onChanged;
  bool? focused;
  final bool showSeparator;
  final MiraiExit exit;
  final Color? chevronDownColor;
  final MiraiShowMode showMode;
  final double? maxHeight;
  final bool showSearchTextField;
  final bool showOtherAndItsTextField;
  final Widget? other;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 22,
        left: 22,
        bottom: 20,
      ),
      child: MiraiPopupMenu<String>(
        key: UniqueKey(),
        enable: true,
        space: 0,
        showMode: showMode,
        exit: exit,
        showSeparator: showSeparator,
        children: children,
        itemWidgetBuilder: itemWidgetBuilder,
        onChanged: (value) {
          onChanged(value);
        },
        maxHeight: maxHeight,
        showOtherAndItsTextField: showOtherAndItsTextField,
        showSearchTextField: showSearchTextField,
        other: other,
        child: Container(
          key: GlobalKey(),
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(5),
            ),
            border: Border.all(
              width: 2.0,
              color: AppColors.primary,
            ),
          ),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: ValueListenableBuilder<String>(
                  valueListenable: valueNotifier,
                  builder: (_, String chosenTitle, __) {
                    int colorIndex = importanceString.values
                        .toList()
                        .indexOf('$chosenTitle');
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 100),
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              '$chosenTitle',
                              key: ValueKey<String>(chosenTitle),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 20,
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color:
                                  importanceColor.values.toList()[colorIndex],
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              FaIcon(
                FontAwesomeIcons.chevronDown,
                color: chevronDownColor ?? AppColors.primary,
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MiraiImportanceItemWidget extends StatelessWidget {
  const MiraiImportanceItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final String item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 14.0,
            horizontal: 16.0,
          ),
          child: Text(
            importanceString[item]!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          width: 50,
          height: 20,
          margin: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: importanceColor[item],
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ],
    );
  }
}

class MiraiTimeTechnequeDropdownWidget<String> extends StatelessWidget {
  MiraiTimeTechnequeDropdownWidget({
    Key? key,
    required this.valueNotifier,
    required this.itemWidgetBuilder,
    required this.children,
    required this.onChanged,
    this.focused = false,
    this.showSeparator = true,
    this.exit = MiraiExit.fromAll,
    this.chevronDownColor,
    this.showMode = MiraiShowMode.bottom,
    this.maxHeight,
    this.showSearchTextField = false,
    this.showOtherAndItsTextField = false,
    this.other,
  }) : super(key: key);

  final ValueNotifier<String> valueNotifier;
  final MiraiDropdownBuilder<String> itemWidgetBuilder;
  final List<String> children;
  final ValueChanged<String> onChanged;
  bool? focused;
  final bool showSeparator;
  final MiraiExit exit;
  final Color? chevronDownColor;
  final MiraiShowMode showMode;
  final double? maxHeight;
  final bool showSearchTextField;
  final bool showOtherAndItsTextField;
  final Widget? other;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 22,
        left: 22,
        bottom: 20,
      ),
      child: MiraiPopupMenu<String>(
        key: UniqueKey(),
        enable: true,
        space: 0,
        showMode: showMode,
        exit: exit,
        showSeparator: showSeparator,
        children: children,
        itemWidgetBuilder: itemWidgetBuilder,
        onChanged: (value) {
          onChanged(value);
        },
        maxHeight: maxHeight,
        showOtherAndItsTextField: showOtherAndItsTextField,
        showSearchTextField: showSearchTextField,
        other: other,
        child: Container(
          key: GlobalKey(),
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(5),
            ),
            border: Border.all(
              width: 2.0,
              color: AppColors.primary,
            ),
          ),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: ValueListenableBuilder<String>(
                  valueListenable: valueNotifier,
                  builder: (_, String chosenTitle, __) {
                    int? starsCount = int.tryParse(chosenTitle.toString()[0]);
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 100),
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              '$chosenTitle',
                              key: ValueKey<String>(chosenTitle),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          for (int i = 0; i < starsCount! / 2; i++) ...[
                            Container(
                              margin: EdgeInsets.only(right: (i + 1) * 22),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Icon(Icons.star),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
              FaIcon(
                FontAwesomeIcons.chevronDown,
                color: chevronDownColor ?? AppColors.primary,
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MiraiTimeTechniqueItemWidget extends StatelessWidget {
  const MiraiTimeTechniqueItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final String item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 14.0,
        horizontal: 16.0,
      ),
      child: Text(
        timeTechnique[item]!,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }
}
