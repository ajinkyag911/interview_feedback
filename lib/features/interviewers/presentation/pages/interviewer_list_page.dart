import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_feedback/features/interviewers/presentation/bloc/interviewer_list_bloc.dart';
import 'package:interview_feedback/features/interviewers/presentation/pages/rating_page.dart';
import 'package:interview_feedback/features/interviewers/presentation/widgets/display_interviews.dart';
import 'package:interview_feedback/features/interviewers/presentation/widgets/floating_button.dart';

import '../../../../injection_container.dart';

class InterviewerListPage extends StatelessWidget {
  const InterviewerListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: buildList(context),
        floatingActionButton: FloatingButton(
          icon: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white,
          ),
          text: 'NEXT',
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RatingPage();
            }));
          },
        ));
  }

  Widget buildList(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkNetworkConnection(),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) {
            return BlocProvider(
              create: (context) => sl<InterviewerListBloc>(),
              child: Center(
                child: Container(
                  color: Colors.white60,
                  padding: const EdgeInsets.all(16.0),
                  child: BlocBuilder<InterviewerListBloc, InterviewerListState>(
                    builder: (context, state) {
                      print('Building list.. ');
                      print(state);
                      if (state is Empty) {
                        return CircularProgressIndicator();
                      } else if (state is Loading) {
                        return CircularProgressIndicator();
                      } else if (state is Loaded) {
                        return DisplayInterviewers(
                          list: state.interviewerList.interviewerList,
                        );
                      } else if (state is Error) {
                        return Text(
                          'Network Error!',
                          style: TextStyle(fontSize: 20),
                        );
                      }
                      BlocProvider.of<InterviewerListBloc>(context)
                          .add(GetTheInterViewerList());
                      return CircularProgressIndicator();
                    },
                  ),
                ),
              ),
            );
          } else {
            return Center(
                child: Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 40,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Network Error',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ));
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<bool> _checkNetworkConnection() async {
    print('Checking network connection .. ');
    return await DataConnectionChecker().hasConnection;
  }
}
