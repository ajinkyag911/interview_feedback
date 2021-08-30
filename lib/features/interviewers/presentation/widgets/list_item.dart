import 'package:flutter/material.dart';
import 'package:interview_feedback/core/data/models/interviewer_model.dart';

class ListItem extends StatelessWidget {
  const ListItem(
      {Key key,
      this.index,
      this.add,
      this.addedList,
      this.listElement,
      this.remove})
      : super(key: key);
  final int index;
  final Function(int) add;
  final Function(int) remove;
  final addedList;
  final InterviewerModel listElement;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(8, 4, 0, 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              listElement.name,
              style: TextStyle(
                  fontSize: 16,
                  color: addedList.contains(listElement)
                      ? Colors.blueAccent
                      : Colors.black),
            ),
            TextButton(
              onPressed: () {
                if (addedList.contains(listElement)) {
                  remove(index);
                } else {
                  add(index);
                }
              },
              child: addedList.contains(listElement)
                  ? Text(
                      'REMOVE',
                      style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'ADD',
                      style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold),
                    ),
            ),
          ],
        ));
  }
}
