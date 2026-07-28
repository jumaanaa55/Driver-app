import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raya_express_driver/core/constant/app_color.dart';
import 'package:raya_express_driver/core/theme/theme_cubit.dart';
import 'package:raya_express_driver/features/login/presentation/login_view.dart';
import 'package:raya_express_driver/features/notification/notification_view.dart';
import 'package:raya_express_driver/features/release_order/release_order.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      // Everything below fits in one static screen — no scrolling.
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 12.h),

              // ---- Top Bar ----
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: AppColors.primaryBlue,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20.r),
                      onTap: () {
                        if (context.locale.languageCode == 'en') {
                          context.setLocale(const Locale('ar'));
                        } else {
                          context.setLocale(const Locale('en'));
                        }
                      },
                      child: Center(
                        child: Text(
                          context.locale.languageCode == 'en' ? 'AR' : 'EN',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: AppColors.primaryBlue,
                    child: IconButton(
                      onPressed: () {
                        context.read<ThemeCubit>().changeTheme();
                      },
                      icon: const Icon(Icons.dark_mode, size: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: AppColors.primaryBlue,
                    child: IconButton(
                      icon: const Icon(Icons.notifications, color: Colors.white, size: 18),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const NotificationView()),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      decoration: BoxDecoration(
                        color: AppColors.electricBlue,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.badge, color: Colors.white, size: 16),
                          SizedBox(width: 6.w),
                          Text(
                            "Driver".tr(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    flex: 2,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginView()),
                        );
                      },
                      icon: const Icon(Icons.logout, size: 16),
                      label: Text("logout".tr(), style: TextStyle(fontSize: 12.sp)),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: AppColors.primaryBlue),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12.h),

              // ---- Logo + Welcome ----
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 110.w,
                      height: 110.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.icon, width: 2),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(6.w),
                        child: ClipOval(
                          child: Image.asset("assets/images/logo.jpeg", fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Welcome".tr(),
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Raya Express Driver APP",
                      style: TextStyle(color: AppColors.gray, fontSize: 16.sp),
                    ),
                  ],
                ),
              ),

              // ---- Quick Actions Header ----
              Row(
                children: [
                  Container(width: 4, height: 18, color: AppColors.icon),
                  SizedBox(width: 8.w),
                  Text(
                    "Quick Actions".tr(),
                    style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.h),

              // ---- Quick Action Cards (fills remaining space, no scroll) ----
              Expanded(
                flex: 6,
                child: Column(
                  children: [
                    Expanded(
                      child: buildLargeCard(
                        context,
                        icon: Icons.inventory_2_outlined,
                        title: "Received Orders".tr(),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            child: buildSmallCard(
                              context,
                              icon: Icons.local_shipping_outlined,
                              title: "delivery".tr(),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const ReleaseOrder()),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 14.w),
                          Expanded(
                            child: buildSmallCard(
                              context,
                              icon: Icons.location_on_outlined,
                              title: "pickup".tr(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Expanded(
                      child: buildLargeCard(
                        context,
                        icon: Icons.upload,
                        title: "upload_delivery".tr(),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 8.h),
            ],
          ),
        ),
      ));
        }

  // Large Card
  Widget buildLargeCard(
      BuildContext context, {
        required IconData icon,
        required String title,
      }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: AppColors.electricBlue,
            child: Icon(icon, color: AppColors.background, size: 26.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  "Tap to continue".tr(),
                  style: TextStyle(color: AppColors.gray, fontSize: 12.sp),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: AppColors.primaryBlue, size: 16.sp),
        ],
      ),
    );
  }

  // Small Card
  Widget buildSmallCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        VoidCallback? onTap,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 22.r,
                backgroundColor: AppColors.electricBlue,
                child: Icon(icon, color: AppColors.background, size: 26.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryBlue,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              Text(
                "open".tr(),
                style: TextStyle(color: AppColors.gray, fontSize: 11.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}