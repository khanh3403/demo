import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/pages/ChamCong/chamcong_controller.dart';
import 'package:salesoft_hrm/pages/ChamCong/list_chamcong_controller.dart';
import 'package:salesoft_hrm/pages/ChamCong/list_chamcong_item.dart';
import 'package:salesoft_hrm/resources/app_resource.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';
import 'package:salesoft_hrm/widgets/empty_data_widget.dart';

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
        return DefaultTabController(
          length: 2, 
          child: Scaffold(
            appBar: AppBar(
              leading: const BackButtonWidget(),
              backgroundColor: AppColors.blueVNPT,
              centerTitle: false,
              elevation: 0,
              title: const TitleAppBarWidget(title: "Chấm công"),
              bottom:const TabBar(
                indicatorColor: AppColors.blueVNPT, 
                labelColor: AppColors.blue50, 
                unselectedLabelColor: Colors.black,
                tabs: const [
                  Tab(text: "Chấm công"),
                  Tab(text: "Lịch sử chấm công"),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                _buildChamCongTab(context),
                _buildLichSuChamCongTab(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChamCongTab(BuildContext context) {
    return GetBuilder<checkinController>(
      builder: (controller) {
        return Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppResource.icBackground),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.only(
                    top: AppConstant.getScreenSizeHeight(context) * 0.01),
                child: Column(
                  children: [
                    controller.currentLocation == null
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                              top: AppConstant.getScreenSizeHeight(context) *
                                  0.05,
                              left: 16.0,
                              right: 16.0,
                            ),
                            child: Container(
                              width: AppConstant.getScreenSizeWidth(context) *
                                  0.96,
                              height:
                                  AppConstant.getScreenSizeHeight(context) *
                                      0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Stack(
                                  children: [
                                    GoogleMap(
                                      onMapCreated: (controller2) {
                                        controller.googleMapController1 =
                                            controller2;
                                      },
                                      initialCameraPosition: CameraPosition(
                                        target: controller.currentLocation !=
                                                null
                                            ? LatLng(
                                                controller.currentLocation!
                                                    .latitude,
                                                controller.currentLocation!
                                                    .longitude,
                                              )
                                            : const LatLng(0, 0),
                                        zoom: 14,
                                      ),
                                      rotateGesturesEnabled: true,
                                      zoomControlsEnabled: false,
                                      tiltGesturesEnabled: true,
                                      myLocationEnabled: true,
                                      myLocationButtonEnabled: false,
                                      markers:
                                          Set<Marker>.of(controller.markers),
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
                          ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.04,
                    ),
                    Container(
                      width: AppConstant.getScreenSizeWidth(context) * 0.93,
                      height: AppConstant.getScreenSizeHeight(context) * 0.07,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.blueVNPT,
                      ),
                      child: Row(children: [
                        SizedBox(
                            width: AppConstant.getScreenSizeWidth(context) *
                                0.01),
                        Flexible(
                          flex: 4,
                          child: Text(
                            'Chọn văn phòng: ',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: AppColors.blue50,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                          ),
                        ),
                        SizedBox(
                            width: AppConstant.getScreenSizeWidth(context) *
                                0.02),
                        Flexible(
                          flex: 6,
                          child: GestureDetector(
                            onTap: () {
                              _showBottomSheet(
                                  context, controller.offices, controller);
                            },
                            child: controller.selectedOffice != null
                                ? Text(
                                    controller.selectedOffice!.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: AppColors.approved,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                  )
                                : Text(
                                    ' ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: AppColors.orMainTitle,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                  ),
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(
                          left: AppConstant.getScreenSizeWidth(context) * 0.035),
                      child: const Text(
                        'Chọn ca làm việc:',
                        style: TextStyle(color: AppColors.blue50, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                AppConstant.getScreenSizeWidth(context) * 0.03),
                        child: ListView.builder(
                          itemCount: controller.ca.length,
                          itemBuilder: (context, index) {
                            final shift = controller.ca[index];
                            return Card(
                              child: ListTile(
                                leading: Checkbox(
                                  value: controller.selectedShift ==
                                      '${shift.ten} (${shift.gioVao} - ${shift.gioRa})',
                                  onChanged: (bool? value) {
                                    if (value == true) {
                                      controller.selectedShift =
                                          '${shift.ten} (${shift.gioVao} - ${shift.gioRa})';
                                      controller.selectedShiftMa == shift.ma;
                                      controller.update();
                                    } else {}
                                  },
                                ),
                                title: Text(
                                  shift.ten!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle:
                                    Text('${shift.gioVao} - ${shift.gioRa}'),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    Container(
                      width: AppConstant.getScreenSizeHeight(context) * 0.8,
                      padding: EdgeInsets.only(
                        bottom:
                            AppConstant.getScreenSizeHeight(context) * 0.05,
                        left: AppConstant.getScreenSizeWidth(context) * 0.03,
                        right: AppConstant.getScreenSizeWidth(context) * 0.03,
                      ),
                      child: CupertinoButton(
                        color: AppColors.blueVNPT,
                        onPressed: () async {
                          controller.checkIn();
                        },
                        child: const Text('Chấm công'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

Widget _buildLichSuChamCongTab(BuildContext context) {
  final ListChamCongController controller = Get.put(ListChamCongController());

  return Container(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Container(
          color: AppColors.blueVNPT,
          child:const Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: Text(
                      'Thời gian',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: Text(
                      'Hình thức',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: Text(
                      'Xem chi tiết',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10), 
        Expanded(
          child: controller.obx(
            (contentDisplay) {
              return SmartRefresher(
                controller: controller.refreshController,
                enablePullDown: true,
                enablePullUp: false,
                onRefresh: () async {
                  controller.fetchListContent();
                  controller.refreshController.refreshCompleted();
                },
                onLoading: () async {
                  controller.fetchListContent(isLoadMore: true);
                  controller.refreshController.loadComplete();
                },
                child: ListView.builder(
                  itemCount: contentDisplay?.items.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = contentDisplay?.items[index];
                    return ListChamCongItemView(
                      caLamViec: item?.caLamViec ?? '',
                      diaDiem: item?.diaDiem ?? '',
                      checkIn: item?.checkIn ?? false,
                      thoiGian: item?.thoiGian ?? '',
                      lyDo: item?.lyDo ?? '',
                    );
                  },
                ),
              );
            },
            onEmpty: const EmptyDataWidget(),
            onError: (error) => Center(child: Text('Có lỗi xảy ra: $error')),
          ),
        ),
      ],
    ),
  );
}





  void _showBottomSheet(
      BuildContext context, List<Location> offices, checkinController controller) {
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
