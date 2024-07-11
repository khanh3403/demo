class Approved {
  String? bangDuLieu;
  String? cotDuLieu;
  String? duLieu;
  String? nhanSu;

  Approved({this.bangDuLieu, this.cotDuLieu, this.duLieu, this.nhanSu});

  Approved.fromJson(Map<String, dynamic> json) {
    bangDuLieu = json['bangDuLieu'];
    cotDuLieu = json['cotDuLieu'];
    duLieu = json['duLieu'];
    nhanSu = json['nhanSu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bangDuLieu'] = this.bangDuLieu;
    data['cotDuLieu'] = this.cotDuLieu;
    data['duLieu'] = this.duLieu;
    data['nhanSu'] = this.nhanSu;
    return data;
  }
}
