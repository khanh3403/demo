import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/app_global.dart';
import 'package:salesoft_hrm/pages/ChamCong/chamcong_controller.dart';
import 'package:salesoft_hrm/widgets/appbar_container_widget.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';

class ChamCongPage extends StatefulWidget {
  const ChamCongPage({Key? key}) : super(key: key);

  @override
  _ChamCongPageState createState() => _ChamCongPageState();
}

class _ChamCongPageState extends State<ChamCongPage> {
  final checkinController controller = Get.put(checkinController());

  @override
  void initState() {
    super.initState();
    controller.distanceController.text = "100";
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      controller.updateMarkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<checkinController>(
      builder: (controller) {
        return Stack(
          children: [
            AppBarContainerWidget(
              title: const Text(
                'Chấm Công',
                style: TextStyle(color: Colors.white),
              ),
              body: controller.currentLocation == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.green,
                              height: 300,
                              child: Stack(
                                children: [
                                  GoogleMap(
                                    onMapCreated: (controller2) {
                                      controller.googleMapController1 =
                                          controller2;
                                    },
                                    initialCameraPosition: CameraPosition(
                                      target: controller.currentLocation != null
                                          ? LatLng(
                                              controller
                                                  .currentLocation!.latitude,
                                              controller
                                                  .currentLocation!.longitude)
                                          : LatLng(0, 0),
                                      zoom: 14,
                                    ),
                                    rotateGesturesEnabled: true,
                                    zoomControlsEnabled: false,
                                    tiltGesturesEnabled: true,
                                    myLocationEnabled: true,
                                    myLocationButtonEnabled: false,
                                    markers: Set<Marker>.of(controller.markers),
                                  ),
                                  Positioned(
                                    bottom: 16.0,
                                    right: 16.0,
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        controller.getCurrentLocation2(1);
                                      },
                                      child: const Icon(
                                        Icons.my_location,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            Positioned(
              top: AppConstant.getScreenSizeHeight(context) / 8,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 80,
                    height: 120,
                    child: Card(
                      elevation: 6,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 30),
                            Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(children: [
                                      Expanded(
                                        flex: 7,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                _showBottomSheet(
                                                    context,
                                                    controller.offices,
                                                    controller);
                                              },
                                              child: controller
                                                          .selectedOffice !=
                                                      null
                                                  ? Text(
                                                      controller
                                                          .selectedOffice!.name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge
                                                          ?.copyWith(
                                                            color: AppColors
                                                                .approved,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                          ),
                                                    )
                                                  : Text(
                                                      'Chọn văn phòng',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge
                                                          ?.copyWith(
                                                            color: AppColors
                                                                .orMainTitle,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                          ),
                                                    ),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              '${controller.selectedShift}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                    color: AppColors.approved,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: IconButton(
                                          icon:
                                              const Icon(Icons.settings_sharp),
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      const Text(
                                                        'Nhập khoảng cách chấm công',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      TextField(
                                                        controller: controller
                                                            .distanceController,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText:
                                                              'Khoảng cách (m)',
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text('Lưu'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      )
                                    ]),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            Map<Permission, PermissionStatus>
                                                statuses = await [
                                              Permission.location,
                                              Permission.locationWhenInUse,
                                            ].request();

                                            if (statuses.values.every(
                                                (status) =>
                                                    status ==
                                                    PermissionStatus
                                                        .granted)) {}

                                            if (statuses.values.every(
                                                (status) =>
                                                    status ==
                                                    PermissionStatus.denied)) {
                                              showToast(
                                                "Bạn cần cấp quyền vị trí cho ứng dụng này",
                                              );
                                            }
                                            controller.checkIn();
                                          },
                                          child: const Text('Chấm công'),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context, List<Location> offices,
      checkinController controller) {
    Future.delayed(Duration.zero, () {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 200,
                child: ListView.builder(
                  itemCount: offices.length,
                  itemBuilder: (context, index) {
                    Location office = offices[index];
                    return ListTile(
                      title: Text(office.name),
                      onTap: () {
                        setState(() {
                          controller.toggleSelectedOffice(office.name);
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      );
    });
  }
}
