import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class InterviewerModel extends Equatable {
  final String name;

  InterviewerModel({
    @required this.name,
  });

  factory InterviewerModel.fromJson(Map<String, dynamic> json) {
    return InterviewerModel(
        name: json['name']['first'] + ' ' + json['name']['last']);
  }

  @override
  // TODO: implement props
  List<Object> get props => [name];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
