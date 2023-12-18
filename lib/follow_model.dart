class followUpModel {
  String? id;
  String? company;
  String? number;
  String? note;
  String? createDate;
  String? call_status;
  String? status;
  String? follow_type;
  String? followup_date;
  String? creator;

  followUpModel(
      {
        this.id,
        this.company,
        this.number,
        this.note,
        this.createDate,
        this.call_status,
        this.follow_type,
        this.followup_date,
        this.creator});

  followUpModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    company = json['company'];
    number = json['number'];
    note = json['note'];
    createDate = json['create_date'];
    call_status = json['call_status'];
    follow_type = json['follow_type'];
    followup_date = json['followup_date'];
    creator = json['creator'];


  }

  Map<String, dynamic> toJMap() {
    return{
      "id" : id,
      "company" : company,
      "number" : number,
      "note"  : note,
      "createDate": createDate,
      "call_status": call_status,
      "follow_type": follow_type,
      "followup_date": followup_date,
      "creator": creator,

    };

  }
}
