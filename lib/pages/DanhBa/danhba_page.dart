import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_controller.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_item.dart';
import 'package:salesoft_hrm/widgets/empty_data_widget.dart';

class DanhBaPage extends StatelessWidget {
  DanhBaPage({Key? key}) : super(key: key);

  final TextEditingController searchController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DanhBaController());

    searchController.addListener(() {
      controller.searchDanhBa(searchController.text);
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 16),
          SearchBar(
            controller: searchController,
            hintText: 'Tìm kiếm...',
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ),
         
          const SizedBox(height: 16),
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
                      return DanhBaItemView(
                        kh: contentDisplay?.data?[index].kh,
                        hoDem: contentDisplay?.data?[index].hoDem,
                        ten: contentDisplay?.data?[index].ten,
                        phongban: contentDisplay?.data?[index].phongBan,
                        email: contentDisplay?.data?[index].email,
                        gioiTinh: contentDisplay?.data?[index].gioiTinh,
                      );
                    },
                  ),
                );
              },
              onEmpty: const EmptyDataWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
