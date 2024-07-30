import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/provider/nghiphep_provider.dart';
import 'package:salesoft_hrm/API/repository/loainghi_repository.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/pages/NghiPhep/nghiphep_controller.dart';
import 'package:salesoft_hrm/pages/NghiPhep/nghiphep_item.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';
import 'package:salesoft_hrm/API/provider/loainghi_provider.dart';
import 'package:salesoft_hrm/model/loainghi_model.dart';
import 'package:salesoft_hrm/widgets/empty_data_widget.dart';

class NghiPhepPage extends StatefulWidget {
  const NghiPhepPage({super.key});

  @override
  _NghiPhepPageState createState() => _NghiPhepPageState();
}

class _NghiPhepPageState extends State<NghiPhepPage> {
  final controller = Get.put(NghiPhepController());
  String? _selectedMonth;
  String? _selectedYear;
  List<String> _months = [];
  List<String> _years = [];
  List<LoaiNghi> _loaiNghiList = [];
  LoaiNghi? _selectedLoaiNghi;

  @override
  void initState() {
    super.initState();
    _initializeMonthsAndYears();
    _fetchLoaiNghi();
    _setCurrentMonthAndYear();
  }

  void _initializeMonthsAndYears() {
    _months = List.generate(12, (index) {
      final month = DateTime(0, index + 1).toLocal();
      return '${month.month.toString().padLeft(2, '0')}';
    });
    _years = List.generate(11, (index) => (2020 + index).toString());
  }

  void _setCurrentMonthAndYear() {
    final now = DateTime.now();
    _selectedMonth = now.month.toString().padLeft(2, '0');
    _selectedYear = now.year.toString();
    _search();
  }

  void _search() {
    controller.thang = _selectedMonth ?? '';
    controller.nam = _selectedYear ?? '';
    controller.fetchListContent();
  }

  Future<void> _fetchLoaiNghi() async {
    final provider = LoaiNghiProviderAPI();
    final repository = LoaiNghiRepository(provider: provider);

    try {
      final loaiNghiResponse =
          await repository.getLoaiNghi(table: 'DM_LoaiNghi');
      if (loaiNghiResponse != null) {
        setState(() {
          _loaiNghiList = loaiNghiResponse.data;
          if (_loaiNghiList.isNotEmpty) {
            _selectedLoaiNghi = _loaiNghiList.first;
          } else {
            _selectedLoaiNghi = null;
          }
        });
      }
    } catch (e) {
      print('Error fetching LoaiNghi: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonWidget(),
        backgroundColor: AppColors.blueVNPT,
        centerTitle: false,
        elevation: 0,
        title: Row(
          children: [
            const Expanded(
                flex: 9, child: TitleAppBarWidget(title: "Đăng ký nghỉ")),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  _showLoaiNghiDialog(context);
                },
                child: const FaIcon(FontAwesomeIcons.circlePlus,
                    color: AppColors.blue50),
              ),
            ),
          ],
        ),
      ),
      body: Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
         
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: TextButton(
            //     style: TextButton.styleFrom(
            //       backgroundColor: Colors.green,
            //       padding: const EdgeInsets.symmetric(
            //           vertical: 12.0, horizontal: 24.0),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8.0),
            //       ),
            //     ),
            //     onPressed: () {
            //       _showLoaiNghiDialog(context);
            //     },
            //     child: const Row(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         Icon(Icons.add, color: Colors.white),
            //         SizedBox(width: 8.0),
            //         Text(
            //           'Đăng ký nghỉ',
            //           style: TextStyle(color: Colors.white, fontSize: 16.0),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: DropdownButton<String>(
                          value: _selectedMonth,
                          items: _months.map((month) {
                            return DropdownMenuItem<String>(
                              value: month,
                              child: Text(month),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedMonth = value;
                            });
                          },
                          isExpanded: true,
                          underline:const SizedBox(),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        flex: 2,
                        child: DropdownButton<String>(
                          value: _selectedYear,
                          items: _years.map((year) {
                            return DropdownMenuItem<String>(
                              value: year,
                              child: Text(year),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedYear = value;
                            });
                          },
                          isExpanded: true,
                          underline:const SizedBox(),
                        ),
                      ),
                      IconButton(
                        icon:const Icon(Icons.search),
                        onPressed: () {
                          _search();
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              color: AppColors.blueVNPT,
              child: const Row(
                children: [
                  Expanded(
                    flex: 40,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                        child: Text(
                          'Loại nghỉ',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                    ),
                  ),
                  Expanded(
                    flex: 30,
                        child: Text(
                          'Thời gian',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                  ),
                  Expanded(
                    flex: 30,
                        child: Text(
                          'Tình trạng',
                          style: TextStyle(color: Colors.white, fontSize: 12),
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
                      itemCount: contentDisplay?.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = contentDisplay?.data?[index];
                        return ListNghiPhepItemView(
                          loaiNghi: item?.ten ?? '',
                          lyDo: item?.lyDo ?? '',
                          tinhTrang: item?.tinhTrang,
                          soLuong: item?.soLuong?.toString() ?? '',
                          tuNgay: item?.tuNgay,
                          denNgay: item?.denNgay,
                        );
                      },
                    ),
                  );
                },
                onEmpty: const EmptyDataWidget(),
                onError: (error) =>
                    Center(child: Text('Có lỗi xảy ra: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }

void showMonthYearBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      int selectedYear = DateTime.now().year;
      int selectedMonth = DateTime.now().month;

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Chọn Tháng và Năm',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<int>(
                      value: selectedMonth,
                      items: List.generate(12, (index) {
                        return DropdownMenuItem(
                          value: index + 1,
                          child: Text(DateFormat.MMMM().format(DateTime(0, index + 1))),
                        );
                      }),
                      onChanged: (value) {
                        setState(() {
                          selectedMonth = value!;
                        });
                      },
                    ),
                    SizedBox(width: 20),
                    DropdownButton<int>(
                      value: selectedYear,
                      items: List.generate(100, (index) {
                        return DropdownMenuItem(
                          value: 2024 - index,
                          child: Text((2024 - index).toString()),
                        );
                      }),
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'month': selectedMonth,
                      'year': selectedYear,
                    });
                  },
                  child:const Text('Xong'),
                ),
              ],
            ),
          );
        },
      );
    },
  ).then((value) {
    if (value != null) {
      int selectedMonth = value['month'];
      int selectedYear = value['year'];
      print('Selected month: $selectedMonth, Selected year: $selectedYear');
    }
  });
}

  void _showLoaiNghiDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:const Text('Chọn loại nghỉ'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title:const Text('Một ngày'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showOneDayForm(context);
                },
              ),
              ListTile(
                title:const Text('Nhiều ngày'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showMultipleDaysForm(context);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child:const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showOneDayForm(BuildContext context) async {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController ngayNghiController = TextEditingController();
    final TextEditingController lyDoController = TextEditingController();
    String? selectedBuoiNghi = 'Cả ngày';

    final ngayNghi = DateFormat('yyyy/MM/dd').format(DateTime.now());
    ngayNghiController.text = ngayNghi;

    final authService = Get.find<AuthService>();
    final ma = await authService.ma;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:const Text('Đăng ký nghỉ - Một ngày'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: ngayNghiController,
                  decoration: InputDecoration(
                    labelText: 'Ngày nghỉ',
                    suffixIcon: IconButton(
                      icon:const Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime now = DateTime.now();
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: now,
                          lastDate: DateTime(2100),
                        );
                        if (selectedDate != null) {
                          ngayNghiController.text =
                              DateFormat('yyyy/MM/dd').format(selectedDate);
                        }
                      },
                    ),
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập ngày nghỉ';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: selectedBuoiNghi,
                  decoration:const InputDecoration(
                    labelText: 'Buổi nghỉ',
                  ),
                  items: ['Cả ngày', 'Buổi sáng', 'Buổi chiều']
                      .map((buoi) => DropdownMenuItem<String>(
                            value: buoi,
                            child: Text(buoi),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedBuoiNghi = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng chọn buổi nghỉ';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<LoaiNghi>(
                  value: _selectedLoaiNghi,
                  decoration:const InputDecoration(
                    labelText: 'Loại nghỉ',
                  ),
                  items: _loaiNghiList
                      .map((loai) => DropdownMenuItem<LoaiNghi>(
                            value: loai,
                            child: Text(loai.ten ?? ''),
                          ))
                      .toList(),
                  onChanged: (LoaiNghi? newValue) {
                    setState(() {
                      _selectedLoaiNghi = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Vui lòng chọn loại nghỉ';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: lyDoController,
                  decoration:const InputDecoration(
                    labelText: 'Lý do',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập lý do';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child:const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:const Text('Xác nhận'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final ngayNghi = ngayNghiController.text;
                  final buoiNghi = selectedBuoiNghi ?? 'Cả ngày';
                  final lyDo = lyDoController.text;
                  final ngayDangKy =
                      DateFormat('yyyy/MM/dd').format(DateTime.now());

                  try {
                    final provider = NghiPhepProviderAPI();
                    if (ma != null && _selectedLoaiNghi != null) {
                      await provider.postNghiPhep(
                        tuNgay: ngayNghi,
                        denNgay: ngayNghi,
                        buoiNghi: buoiNghi,
                        loaiNghi: _selectedLoaiNghi!.ma!,
                        ngayDangKy: ngayDangKy,
                        lyDo: lyDo,
                        ma: ma,
                      );

                      Get.snackbar('Thông báo', 'Đăng ký nghỉ thành công.',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: AppColors.blueVNPT);
                    } else {
                      Get.snackbar(
                          'Thông báo', 'Đăng ký nghỉ không thành công.',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: AppColors.blueVNPT);
                      print(
                          'Ma không được cung cấp hoặc loại nghỉ không được chọn.');
                    }
                  } catch (e) {
                    print('Error posting data: $e');
                  }

                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showMultipleDaysForm(BuildContext context) async {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController tuNgayController = TextEditingController();
    final TextEditingController denNgayController = TextEditingController();
    final TextEditingController lyDoController = TextEditingController();
    LoaiNghi? _selectedLoaiNghi;

    final today = DateFormat('yyyy/MM/dd').format(DateTime.now());
    tuNgayController.text = today;
    denNgayController.text = today;

    final authService = Get.find<AuthService>();
    final ma = await authService.ma;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:const Text('Đăng ký nghỉ - Nhiều ngày'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: tuNgayController,
                  decoration: InputDecoration(
                    labelText: 'Từ ngày',
                    suffixIcon: IconButton(
                      icon:const Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime now = DateTime.now();
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: now,
                          lastDate: DateTime(2100),
                        );
                        if (selectedDate != null) {
                          tuNgayController.text =
                              DateFormat('yyyy/MM/dd').format(selectedDate);
                        }
                      },
                    ),
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập ngày bắt đầu';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: denNgayController,
                  decoration: InputDecoration(
                    labelText: 'Đến ngày',
                    suffixIcon: IconButton(
                      icon:const Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime now = DateTime.now();
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: now,
                          lastDate: DateTime(2100),
                        );
                        if (selectedDate != null) {
                          denNgayController.text =
                              DateFormat('yyyy/MM/dd').format(selectedDate);
                        }
                      },
                    ),
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập ngày kết thúc';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<LoaiNghi>(
                  value: _selectedLoaiNghi,
                  decoration: InputDecoration(
                    labelText: 'Loại nghỉ',
                  ),
                  items: _loaiNghiList
                      .map((loai) => DropdownMenuItem<LoaiNghi>(
                            value: loai,
                            child: Text(loai.ten ?? ''),
                          ))
                      .toList(),
                  onChanged: (LoaiNghi? newValue) {
                    setState(() {
                      _selectedLoaiNghi = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Vui lòng chọn loại nghỉ';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: lyDoController,
                  decoration: InputDecoration(
                    labelText: 'Lý do',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập lý do';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Xác nhận'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final tuNgay = tuNgayController.text;
                  final denNgay = denNgayController.text;
                  final lyDo = lyDoController.text;
                  final ngayDangKy =
                      DateFormat('yyyy/MM/dd').format(DateTime.now());

                  try {
                    final provider = NghiPhepProviderAPI();
                    if (ma != null && _selectedLoaiNghi != null) {
                      await provider.postNghiPhep(
                        tuNgay: tuNgay,
                        denNgay: denNgay,
                        buoiNghi: 'Cả ngày',
                        loaiNghi: _selectedLoaiNghi!.ma!,
                        ngayDangKy: ngayDangKy,
                        lyDo: lyDo,
                        ma: ma,
                      );

                      Get.snackbar('Thông báo', 'Đăng ký nghỉ thành công.',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: AppColors.blueVNPT);
                    } else {
                      Get.snackbar(
                          'Thông báo', 'Đăng ký nghỉ không thành công.',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: AppColors.blueVNPT);
                      print(
                          'Ma không được cung cấp hoặc loại nghỉ không được chọn.');
                    }
                  } catch (e) {
                    print('Error posting data: $e');
                  }

                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
