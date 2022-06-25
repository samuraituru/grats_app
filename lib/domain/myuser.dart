class MyUser {
  String? userName;
  String? target;
  String? uID;
  String? groupID;
  List<dynamic>? gIDList;
  String? email;
  String? imgURL;

  MyUser(
      {this.userName,
      this.target,
      this.uID,
      this.email,
      this.groupID,
      this.imgURL = '',
      this.gIDList});
}
