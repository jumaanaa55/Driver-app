import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raya_express_driver/core/constant/app_color.dart';
import 'package:raya_express_driver/core/theme/theme_cubit.dart';

class ReceivedOrdersView extends StatefulWidget {
  const ReceivedOrdersView({super.key});

  @override
  State<ReceivedOrdersView> createState() => _ReceivedOrdersViewState();
}

class _ReceivedOrdersViewState extends State<ReceivedOrdersView> {
  @override
  Widget build(BuildContext context) {
    final isDark =
        context.watch<ThemeCubit>().state == ThemeMode.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                  AppColors.darkPrimary,
                  AppColors.darkSecondary,
                ]
                    : [
                  AppColors.primaryBlue,
                  AppColors.electricBlue,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.r),
                bottomRight: Radius.circular(40.r),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding:
                EdgeInsets.fromLTRB(8.w, 8.h, 16.w, 20.h),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Received Orders".tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
            ),
          ),

          // Body
          const Expanded(
            child: _EmptyState(),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 60.sp,
              color: AppColors.gray,
            ),
            SizedBox(height: 16.h),
            Text(
              "No Orders Found".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.gray,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "There are currently no received orders."
                  .tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.gray,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}