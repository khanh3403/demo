
class XetDuyet {
    int? stt;
    String? loai;
    int? id;
    String? ngay;
    String? dieuKien;
    String? noiDung;
    bool? tinhTrang;
    String? capDuyet;
    int? totalCount;

    XetDuyet({this.stt, this.loai, this.id, this.ngay, this.dieuKien, this.noiDung, this.tinhTrang, this.capDuyet, this.totalCount});

    XetDuyet.fromJson(Map<String, dynamic> json) {
        stt = json["stt"];
        loai = json["loai"];
        id = json["id"];
        ngay = json["ngay"];
        dieuKien = json["dieuKien"];
        noiDung = json["noiDung"];
        tinhTrang = json["tinhTrang"];
        capDuyet = json["capDuyet"];
        totalCount = json["totalCount"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["stt"] = stt;
        _data["loai"] = loai;
        _data["id"] = id;
        _data["ngay"] = ngay;
        _data["dieuKien"] = dieuKien;
        _data["noiDung"] = noiDung;
        _data["tinhTrang"] = tinhTrang;
        _data["capDuyet"] = capDuyet;
        _data["totalCount"] = totalCount;
        return _data;
    }
}