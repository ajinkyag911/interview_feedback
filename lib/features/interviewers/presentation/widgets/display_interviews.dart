import 'package:flutter/material.dart';
import 'package:interview_feedback/core/data/models/interviewer_model.dart';
import 'package:interview_feedback/features/interviewers/presentation/widgets/search_box.dart';

import 'list_item.dart';

class DisplayInterviewers extends StatefulWidget {
  const DisplayInterviewers({Key key, this.list}) : super(key: key);
  final List<InterviewerModel> list;

  @override
  _DisplayInterviewersState createState() => _DisplayInterviewersState();
}

class _DisplayInterviewersState extends State<DisplayInterviewers> {
  final controller = TextEditingController();
  var _list = [];
  var _addedList = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
        ),
        Text(
          'Interviewers',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        SearchBox(
          controller: controller,
          onTextChange: onTextChange,
        ),
        Container(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
            child: Text(
              _addedList.length.toString() + ' ADDED',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
            )),
        Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  return ListItem(
                    index: index,
                    add: _addInterviewer,
                    addedList: _addedList,
                    listElement: _list[index],
                    remove: _removeInterviewer,
                  );
                }),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    _list = widget.list;
  }

  void _addInterviewer(int index) {
    setState(() {
      _addedList.add(_list[index]);
      print(_addedList);
    });
  }

  void _removeInterviewer(int index) {
    setState(() {
      _addedList.remove(_list[index]);
      print(_addedList);
    });
  }

  void onTextChange() {
    _list = widget.list;

    var result = _list.map((element) {
      if (element.name.toLowerCase().contains(controller.text)) {
        return element;
      } else {
        return false;
      }
    }).toList();

    List<InterviewerModel> filteredResult = [];

    for (int i = 0; i < result.length; i++) {
      if (result[i] != false) {
        filteredResult.add(result[i]);
      }
    }

    setState(() {
      _list = filteredResult;
    });
  }
}
