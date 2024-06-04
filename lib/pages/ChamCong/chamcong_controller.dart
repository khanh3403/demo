import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

class Ca {
  final String ca;
  final TimeOfDay GioVao;
  final TimeOfDay GioRa;
  final int time;

  Ca(this.ca, this.GioVao, this.GioRa, this.time);
}

class checkinController extends GetxController {
  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );
  late Timer _timer;
  String selectedShift = '';
  Completer<GoogleMapController> controllerCompleter = Completer();
  GoogleMapController? googleMapController1;
  GoogleMapController? googleMapController2;
  Location? selectedOffice;

  late String selectedLocation;
  MyLatLng? currentLocation;
  TextEditingController distanceController = TextEditingController();
  //list tọa độ
  List<Location> offices = [
    Location('Văn phòng DDG', MyLatLng(20.9254380, 105.7060038)),
    Location('Văn phòng 2', MyLatLng(20.9027777, 105.7234975)),
    Location('Văn phòng 3', MyLatLng(20.957181, 105.948596)),
  ];
  List<Marker> markers = [];

  List<Ca> ca = [
    Ca('Ca Sáng', TimeOfDay(hour: 8, minute: 00),
        TimeOfDay(hour: 12, minute: 00), 30),
    Ca('Ca Chiều', TimeOfDay(hour: 13, minute: 30),
        TimeOfDay(hour: 17, minute: 30), 30),
  ];
  late int checkInH, checkInM, checkOutH, checkOutM;
  String checkInTime = '', checkOutTime = '';
  bool isOnTime = false;

  @override
  void onInit() {
    super.onInit();
    isCheckedIn = box.read('isCheckedIn') ?? false;
    isCheckedOut = box.read('isCheckedOut') ?? false;
    if (currentLocation == null) {
      getCurrentLocation();
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
          desiredAccuracy: LocationAccuracy.high);

      currentLocation = MyLatLng(position.latitude, position.longitude);
      updateSelectedShift();
      selectClosestOffice();
      update();
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
    if (currentLocation != null) {
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
      }
    }
  }

  // final _timeStreamController = StreamController<void>.broadcast();

  // Stream<void> get timeStream => _timeStreamController.stream;

  // void updateSelectedShiftByTime() {
  //   updateSelectedShift();
  //   _timeStreamController.add(null);
  // }

  Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
        msg: "Bạn cần cấp quyền truy cập vị trí để sử dụng chức năng này",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
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
  void _showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
    );
  }

  void checkIn() {
    if (currentLocation == null) {
      _showToast("Đang lấy vị trí hiện tại...", Colors.orange);
      print('Đang đợi lấy vị trí hiện tại...');
      return;
    }

    if (distanceController.text.isEmpty) {
      _showToast("Vui lòng nhập khoảng cách chấm công.", Colors.red);
      return;
    }

    double distanceThreshold = double.tryParse(distanceController.text) ?? 0;
    if (distanceThreshold <= 0) {
      _showToast("Khoảng cách chấm công không hợp lệ.", Colors.red);
      return;
    }
    if (selectedOffice == null) {
      _showToast("Vui lòng chọn văn phòng trước khi chấm công.", Colors.red);
      return;
    }

    double distanceToOffice = calculateDistance(
      currentLocation!.latitude,
      currentLocation!.longitude,
      selectedOffice!.coordinates.latitude,
      selectedOffice!.coordinates.longitude,
    );

    if (ca.isNotEmpty) {
      isOnTime = false;
      for (Ca shift in ca) {
        TimeOfDay now = TimeOfDay.now();
        int TimeIn = shift.GioVao.hour * 60 + shift.GioVao.minute;
        int TimeOut = shift.GioRa.hour * 60 + shift.GioRa.minute;
        int TimeNow = now.hour * 60 + now.minute;
        if (TimeNow >= TimeIn - shift.time && TimeNow <= TimeOut + shift.time) {
          isOnTime = true;
          if (distanceToOffice < distanceThreshold) {
            if (TimeNow > TimeIn - shift.time &&
                TimeNow < TimeIn + shift.time &&
                !isCheckedIn) {
              isCheckedIn = true;
              checkInH = now.hour;
              checkInM = now.minute;
              checkInTime =
                  '${checkInH.toString().padLeft(2, '0')}:${checkInM.toString().padLeft(2, '0')}';
              _showToast("Chấm công vào ${shift.ca}${selectedOffice?.name}.",
                  Colors.green);
              return;
            } else if (TimeNow > TimeOut - shift.time &&
                TimeNow < TimeOut + shift.time &&
                !isCheckedOut) {
              isCheckedOut = true;
              checkOutH = now.hour;
              checkOutM = now.minute;
              checkOutTime =
                  '${checkOutH.toString().padLeft(2, '0')}:${checkOutM.toString().padLeft(2, '0')}';
              _showToast("Chấm công ra ${shift.ca}${selectedOffice?.name}.",
                  Colors.green);
              return;
            } else if (TimeNow >= TimeIn - shift.time &&
                TimeNow <= TimeOut - shift.time &&
                isCheckedIn) {
              _showToast(
                  "Đã chấm công vào ${shift.ca} ${selectedOffice?.name} lúc $checkInTime ",
                  Colors.orange);
            } else if (TimeNow >= TimeOut - shift.time &&
                TimeNow <= TimeOut + shift.time &&
                isCheckedOut) {
              _showToast(
                  "Đã chấm công ra ${shift.ca} ${selectedOffice?.name} lúc $checkOutTime",
                  Colors.orange);
            } else {
              print(isCheckedIn);
              _showToast('Chưa chấm công vào', Colors.orange);
            }
          } else {
            _showToast(
                "Khoảng cách của bạn không nằm trong giới hạn chấm công: ${distanceToOffice.toStringAsFixed(2)} mét",
                Colors.red);
          }
          break;
        }
      }
    }
    if (!isOnTime) {
      _showToast("Không có ca làm việc phù hợp.", Colors.red);
    }
  }

  void updateSelectedShift() {
    TimeOfDay now = TimeOfDay.now();

    if (ca.isNotEmpty) {
      for (Ca shift in ca) {
        int TimeIn = shift.GioVao.hour * 60 + shift.GioVao.minute;
        int TimeOut = shift.GioRa.hour * 60 + shift.GioRa.minute;
        int TimeNow = now.hour * 60 + now.minute;

        if (TimeNow >= TimeIn - shift.time && TimeNow <= TimeIn + shift.time) {
          selectedShift =
              'Chấm công ${shift.ca} (${shift.GioVao.hour.toString().padLeft(2, '0')}:${shift.GioVao.minute.toString().padLeft(2, '0')} - ${shift.GioRa.hour.toString().padLeft(2, '0')}:${shift.GioRa.minute.toString().padLeft(2, '0')})';
          isCheckedOut = false;

          return;
        } else if (TimeNow >= TimeIn - shift.time &&
            TimeNow <= TimeOut - shift.time) {
          selectedShift =
              '${shift.ca} (${shift.GioVao.hour.toString().padLeft(2, '0')}:${shift.GioVao.minute.toString().padLeft(2, '0')} - ${shift.GioRa.hour.toString().padLeft(2, '0')}:${shift.GioRa.minute.toString().padLeft(2, '0')})';
          return;
        } else if (TimeNow >= TimeOut - shift.time &&
            TimeNow <= TimeOut + shift.time) {
          selectedShift =
              'Ra ${shift.ca}(${shift.GioVao.hour.toString().padLeft(2, '0')}:${shift.GioVao.minute.toString().padLeft(2, '0')} - ${shift.GioRa.hour.toString().padLeft(2, '0')}:${shift.GioRa.minute.toString().padLeft(2, '0')})';
          isCheckedIn = false;
          return;
        }
      }
    }

    selectedShift = 'Không có ca';
    update();
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
}
