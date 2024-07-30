

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/pages/ThongBao/thongbao_controller.dart';
import 'package:salesoft_hrm/pages/ThongBao/thongbao_item.dart';
import 'package:salesoft_hrm/widgets/empty_data_widget.dart';

class ThongBaoPage extends StatelessWidget {
  ThongBaoPage({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ThongBaoController());

    

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.05,
        ),
        
        const SizedBox(height: 30),
        
        Expanded(
          child: controller.obx(
            (contentDisplay) {
              return SmartRefresher(
                controller: controller.refreshController,
                enablePullDown: false,
                enablePullUp: false,
                onRefresh: () => {controller.fetchListContent()},
                onLoading: () =>
                    {controller.fetchListContent(isLoadMore: true)},
                child: ListView.builder(
                  itemCount: contentDisplay?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ThongBaoItemView(
                      tieuDe: contentDisplay?.data?[index].tieuDe,
                      noiDung: contentDisplay?.data?[index].noiDung,
                      date1: contentDisplay?.data?[index].date1,
                     
                      // onTap: (ma) {
                      //   final dtController = Get.put(DtController());
                      //   dtController.fetchUserInfo(ma!);
                      //   Get.toNamed(
                      //     ERouter.danhba_dt.name,
                      //     arguments: {'ma': ma},
                      //   );
                      // },
                    );
                  },
                ),
              );
            },
            onEmpty: const EmptyDataWidget(),
          ),
        ),
      ],
    );
  }
}
