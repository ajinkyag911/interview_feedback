import 'package:flutter/material.dart';
import 'package:interview_feedback/features/interviewers/presentation/widgets/floating_button.dart';
import 'package:interview_feedback/features/interviewers/presentation/widgets/rating_card.dart';
import 'package:provider/provider.dart';

import 'feedback_page.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({Key key}) : super(key: key);

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  List<bool> _selection = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    List<RatingCard> ratingCards = [
      RatingCard(
        borderColor: Colors.blue,
        title: 'Awesome',
        description: 'Best interviewer ever!',
        emoji: '\u{1F44F}',
        index: 0,
        onTap: _changeSelection,
        selection: _selection,
      ),
      RatingCard(
        borderColor: Colors.redAccent,
        title: 'Good',
        description: 'Nice person. Really Nice!',
        emoji: '\u{1F44D}',
        index: 1,
        onTap: _changeSelection,
        selection: _selection,
      ),
      RatingCard(
        borderColor: Colors.lightGreen,
        title: 'Neutral',
        description: 'Umm.. okay I guess!',
        emoji: '\u{1F610}',
        index: 2,
        onTap: _changeSelection,
        selection: _selection,
      ),
      RatingCard(
        borderColor: Colors.purpleAccent,
        title: 'Bad',
        description: 'Needs to improve! A LOT!',
        emoji: '\u{2639}',
        index: 3,
        onTap: _changeSelection,
        selection: _selection,
      )
    ];

    return Scaffold(
      floatingActionButton: FloatingButton(
        icon: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
        ),
        text: 'NEXT',
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Provider.value(
              value: ratingCards[_selection.indexOf(true)],
              child: FeedbackPage(),
            );
          }));
        },
      ),
      body: Center(
        child: Container(
          color: Colors.white60,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                'How would you rate your interviewer(s)?',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(0, 16, 8, 16),
                  child: Text(
                    'SELECT YOUR RATING',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black45),
                  )),
              Row(
                children: [
                  Expanded(child: ratingCards[0]),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(child: ratingCards[1]),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(child: ratingCards[2]),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(child: ratingCards[3]),
                ],
              ),
              Expanded(child: Container()),
              TextButton(
                child: Text('GO BACK',
                    style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _changeSelection(int index) {
    setState(() {
      _selection = [false, false, false, false];
      _selection[index] = true;
    });
  }
}
