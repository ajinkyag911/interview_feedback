import 'package:flutter/material.dart';

class RatingFeedbackCard extends StatelessWidget {
  const RatingFeedbackCard({Key key, this.title, this.emoji, this.description})
      : super(key: key);
  final String title;
  final String emoji;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
      decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xff0d36cc),
          ),
          color: Color(0xff0d36cc),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            emoji,
            style: TextStyle(fontSize: 44, color: Colors.white),
          ),
          SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                description,
                style: TextStyle(fontSize: 16, color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textDirection: TextDirection.ltr,
                // textAlign: TextAlign.justify,
              ),
            ],
          ),
          Expanded(
            child: TextButton(
              child: Text('CHANGE',
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
