import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raya_express_driver/core/constant/app_color.dart';


enum OrderStatus { inDeliveredCycle, waiting, delivered, cancelled }

class OrderModel {
  final String authorizationNumber;
  final String orderNumber;
  final OrderStatus status;
  final String customerName;
  final String customerArea;
  final String phone;
  final String city;
  final String mapLabel;

  const OrderModel({
    required this.authorizationNumber,
    required this.orderNumber,
    required this.status,
    required this.customerName,
    required this.customerArea,
    required this.phone,
    required this.city,
    required this.mapLabel,
  });
}



class ReleaseOrder extends StatefulWidget {
  const ReleaseOrder({super.key});

  @override
  State<ReleaseOrder> createState() => _ReleaseOrderState();
}

class _ReleaseOrderState extends State<ReleaseOrder>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;


  final List<OrderModel> _currentOrders = const [
    OrderModel(
      authorizationNumber: "889642",
      orderNumber: "907159",
      status: OrderStatus.inDeliveredCycle,
      customerName: "Marwan Phone - Abnod qena",
      customerArea: "مروان فون  ابنود",
      phone: "01029254276",
      city: "مدينة كفت",
      mapLabel: "The Map",
    ),
  ];

  final List<OrderModel> _waitingOrders = const [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          // ---- Gradient header (app bar + search) ----
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [AppColors.darkPrimary, AppColors.darkSecondary]
                    : [AppColors.primaryBlue, AppColors.electricBlue],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.r),
                bottomRight: Radius.circular(40.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryBlue.withValues(alpha: 0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(8.w, 4.h, 16.w, 18.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        Expanded(
                          child: Text(
                            "Release Order".tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() => _isSearching = !_isSearching);
                          },
                          icon: Icon(
                            _isSearching ? Icons.close : Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    // Animated search field
                    AnimatedSize(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeInOut,
                      child: _isSearching
                          ? Padding(
                        padding: EdgeInsets.only(top: 6.h),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "search_orders".tr(),
                              hintStyle: TextStyle(
                                color: AppColors.gray,
                                fontSize: 14.sp,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.primaryBlue,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ),
                      )
                          : const SizedBox.shrink(),
                    ),

                    SizedBox(height: 16.h),

                    // ---- Segmented tab control ----
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        labelColor: AppColors.primaryBlue,
                        unselectedLabelColor: Colors.white,
                        labelStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        unselectedLabelStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        tabs: [
                          Tab(text: "current_orders".tr()),
                          Tab(text: "waiting_orders".tr()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ---- Order lists ----
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrderList(_currentOrders),
                _buildOrderList(_waitingOrders),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList(List<OrderModel> orders) {
    if (orders.isEmpty) {
      return _EmptyState();
    }
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 24.h),
      itemCount: orders.length,
      separatorBuilder: (_, _) => SizedBox(height: 14.h),
      itemBuilder: (context, index) => _OrderCard(order: orders[index]),
    );
  }
}

// Order card

class _OrderCard extends StatelessWidget {
  final OrderModel order;
  const _OrderCard({required this.order});

  _StatusStyle get _statusStyle {
    switch (order.status) {
      case OrderStatus.inDeliveredCycle:
        return _StatusStyle(
          label: "in_delivered_cycle".tr(),
          color: const Color(0xFF2E9E5B),
          bg: const Color(0xFFE7F7EE),
          icon: Icons.check_circle,
        );
      case OrderStatus.waiting:
        return _StatusStyle(
          label: "waiting".tr(),
          color: const Color(0xFFC98A1B),
          bg: const Color(0xFFFCF1DD),
          icon: Icons.hourglass_bottom,
        );
      case OrderStatus.delivered:
        return _StatusStyle(
          label: "delivered".tr(),
          color: AppColors.primaryBlue,
          bg: const Color(0xFFE7F0FE),
          icon: Icons.task_alt,
        );
      case OrderStatus.cancelled:
        return _StatusStyle(
          label: "cancelled".tr(),
          color: const Color(0xFFD1454B),
          bg: const Color(0xFFFCE9EA),
          icon: Icons.cancel,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = _statusStyle;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Status pill, centered at top
          Padding(
            padding: EdgeInsets.only(top: 14.h, bottom: 10.h),
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: status.bg,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(status.icon, color: status.color, size: 22.sp),
                    SizedBox(width: 10.w),
                    Text(
                      status.label,
                      style: TextStyle(
                        color: status.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _labelValue("authorization_number".tr(), order.authorizationNumber),
                _labelValue("order_number".tr(), order.orderNumber, alignEnd: true),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Divider(height: 1, color: AppColors.gray.withValues(alpha: 0.25)),
          ),

          // Customer row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16.r,
                  backgroundColor: AppColors.electricBlue.withValues(alpha: 0.15),
                  child: Icon(Icons.person, color: AppColors.primaryBlue, size: 16.sp),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    order.customerName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.5.sp,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(20.r),
                  onTap: () {
                    // TODO: launch dialer, e.g. via url_launcher: tel:${order.phone}
                  },
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Row(
                      children: [
                        Icon(Icons.call, color: AppColors.primaryBlue, size: 16.sp),
                        SizedBox(width: 4.w),
                        Text(
                          order.phone,
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.5.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 8.h),

          // City row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Icon(Icons.location_on_outlined, color: AppColors.gray, size: 16.sp),
                SizedBox(width: 6.w),
                Text(
                  order.city,
                  style: TextStyle(color: AppColors.gray, fontSize: 12.5.sp),
                ),
              ],
            ),
          ),

          SizedBox(height: 10.h),

          // Area + Map button row
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
            child: Row(
              children: [
                Icon(Icons.storefront_outlined, color: AppColors.gray, size: 15.sp),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    order.customerArea,
                    style: TextStyle(color: AppColors.gray, fontSize: 12.5.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8.w),
                InkWell(
                  borderRadius: BorderRadius.circular(20.r),
                  onTap: () {
                    // TODO: open maps app with the order's coordinates.
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on, color: Colors.white, size: 14),
                        SizedBox(width: 4.w),
                        Text(
                          order.mapLabel,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _labelValue(String label, String value, {bool alignEnd = false}) {
    return Column(
      crossAxisAlignment:
      alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: AppColors.gray, fontSize: 11.sp),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5.sp),
        ),
      ],
    );
  }
}

class _StatusStyle {
  final String label;
  final Color color;
  final Color bg;
  final IconData icon;
  const _StatusStyle({
    required this.label,
    required this.color,
    required this.bg,
    required this.icon,
  });
}

// Empty state (waiting orders tab, etc.)


class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, size: 56.sp, color: AppColors.gray),
            SizedBox(height: 12.h),
            Text(
              "no_orders_found".tr(),
              style: TextStyle(
                color: AppColors.gray,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}