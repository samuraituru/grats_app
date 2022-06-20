class Record {
  String headerName;
  String? title;
  String? contents;
  String folderID;
  String groupID;

  Record(
      {required this.headerName,
      this.title,
      this.contents,
      required this.folderID,
      required this.groupID});
}


