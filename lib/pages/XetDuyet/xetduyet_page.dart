import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/pages/XetDuyet/xetduyet_controller.dart';
import 'package:salesoft_hrm/pages/XetDuyet/xetduyet_item.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';
import 'package:salesoft_hrm/widgets/empty_data_widget.dart';

class XetDuyetPage extends StatefulWidget {
  const XetDuyetPage({super.key});

  @override
  State<XetDuyetPage> createState() => _XetDuyetPageState();
}

class _XetDuyetPageState extends State<XetDuyetPage> {
  final controller = Get.put(XetDuyetController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Số lượng tab
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButtonWidget(),
          backgroundColor: AppColors.blueVNPT,
          centerTitle: false,
          elevation: 0,
          title: TitleAppBarWidget(title: "Xét duyệt"),
          bottom:const TabBar(
                indicatorColor: AppColors.blueVNPT, 
                labelColor: AppColors.blue50, 
                unselectedLabelColor: Colors.black,
                tabs: const [
                  Tab(text: "Xét duyệt"),
                  Tab(text: "Đã duyệt"),
                ],
              ),
        ),
        body: TabBarView(
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),
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
                            itemCount: contentDisplay?.length ?? 0,
                            itemBuilder: (context, index) {
                              final item = contentDisplay?[index];
                              return XetDuyetItemView(
                                loai: item?.loai ?? '',
                                noiDung: item?.noiDung ?? '',
                                tinhTrang: item?.tinhTrang,
                                ngay: item?.ngay ?? '',
                                dieuKien: item?.dieuKien ?? '',
                                capDuyet: item?.capDuyet ?? '',
                                id: item?.id,
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
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Expanded(
                    child: controller.obx(
                      (contentApproved) {
                        return SmartRefresher(
                          controller: controller.refreshController,
                          enablePullDown: true,
                          enablePullUp: false,
                          onRefresh: () async {
                            // controller.fetchApprovedListContent(); 
                            controller.refreshController.refreshCompleted();
                          },
                          onLoading: () async {
                            // controller.fetchApprovedListContent(isLoadMore: true); 
                            controller.refreshController.loadComplete();
                          },
                          child: ListView.builder(
                            itemCount: contentApproved?.length ?? 0,
                            itemBuilder: (context, index) {
                              final item = contentApproved?[index];
                              return XetDuyetItemView(
                                loai: item?.loai ?? '',
                                noiDung: item?.noiDung ?? '',
                                tinhTrang: item?.tinhTrang,
                                ngay: item?.ngay ?? '',
                                dieuKien: item?.dieuKien ?? '',
                                capDuyet: item?.capDuyet ?? '',
                                id: item?.id,
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
            ),
          ],
        ),
      ),
    );
  }
}
