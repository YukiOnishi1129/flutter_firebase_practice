class Account {
  String id;
  String name;
  String imagePath;
  String selfIntroduction;
  String userId;
  DateTime? createdTime;
  DateTime? updatedTime;

  // コンストラクタ
  Account({
    this.id = '',
    this.name = '',
    this.imagePath = '',
    this.selfIntroduction = '',
    this.userId = '',
    this.createdTime,
    this.updatedTime,
  });
}
