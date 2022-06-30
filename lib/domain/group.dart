class Group {
  String? groupName;
  String? groupDescription;
  String? groupID;
  List<dynamic>? memberIDs;
  String? imgURL;
  Map<String ,dynamic>? isBlocks;

  Group(
      {this.groupName,
      this.groupDescription,
      this.groupID,
      this.memberIDs,
      this.isBlocks,
      this.imgURL = ''});
}
