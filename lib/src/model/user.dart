import 'package:json_annotation/json_annotation.dart';

class User {
  @JsonKey(name: 'user_name')
  String _userName;

  @JsonKey(name: 'user_id')
  int _userId;

  @JsonKey(name: 'user_image_path')
  String _userImagePath;

  @JsonKey(name: 'is_logged_in')
  bool _isLoggedIn;

  User(this._userId, this._userName, this._userImagePath, this._isLoggedIn);

  User.fromUser(this._userName, this._userImagePath, this._isLoggedIn);

  static User userFromMap(Map<String, dynamic> userMap) {
    return User(
      userMap['user_id'],
      userMap['user_name'],
      userMap['user_image_path'],
      userMap['is_logged_in'] == 0 ? false : true,
    );
  }

  static Map<String, dynamic> mapFromUser(User user) {
    return {
      'user_id': user._userId,
      'user_name': user._userName,
      'user_image_path': user._userImagePath,
      'is_logged_in': user._isLoggedIn? 1: 0
    };
  }

  bool get isLoggedIn => _isLoggedIn;

  String get userImagePath => _userImagePath;

  int get userId => _userId;

  String get userName => _userName;


}
