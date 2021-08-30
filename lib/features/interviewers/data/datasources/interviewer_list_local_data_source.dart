import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:interview_feedback/core/error/exceptions.dart';
import 'package:interview_feedback/features/interviewers/data/models/interviewer_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class InterviewerListLocalDataSource {
  Future<InterviewerListModel> getLastInterviewerList();

  Future<void> cacheInterviewerList(
      InterviewerListModel interviewerListModelToCache);
}

const CACHED_INTERVIEWER_LIST = 'CACHED_INTERVIEWER_LIST';

class InterviewerListLocalDataSourceImpl
    implements InterviewerListLocalDataSource {
  final SharedPreferences sharedPreferences;

  InterviewerListLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<InterviewerListModel> getLastInterviewerList() {
    final jsonString = sharedPreferences.getString(CACHED_INTERVIEWER_LIST);

    if (jsonString != null) {
      return Future.value(
          InterviewerListModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheInterviewerList(
      InterviewerListModel interviewerListModelToCache) {
    return sharedPreferences.setString(CACHED_INTERVIEWER_LIST,
        json.encode(interviewerListModelToCache.toJson()));
  }
}
