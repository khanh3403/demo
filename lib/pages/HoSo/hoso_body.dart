import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/router.dart';
import 'package:salesoft_hrm/resources/app_resource.dart';

class HoSoBody extends StatefulWidget {
  const HoSoBody({super.key});

  @override
  State<HoSoBody> createState() => _HoSoBodyState();
}

class _HoSoBodyState extends State<HoSoBody> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 100,
      ),
      Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(ERouter.information.name);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        AppResource.icUser,
                        width: 24,
                        height: 24,
                        fit: BoxFit.fill,
                        color: AppColors.approved,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          'Sơ yếu lý lịch',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    height: 1.5,
                                    fontSize: 18,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      const Expanded(
                        flex: 2,
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 2,
                height: 1,
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(ERouter.quanhe.name);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        AppResource.icUser,
                        width: 24,
                        height: 24,
                        fit: BoxFit.fill,
                        color: AppColors.approved,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          'Quan hệ gia đình',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    height: 1.5,
                                    fontSize: 18,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      const Expanded(
                        flex: 2,
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 2,
                height: 1,
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: GestureDetector(
                  child: Row(
                    children: [
                      Image.asset(
                        AppResource.icUser,
                        width: 24,
                        height: 24,
                        fit: BoxFit.fill,
                        color: AppColors.approved,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          'Quá trình lương',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    height: 1.5,
                                    fontSize: 18,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      const Expanded(
                        flex: 2,
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 2,
                height: 1,
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(ERouter.qtCongTac.name);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        AppResource.icUser,
                        width: 24,
                        height: 24,
                        fit: BoxFit.fill,
                        color: AppColors.approved,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          'Quá trình công tác',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    height: 1.5,
                                    fontSize: 18,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      const Expanded(
                        flex: 2,
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 2,
                height: 1,
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(ERouter.ktkl.name);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        AppResource.icUser,
                        width: 24,
                        height: 24,
                        fit: BoxFit.fill,
                        color: AppColors.approved,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          'Khen thưởng, kỷ luật',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    height: 1.5,
                                    fontSize: 18,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      const Expanded(
                        flex: 2,
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          )),
    ]);
  }
}
