import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mytasks/splash_screen.dart';
import 'package:mytasks/Controller/task_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Task Manager',
          theme: ThemeData(
            fontFamily: 'Roboto Slab',
            primaryColor: Colors.grey,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.grey,
            ),
            useMaterial3: true,
          ),
          initialBinding: BindingsBuilder(() {
            Get.put(TaskController());
          }),
          home: const SplashScreen(),
        );
      },
    );
  }
}
