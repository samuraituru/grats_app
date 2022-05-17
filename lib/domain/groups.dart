class Groups {
  Groups(this.gDesc, this.gName);
  String gDesc;
  String gName;
}

class Folders {
  Folders(this.fName, this.fDesc);
  String fName;
  String fDesc;
}

class Items {
  Items(this.iName1, this.iName2);
  String iName1;
  String iName2;

  getItems(){
    return this.iName1;
  }
}