import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
// استبدل المسار أدناه بما يناسب مسار ملف تسجيل الدخول لديك إذا كان مخزناً في مجلد فرعي
import 'login_screen.dart'; 

void main() async {
  // 1. ضمان تهيئة الـ Widgets الخاصة بـ Flutter
    WidgetsFlutterBinding.ensureInitialized();

      // 2. تهيئة Firebase
        await Firebase.initializeApp();

          runApp(const MyApp());
          }

          class MyApp extends StatelessWidget {
            const MyApp({super.key});

              @override
                Widget build(BuildContext context) {
                    return MaterialApp(
                          title: 'Delivery App',
                                debugShowCheckedModeBanner: false,
                                      theme: ThemeData(
                                              primarySwatch: Colors.blue,
                                                      useMaterial3: true,
                                                            ),
                                                                  // جعل شاشة تسجيل الدخول هي الصفحة الأولى عند فتح التطبيق
                                                                        home: const LoginScreen(),
                                                                            );
                                                                              }
                                                                              }
                                                                              