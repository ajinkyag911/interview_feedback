import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:interview_feedback/core/error/exceptions.dart';
import 'package:interview_feedback/features/interviewers/data/models/interviewer_list_model.dart';

abstract class InterviewerListRemoteDataSource {
  Future<InterviewerListModel> getInterviewerList();
}

class InterviewerListRemoteDataSourceImpl
    implements InterviewerListRemoteDataSource {
  final http.Client client;

  InterviewerListRemoteDataSourceImpl({@required this.client});

  @override
  Future<InterviewerListModel> getInterviewerList() async {
    /*
    final response = await client.get(
        Uri.parse('https://randomuser.me/api/'),
        // headers: {'results' : '20'}
        // headers: {'Content-Type': 'application/json',},
        headers: {'dataType': 'json',},
    );

     */

    var response =
        await http.get(Uri.parse("https://randomuser.me/api/?results=20"));

    print(response);

    if (response.statusCode == 200) {
      return InterviewerListModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
