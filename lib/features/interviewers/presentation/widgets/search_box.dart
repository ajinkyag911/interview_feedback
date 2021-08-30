import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({Key key, this.controller, this.onTextChange})
      : super(key: key);
  final TextEditingController controller;
  final Function onTextChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.4)
          ]),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: 'Search Interviewers',
            suffixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.all(10.0),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
        onChanged: (string) {
          onTextChange();
        },
      ),
    );
  }
}
