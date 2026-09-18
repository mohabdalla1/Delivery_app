import 'package:flutter/material.dart';
import 'package:delivery_app/core/localization/app_localizations.dart';
import 'package:delivery_app/features/auth/presentation/pages/role_selection_page.dart';
import 'package:delivery_app/features/customer/presentation/pages/customer_home_page.dart';
import 'package:delivery_app/features/merchant/presentation/pages/merchant_home_page.dart';
import 'package:delivery_app/features/driver/presentation/pages/driver_home_page.dart';
import 'package:delivery_app/main.dart';

class LoginPage extends StatefulWidget {
  final UserRole selectedRole;

  const LoginPage({super.key, required this.selectedRole});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  String _getRoleTitle(AppLocalizations tr) {
    switch (widget.selectedRole) {
      case UserRole.customer:
        return tr.translate('role_customer');
      case UserRole.merchant:
        return tr.translate('role_merchant');
      case UserRole.driver:
        return tr.translate('role_driver');
      case UserRole.admin:
        return tr.translate('role_admin');
    }
  }

  Color _getRoleColor() {
    switch (widget.selectedRole) {
      case UserRole.customer:
        return Colors.blue;
      case UserRole.merchant:
        return Colors.orange;
      case UserRole.driver:
        return Colors.green;
      case UserRole.admin:
        return Colors.purple;
    }
  }

  void _handleLogin(BuildContext context) {
    if (widget.selectedRole == UserRole.admin) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AdminDashboardScreen()),
        (route) => false,
      );
    } else if (widget.selectedRole == UserRole.customer) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const CustomerHomePage()),
        (route) => false,
      );
    } else if (widget.selectedRole == UserRole.merchant) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MerchantHomePage()),
        (route) => false,
      );
    } else if (widget.selectedRole == UserRole.driver) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const DriverHomePage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final themeColor = _getRoleColor();

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.translate('login_title')),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 36,
                  backgroundColor: themeColor.withOpacity(0.15),
                  child: Icon(
                    widget.selectedRole == UserRole.customer
                        ? Icons.person
                        : widget.selectedRole == UserRole.merchant
                            ? Icons.store
                            : widget.selectedRole == UserRole.driver
                                ? Icons.directions_bike
                                : Icons.admin_panel_settings,
                    size: 40,
                    color: themeColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: themeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getRoleTitle(tr),
                    style: TextStyle(color: themeColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                tr.translate('welcome_back'),
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                tr.translate('login_subtitle'),
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: tr.translate('email_or_phone'),
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: tr.translate('password'),
                  prefixIcon: const Icon(Icons.lock_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    tr.translate('forgot_password'),
                    style: TextStyle(color: themeColor),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => _handleLogin(context),
                  child: Text(
                    tr.translate('sign_in'),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(tr.translate('dont_have_account')),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      tr.translate('create_account'),
                      style: TextStyle(color: themeColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
