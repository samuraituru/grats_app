class Group {
  String? groupName;
  String? groupDescription;
  String? groupID;
  Map<String,dynamic>? memberIDs;
  String? imgURL;

  Group(
      {this.groupName,
      this.groupDescription,
      this.groupID,
      this.memberIDs,
      this.imgURL = ''});
}
