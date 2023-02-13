import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  String id;
  String email;
  String? profilepic;
  String name;
  int totalPoints;

  Users({required this.id,
    required this.email,
    this.profilepic,
    required this.name,
    required this.totalPoints});

  Users.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        email = snapshot['email'],
        name = snapshot['name'],
        profilepic = snapshot['profilepic'],
        totalPoints = snapshot['totalPoints'];
}

class UsersQuizs {
  String id;
  String correctCount;
  String paperID;
  String points;
  int time;

  UsersQuizs({required this.id,
    required this.correctCount,
    required this.paperID,
    required this.points,
    required this.time});

    UsersQuizs.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
        :id = snapshot.id,
        correctCount = snapshot['correct_count'],
        paperID = snapshot['paper_id'],
        points = snapshot['points'],
        time = snapshot['time'] as int;
  }

  class UserLeaderBoard {
  String id;
  int points;
  String userName;

  UserLeaderBoard({required this.id,
    required this.points,
    required this.userName});

    UserLeaderBoard.fromSnapshot(
        DocumentSnapshot<Map<String, dynamic>> snapshot)
        :id = snapshot.id,
        points = snapshot['points'] as int,
        userName = snapshot['user_id'];


  }