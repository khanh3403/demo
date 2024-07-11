import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/provider/calamviec_provider.dart';
import 'package:salesoft_hrm/API/provider/diadiem_provider.dart';
import 'package:salesoft_hrm/API/repository/calamviec_repository.dart';
import 'package:salesoft_hrm/API/repository/diadiem_repository.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/main.dart';
import 'package:salesoft_hrm/model/calamviec_model.dart';

class Location {
  final String name;
  final MyLatLng coordinates;
  bool isSelected;

  Location(this.name, this.coordinates, {this.isSelected = false});
}

class MyLatLng {
  final double latitude;
  final double longitude;

  MyLatLng(this.latitude, this.longitude);
}

class checkinController extends GetxController {
  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );
  late Timer _timer;
  String selectedShift = '';
  String btnChamCong = '';
  bool isButtonVisible = true;
  Completer<GoogleMapController> controllerCompleter = Completer();
  GoogleMapController? googleMapController1;
  GoogleMapController? googleMapController2;
  Location? selectedOffice;

  late String selectedLocation;
  MyLatLng? currentLocation;
  TextEditingController distanceController = TextEditingController();
  //list tọa độ
  List<Location> offices = [];
  List<Marker> markers = [];

  List<CaLamViec> ca = [
    //   CaLamViec(
    //   ten: 'Ca sáng',
    //   gioVao: '13:00',
    //   gioRa: '14:00',
    // ),
  ];
  late int checkInH, checkInM, checkOutH, checkOutM;
  String checkInTime = '', checkOutTime = '';
  bool isOnTime = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getCaLamViecList();
    await getDiaDiemList();
    isCheckedIn = box.read('isCheckedIn') ?? false;
    isCheckedOut = box.read('isCheckedOut') ?? false;
    if (currentLocation == null) {
      getCurrentLocation();
    }
  }

  Future<void> getCaLamViecList() async {
    try {
      final calamProvider = CaLamProviderAPI(AuthService());
      final calamRepository = CaLamRepository(provider: calamProvider);
      final caLamList = await calamRepository.getCaLam();
      if (caLamList != null && caLamList.caLamList.isNotEmpty) {
        ca.clear();
        ca = caLamList.caLamList;
        update();
        // print(ca);
      } else {
        print('Không có dữ liệu ca làm việc');
      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu CaLamViec: $e');
    }
  }

  Future<void> getDiaDiemList() async {
    try {
      final diaDiemProvider = DiaDiemProviderAPI(AuthService());

      final diaDiemRepository = DiaDiemRepository(provider: diaDiemProvider);

      final diaDiemList = await diaDiemRepository.getDiaDiem();

      if (diaDiemList != null && diaDiemList.diaDiemList.isNotEmpty) {
        offices.clear();
        for (var diaDiem in diaDiemList.diaDiemList) {
          if (diaDiem.ten != null &&
              diaDiem.viDo != null &&
              diaDiem.kinhDo != null) {
            double latitude = double.parse(diaDiem.viDo!);
            double longitude = double.parse(diaDiem.kinhDo!);
            offices.add(Location(
              diaDiem.ten!,
              MyLatLng(latitude, longitude),
            ));
          }
        }

        updateMarkers();
        print('abc $offices');
      } else {
        print('Không có dữ liệu địa điểm');
      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu DiaDiem: $e');
    }
  }

  final box = GetStorage();

  bool _isCheckedIn = false;

  bool get isCheckedIn => _isCheckedIn;

  set isCheckedIn(bool value) {
    _isCheckedIn = value;
    box.write('isCheckedIn', value);
    update();
  }

  bool _isCheckedOut = false;

  bool get isCheckedOut => _isCheckedOut;

  set isCheckedOut(bool value) {
    _isCheckedOut = value;
    box.write('isCheckedOut', value);
    update();
  }

  String _checkInTime = '';

  void getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentLocation = MyLatLng(position.latitude, position.longitude);
      updateSelectedShift();
      updateBtnChamCong();
      update();

      if (offices.isNotEmpty) {
        selectClosestOffice();
      } else {
        print('Danh sách văn phòng rỗng');
      }
    } catch (e) {
      print('Không thể lấy vị trí hiện tại: $e');
    }
  }

  void toggleSelectedOffice(String officeName) async {
    selectedOffice = offices.firstWhere((office) => office.name == officeName);
    update();

    if (googleMapController1 != null && selectedOffice != null) {
      LatLng targetPosition = LatLng(selectedOffice!.coordinates.latitude,
          selectedOffice!.coordinates.longitude);
      googleMapController1!.animateCamera(
        CameraUpdate.newLatLngZoom(
          targetPosition,
          16.5,
        ),
      );
    }
  }

  void selectClosestOffice() {
    if (offices.isNotEmpty) {
      double minDistance = double.infinity;
      Location? closestOffice;

      for (Location office in offices) {
        double distance = calculateDistance(
          currentLocation!.latitude,
          currentLocation!.longitude,
          office.coordinates.latitude,
          office.coordinates.longitude,
        );

        if (distance < minDistance) {
          minDistance = distance;
          closestOffice = office;
        }
      }

      if (closestOffice != null) {
        toggleSelectedOffice(closestOffice.name);
      } else {
        print('Không tìm thấy văn phòng gần nhất');
      }
    } else {
      print('Không có vị trí hiện tại hoặc danh sách văn phòng rỗng');
    }
  }

  Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      Get.snackbar('Thông báo', 'Bạn cần cấp quyền truy câpj vị trí để sử dụng ứng dụng này.',
                        snackPosition: SnackPosition.TOP, backgroundColor: AppColors.blue50);
    } else {
      getCurrentLocation();
    }
  }

  void selectOffice(Location office) {
    selectedOffice = office;
    for (Location o in offices) {
      o.isSelected = (o == office);
    }
    update();
  }

//room map
  void getCurrentLocation2(int mapIndex) {
    if (mapIndex == 1 && googleMapController1 != null) {
      googleMapController1!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(
            currentLocation!.latitude!,
            currentLocation!.longitude!,
          ),
          16.5,
        ),
      );
    } else if (mapIndex == 2 && googleMapController2 != null) {
      googleMapController2!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(
            currentLocation!.latitude,
            currentLocation!.longitude,
          ),
          16.5,
        ),
      );
    }
  }

//tính khoảng cách
  double calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    const int earthRadius = 6371000;
    double lat1Radians = degreesToRadians(startLatitude);
    double lon1Radians = degreesToRadians(startLongitude);
    double lat2Radians = degreesToRadians(endLatitude);
    double lon2Radians = degreesToRadians(endLongitude);

    double latDifference = lat2Radians - lat1Radians;
    double lonDifference = lon2Radians - lon1Radians;

    double a = pow(sin(latDifference / 2), 2) +
        cos(lat1Radians) * cos(lat2Radians) * pow(sin(lonDifference / 2), 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c;

    return distance;
  }

  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  bool isSelectedOffice(String officeName) {
    for (Location office in offices) {
      if (office.name == officeName) {
        return office.isSelected;
      }
    }
    return false;
  }

//thông báo
  

 void checkIn() {
  TimeOfDay now = TimeOfDay.now();

  if (currentLocation == null) {
    Get.snackbar('Thông báo', 'Đang lấy vị trí hiện tại.',
      snackPosition: SnackPosition.TOP, backgroundColor: AppColors.blue50);
    print('Đang đợi lấy vị trí hiện tại...');
    return;
  }

  if (distanceController.text.isEmpty) {
    Get.snackbar('Thông báo', 'Vui lòng nhập khoảng cách chấm công.',
      snackPosition: SnackPosition.TOP, backgroundColor: AppColors.blue50);
    return;
  }

  double distanceThreshold = double.tryParse(distanceController.text) ?? 0;
  if (distanceThreshold <= 0) {
    Get.snackbar('Thông báo', 'Khoảng cách chấm công không hợp lệ.',
      snackPosition: SnackPosition.TOP, backgroundColor: AppColors.blue50);
    return;
  }

  if (selectedOffice == null) {
    Get.snackbar('Thông báo', 'Vui lòng chọn văn phòng trước khi chấm công.',
      snackPosition: SnackPosition.TOP, backgroundColor: AppColors.blue50);
    return;
  }

  double distanceToOffice = calculateDistance(
    currentLocation!.latitude,
    currentLocation!.longitude,
    selectedOffice!.coordinates.latitude,
    selectedOffice!.coordinates.longitude,
  );

  CaLamViec? selectedShiftModel;
  if (ca.isNotEmpty) {
    selectedShiftModel = ca.firstWhere((shift) =>
      '${shift.ten} (${shift.gioVao} - ${shift.gioRa})' == selectedShift,
    );
  }

  if (selectedShiftModel != null) {
    int timeInMinutes = _convertToMinutes(selectedShiftModel.gioVao);
    int timeOutMinutes = _convertToMinutes(selectedShiftModel.gioRa);
    int currentMinutes = now.hour * 60 + now.minute;

    if (distanceToOffice <= distanceThreshold) {
      if (timeInMinutes - 30 <= currentMinutes && currentMinutes <= timeInMinutes + 10) {
         postChamCong(deviceToken.value, selectedShift, selectedOffice!.name, true, '');
        Get.snackbar('Thông báo', 'Đã chấm công vào ${selectedOffice!.name} (${selectedShift}).',
          snackPosition: SnackPosition.TOP, backgroundColor: AppColors.blue50);
      } else if (timeOutMinutes - 10 <= currentMinutes && currentMinutes <= timeOutMinutes + 30) {
        Get.snackbar('Thông báo', 'Đã chấm công ra ${selectedOffice!.name} (${selectedShift}).',
          snackPosition: SnackPosition.TOP, backgroundColor: AppColors.blue50);
      } else {
        Get.snackbar('Thông báo', 'Chưa tới giờ ${selectedOffice!.name} (${selectedShift}).',
          snackPosition: SnackPosition.TOP, backgroundColor: AppColors.blue50);
      }
    } else {
      Get.snackbar('Thông báo', 'Bạn đang ở quá xa văn phòng.',
        snackPosition: SnackPosition.TOP, backgroundColor: AppColors.blue50);
    }
  } else {
    Get.snackbar('Thông báo', 'Không tìm thấy thông tin ca làm việc đã chọn.',
      snackPosition: SnackPosition.TOP, backgroundColor: AppColors.blue50);
  }
}

  

  int _convertToMinutes(String? time) {
    if (time == null) return 0;
    List<String> parts = time.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return hour * 60 + minute;
  }

  void updateSelectedShift() {
    TimeOfDay now = TimeOfDay.now();
    selectedShift = '';

    if (ca.isNotEmpty) {
      for (CaLamViec shift in ca) {
        int timeInMinutes = _convertToMinutes(shift.gioVao);
        int timeOutMinutes = _convertToMinutes(shift.gioRa);
        int currentMinutes = now.hour * 60 + now.minute;

        if (currentMinutes >= timeInMinutes - 30 &&
            currentMinutes <= timeOutMinutes + 30) {
          selectedShift = '${shift.ten} (${shift.gioVao} - ${shift.gioRa})';
          isCheckedOut = false;
          break;
        }
      }
    }

    update();
  }

  void updateBtnChamCong() {
    TimeOfDay now = TimeOfDay.now();
    btnChamCong = '';
    if (ca.isNotEmpty) {
      for (CaLamViec shift in ca) {
        int timeInMinutes = _convertToMinutes(shift.gioVao);
        int timeOutMinutes = _convertToMinutes(shift.gioRa);
        int currentMinutes = now.hour * 60 + now.minute;
        if (currentMinutes >= timeInMinutes - 30 &&
            currentMinutes <= timeInMinutes) {
          btnChamCong = 'Chấm công vào';
          isButtonVisible = true;
          update();
          return;
        } else {
          btnChamCong = 'Chấm công ra';
          isButtonVisible = true;
          isButtonVisible = true;
          update();
          return;
        }
      }
    }
  }

  void updateMarkers() {
    markers.clear();

    for (int i = 0; i < offices.length; i++) {
      Location location = offices[i];
      markers.add(
        Marker(
          markerId: MarkerId('Office ${i + 1}'),
          position: LatLng(
              location.coordinates.latitude, location.coordinates.longitude),
          infoWindow: InfoWindow(
            title:
                '${location.name} (${location.coordinates.latitude}, ${location.coordinates.longitude})',
          ),
        ),
      );
    }

    update();
  }
Future<void> postChamCong(String token, String ca, String diaDiem, bool checkIn, String lyDo) async {
  final prefs = await SharedPreferences.getInstance();
  final ma = prefs.getString('ma');

  if (ma == null) {
    print('Không tìm thấy mã trong SharedPreferences');
    return;
  }

  final urlEndPoint = "${URLHelper.NS_ChamCong}?Ma=$ma&Token=$token&CaLamViec=$ca&DiaDiem=$diaDiem&CheckIn=$checkIn&LyDo=$lyDo";
  final response = await HttpUtil().post(
    urlEndPoint,
    params: {'Ma': ma, 'Token': token, 'CaLamViec': ca, 'DiaDiem': diaDiem, 'CheckIn': checkIn, 'LyDo': lyDo},
  );

  if (response.statusCode == 200) {
    print('Đã đẩy lên API');
  } else {
    print('Lỗi khi đẩy lên API: ${response.statusCode}');
  }
}
}