import 'dart:math';

class UserModel {
  String userid;
  String displayname;
  String email;

  UserModel({
    required this.userid,
    required this.displayname,
    required this.email,
  });

  String useridgenertaor() {
    '''
thought of a method that can actually generate userid based on user input

how does this algorithm works
2 detail from displayname and email;
and a list of random_numbers to get your id
''';
    String displayame_shortner = displayname.substring(1, 4);
    String email_shortner = email.substring(1, 4);
    List randomo_num = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    randomo_num.shuffle();

    var two_random_num = randomo_num[0] + randomo_num[1];
    var userid = displayame_shortner + email_shortner + two_random_num;
    return userid;
  }
}
