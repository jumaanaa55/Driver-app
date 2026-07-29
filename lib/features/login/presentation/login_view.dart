import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raya_express_driver/core/constant/app_color.dart';
import 'package:raya_express_driver/core/theme/theme_cubit.dart';
import '../../home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
final TextEditingController usernameController =
TextEditingController();

final TextEditingController passwordController =
TextEditingController();

bool obscurePassword = true;

@override
Widget build(BuildContext context) {
return Scaffold(
  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
body: SafeArea(
child: SingleChildScrollView(
padding: EdgeInsets.symmetric(horizontal: 24.w),
child: Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children: [

SizedBox(height: 20.h),

// Language Button

  Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 22.r,
          backgroundColor: AppColors.primaryBlue,
          child: IconButton(
            onPressed: () {
              context.read<ThemeCubit>().changeTheme();
            },
            icon: const Icon(Icons.dark_mode),
          ),
        ),

        CircleAvatar(
          radius: 22.r,
          backgroundColor: AppColors.primaryBlue,
          child: InkWell(
            borderRadius: BorderRadius.circular(22.r),
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
                  color: AppColors.background,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
// Logo

Container(
width: 110.w,
height: 110.w,

decoration: BoxDecoration(
  shape: BoxShape.circle,
border: Border.all(
color: AppColors.icon,
width: 2,
),
),

child: Padding(
padding: EdgeInsets.all(8.w),

child: ClipOval(
child: Image.asset(
"assets/images/logo.jpeg",
fit: BoxFit.cover,
),
),
),
),

SizedBox(height: 20.h),

Text(
"Raya Express Driver",
style: TextStyle(
  color: Theme.of(context).colorScheme.primary,
  fontSize: 25.sp,
fontWeight: FontWeight.bold,
),
),

SizedBox(height: 8.h),

Text(
"Welcome Back".tr(),
style: TextStyle(
color: AppColors.gray,
fontSize: 15.sp,
),
),

SizedBox(height: 20.h),

// Login Card

Container(
padding: EdgeInsets.all(24.w),

decoration: BoxDecoration(
  color: Theme.of(context).cardColor,
borderRadius: BorderRadius.circular(30.r),

boxShadow: const [

BoxShadow(
color: Colors.black12,
blurRadius: 15,
offset: Offset(0, 5),
),

],
),

child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,

children: [

Text(
"Login".tr(),
style: TextStyle(
  color: Theme.of(context).colorScheme.primary,
  fontSize: 30.sp,
fontWeight: FontWeight.bold,
),
),

SizedBox(height: 15.h),

Text(
"username".tr(),
style: TextStyle(
  color: Theme.of(context).colorScheme.primary,
  fontWeight: FontWeight.w600,
fontSize: 15.sp,
),
),

SizedBox(height: 8.h),

TextField(
controller: usernameController,

decoration: InputDecoration(

  prefixIcon: Icon(
    Icons.person_outline,
    color: Theme.of(context).colorScheme.primary,
  ),

hintText: "enter_username".tr(),

hintStyle: const TextStyle(
color: AppColors.gray,
),

filled: true,

fillColor: const Color(0xffF6F8FC),

border: OutlineInputBorder(
borderRadius:
BorderRadius.circular(18.r),
borderSide: BorderSide.none,
),
),
),

SizedBox(height: 22.h),

Text(
"Password".tr(),
style: TextStyle(
  color: Theme.of(context).colorScheme.primary,
  fontWeight: FontWeight.w600,
fontSize: 15.sp,
),
),

SizedBox(height: 8.h),

TextField(
controller: passwordController,
obscureText: obscurePassword,

decoration: InputDecoration(

    prefixIcon: Icon(
      Icons.lock_outline,
      color: Theme.of(context).colorScheme.primary,
    ),

  suffixIcon: IconButton(
    onPressed: () {
      setState(() {
        obscurePassword = !obscurePassword;
      });
    },

    icon: Icon(
      obscurePassword
          ? Icons.visibility
          : Icons.visibility_off,
      color: Theme.of(context).colorScheme.primary,
    ),
  ),

hintText: "enter_password".tr(),

hintStyle: const TextStyle(
color: AppColors.gray,
),

filled: true,

fillColor:
const Color(0xffF6F8FC),

border: OutlineInputBorder(
borderRadius:
BorderRadius.circular(18.r),
borderSide: BorderSide.none,
),
),
),

SizedBox(height: 35.h),
  // Login Button

  SizedBox(
    width: double.infinity,
    height: 56.h,
    child: ElevatedButton(
      onPressed: () {

        Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeView(),)
        );
      },

      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        elevation: 3,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(18.r),
        ),
      ),

      child: Text(
        "Login".tr(),
        style: TextStyle(
          backgroundColor: Theme.of(context).colorScheme.primary,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),

  SizedBox(height: 18.h),

  // Privacy Policy

  Center(
    child: TextButton(
      onPressed: () {},

      child: Text(
        "Privacy Policy".tr(),
        style: TextStyle(
          color: AppColors.gray,
          fontSize: 14.sp,
        ),
      ),
    ),
  ),
],
),
),

  SizedBox(height: 35.h),




],
),
),
),
);
}

@override
void dispose() {
  usernameController.dispose();
  passwordController.dispose();
  super.dispose();
}
}