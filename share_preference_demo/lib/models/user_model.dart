class JRUserModel {
  String username;
  String password;

  JRUserModel({this.username, this.password});

  JRUserModel.fromMap(Map<String, dynamic> userMap) {
    username = userMap['username'];
    password = userMap['password'];
  }

  Map<String, String> toJson() => {
    'username' : username,
    'password' : password
  };
}
