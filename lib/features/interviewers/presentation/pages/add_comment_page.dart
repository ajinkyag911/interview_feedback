import 'package:flutter/material.dart';
import 'package:interview_feedback/features/interviewers/presentation/pages/thank_you_page.dart';
import 'package:interview_feedback/features/interviewers/presentation/widgets/floating_button.dart';
import 'package:interview_feedback/features/interviewers/presentation/widgets/rating_card.dart';
import 'package:provider/provider.dart';

class AddCommentPage extends StatefulWidget {
  const AddCommentPage({Key key}) : super(key: key);

  @override
  _AddCommentPageState createState() => _AddCommentPageState();
}

class _AddCommentPageState extends State<AddCommentPage> {
  TextEditingController controller;

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
                    'COMMENT (OPTIONAL)',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black45),
                  )),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                maxLength: 240,
                style: TextStyle(fontSize: 22),
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Write your review',
                  filled: true,
                  fillColor: Colors.white60,
                ),
                onChanged: (string) {
                  // onTextChange();
                },
              ),
              Expanded(child: Container()),
              TextButton(
                child: Text('SKIP',
                    style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          )),
    );
  }
}
