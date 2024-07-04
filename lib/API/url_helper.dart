class URLHelper {
  static String baseUrl = "https://api.salesoft.vn";

  static String urlRequest = "$baseUrl/api/";

  static const String Nhan_Su = "NhanSu/GetList";
  static const String Login = "Auth/Login";
  static const String NS_Information = "NhanSu/GetInfoByCode";
  static const String NS_quanhe = "NhanSuQH/GetListByCode";
  static const String NS_congtactr = "NhanSuQTCT/GetListBeforeByCode";
  static const String NS_hocvan = "NhanSuHV/GetListByCode";
  static const String NS_congtac = "NhanSuQTCT/GetListByCode";
  static const String NS_khenthuong = "NhanSuKT/GetListByCode";
  static const String NS_kyluat = "NhanSuKL/GetListByCode";
  static const String NS_qlLuong = "NhanSuQTL/GetListByCode";
  static const String NS_InforUpdate = "NhanSu/Update";  
  static const String NS_NotApproved ="NhanSu/CheckExistsUpdate";
  static const String DM_NganHang="DanhMuc/GetList";
  static const String NS_Token="Token/Create";
  static const String DM_DiaDiem="DiaDiem/GetListByCode";
  static const String DM_CaLam="CaLamViec/GetListByCode";
}
