class StudentParentModel {
  int? id;
  String? name;
  int? parentId;
  String? parentName;
  String? mobile;
   var phone;
   bool isSelected=false;

  StudentParentModel(
      {this.id,
        this.name,
        this.parentId,
        this.parentName,
        this.mobile,
        this.phone});

  StudentParentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    parentName = json['parent_name'];
    mobile = json['mobile'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['parent_name'] = this.parentName;
    data['mobile'] = this.mobile;
    data['phone'] = this.phone;
    return data;
  }
}
