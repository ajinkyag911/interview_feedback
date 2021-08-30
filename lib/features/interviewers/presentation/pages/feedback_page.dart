import 'package:flutter/material.dart';
import 'package:interview_feedback/core/data/constants.dart';
import 'package:interview_feedback/core/data/models/feedback_item.dart';
import 'package:interview_feedback/features/interviewers/presentation/pages/thank_you_page.dart';
import 'package:interview_feedback/features/interviewers/presentation/widgets/floating_button.dart';
import 'package:interview_feedback/features/interviewers/presentation/widgets/rating_card.dart';
import 'package:interview_feedback/features/interviewers/presentation/widgets/rating_feedback_card.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';

import 'add_comment_page.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({
    Key key,
  }) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  static List<FeedbackItem> _feedbackItems = Constants.myFeedbackitems;

  final _items = _feedbackItems
      .map((animal) => MultiSelectItem<FeedbackItem>(animal, animal.name))
      .toList();
  List<FeedbackItem> _selectedAnimals4 = [];

  @override
  Widget build(BuildContext context) {
    var ratingCard = context.read<RatingCard>();

    return Scaffold(
      floatingActionButton: FloatingButton(
        icon: Icon(
          Icons.check,
          color: Colors.white,
        ),
        text: 'SUBMIT',
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Provider.value(
              value: ratingCard,
              child: ThankYouPage(),
            );
          }));
        },
      ),
      body: Container(
        color: Colors.white60,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 16, 8, 16),
                child: Text(
                  'YOU HAVE RATED YOUR INTERVIEWER(S)',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black45),
                )),
            Row(
              children: [
                Expanded(
                  child: RatingFeedbackCard(
                    title: ratingCard.title,
                    emoji: ratingCard.emoji,
                    description: ratingCard.description,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'What made the interviews ' +
                  ratingCard.title.toLowerCase() +
                  '?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            MultiSelectChipField(
              scroll: false,
              showHeader: false,
              items: _items,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white54, width: 1.8),
                  borderRadius: BorderRadius.all(Radius.circular(2))),
              initialValue: [
                _feedbackItems[0],
                _feedbackItems[4],
              ],
              selectedChipColor: Colors.green.withOpacity(0.5),
              selectedTextStyle:
                  TextStyle(color: Color(0xff12873b), fontSize: 18),
              onTap: (values) {
                _selectedAnimals4 = values;
              },
            ),
            Expanded(child: Container()),
            TextButton(
              child: Row(
                children: [
                  Text('ADD COMMENT',
                      style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.message_outlined,
                    color: Colors.black,
                  )
                ],
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Provider.value(
                    value: ratingCard,
                    child: AddCommentPage(),
                  );
                }));
              },
            )
          ],
        ),
      ),
    );
  }
}
