import 'package:flutter/material.dart';
import 'package:interview_feedback/features/interviewers/presentation/pages/interviewer_list_page.dart';
import 'package:interview_feedback/features/interviewers/presentation/widgets/rating_card.dart';
import 'package:provider/provider.dart';

class ThankYouPage extends StatelessWidget {
  const ThankYouPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ratingCard = context.read<RatingCard>();

    return Scaffold(
      body: Container(
        color: Colors.white60,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
            ),
            Text(
              'Thank You!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'We have taken your feedback. We are glad that you felt your interview was ' +
                  ratingCard.title +
                  '!',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            Expanded(child: Container()),
            TextButton(
              child: Text('HOME',
                  style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return InterviewerListPage();
                }));
              },
            )
          ],
        ),
      ),
    );
  }
}
