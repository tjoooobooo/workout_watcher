import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DataSelectionItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;

  const DataSelectionItem({
    Key? key,
    required this.icon,
    this.isSelected = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.15,
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.white : Theme.of(context).colorScheme.primary,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        padding: const EdgeInsets.all(5),
        child: Center(
          child: FaIcon(
            icon,
            color: isSelected ? Colors.white : Theme.of(context).colorScheme.primary,
            size: 35,
          ),
        ),
      ),
    );
  }
}