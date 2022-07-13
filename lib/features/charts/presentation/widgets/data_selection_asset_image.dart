import 'package:flutter/material.dart';

class DataSelectionAssetImage extends StatelessWidget {
  final String name;
  final bool isSelected;

  const DataSelectionAssetImage({Key? key, required this.name, this.isSelected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.white : Theme.of(context).colorScheme.primary,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        padding: const EdgeInsets.all(5),
        child: Image.asset(
          "assets/" + name + ".png",
          color: isSelected ? Colors.white : Theme.of(context).colorScheme.primary,
          height: 35,
          width: 35,
        ),
      ),
    );
  }
}