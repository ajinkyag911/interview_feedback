import 'package:flutter/material.dart';

class RatingCard extends StatelessWidget {
  const RatingCard(
      {Key key,
      this.borderColor,
      this.title,
      this.emoji,
      this.description,
      this.index,
      this.onTap,
      this.selection})
      : super(key: key);
  final Color borderColor;
  final String title;
  final String emoji;
  final String description;
  final int index;
  final Function(int) onTap;
  final List<bool> selection;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 200,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(
              color: selection[index] == true ? Color(0xff0d36cc) : borderColor,
            ),
            color:
                selection[index] == true ? Color(0xff0d36cc) : Colors.white60,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            Text(
              emoji,
              style: TextStyle(
                fontSize: 44,
                color: selection[index] == true ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: selection[index] == true ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: selection[index] == true ? Colors.white : Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.ltr,
              // textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
      onTap: () {
        onTap(index);
      },
    );
  }
}
