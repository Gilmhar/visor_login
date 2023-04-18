import 'package:flutter/material.dart';

import 'package:login_visor/src/screen/login_page.dart';
// import 'package:toast/toast.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ToastContext().init(context);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: LoginPage(),
    );
  }
}