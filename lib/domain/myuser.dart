class MyUser {
  String? userName;
  String? userTarget;
  String? uID;
  Map<String,dynamic>? groupIDs;
  String? email;
  String imgURL;

  MyUser(
      {this.userName,
      this.userTarget,
      this.uID,
      this.email,
      this.imgURL = '',
      this.groupIDs});
}
