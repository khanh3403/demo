class NsInfo {
  int? id;
  String? ma;
  String? hoDem;
  String? ten;
  String? kh;
  String? ngaySinh;
  String? gioiTinh;
  String? soHd;
  String? ngayKyHd;
  String? dcll;
  String? dienThoai;
  String? email;
  bool? deleted;
  String? chucVu;
  String? phongBan;
  String? toCongTac;

  NsInfo(
      {this.id,
      this.ma,
      this.hoDem,
      this.ten,
      this.kh,
      this.ngaySinh,
      this.gioiTinh,
      this.soHd,
      this.ngayKyHd,
      this.dcll,
      this.dienThoai,
      this.email,
      this.deleted,
      this.chucVu,
      this.phongBan,
      this.toCongTac});

  NsInfo.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    ma = json["ma"];
    hoDem = json["hoDem"];
    ten = json["ten"];
    kh = json["kh"];
    ngaySinh = json["ngaySinh"];
    gioiTinh = json["gioiTinh"];
    soHd = json["soHd"];
    ngayKyHd = json["ngayKyHd"];
    dcll = json["dcll"];
    dienThoai = json["dienThoai"];
    email = json["email"];
    deleted = json["deleted"];
    chucVu = json["chucVu"];
    phongBan = json["phongBan"];
    toCongTac = json["toCongTac"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["ma"] = ma;
    _data["hoDem"] = hoDem;
    _data["ten"] = ten;
    _data["kh"] = kh;
    _data["ngaySinh"] = ngaySinh;
    _data["gioiTinh"] = gioiTinh;
    _data["soHd"] = soHd;
    _data["ngayKyHd"] = ngayKyHd;
    _data["dcll"] = dcll;
    _data["dienThoai"] = dienThoai;
    _data["email"] = email;
    _data["deleted"] = deleted;
    _data["chucVu"] = chucVu;
    _data["phongBan"] = phongBan;
    _data["toCongTac"] = toCongTac;
    return _data;
  }
}
