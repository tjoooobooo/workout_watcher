import 'package:flutter/material.dart';

class SectionHeaderContainer extends StatelessWidget {
  final String header;
  final IconData? iconData;

  const SectionHeaderContainer({Key? key, required this.header, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.925,
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0, bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(header,
              textAlign: TextAlign.start,
              style:
                  const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          Icon(
            iconData,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
