import 'package:flutter/material.dart';
import 'package:delivery_app/core/localization/app_localizations.dart';
import 'package:delivery_app/main.dart';
import 'package:delivery_app/features/auth/presentation/pages/login_page.dart';

enum UserRole { customer, merchant, driver, admin }

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final isArabic = appLocaleNotifier.value.languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.translate('select_role')),
        centerTitle: true,
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.language, color: Colors.deepOrange),
            label: Text(
              tr.translate('switch_lang'),
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange),
            ),
            onPressed: () {
              appLocaleNotifier.value = isArabic ? const Locale('en') : const Locale('ar');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                tr.translate('select_role'),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                tr.translate('choose_role_subtitle'),
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    _RoleCard(
                      title: tr.translate('role_customer'),
                      subtitle: tr.translate('role_customer_desc'),
                      icon: Icons.person_pin_circle,
                      color: Colors.blue,
                      role: UserRole.customer,
                    ),
                    _RoleCard(
                      title: tr.translate('role_merchant'),
                      subtitle: tr.translate('role_merchant_desc'),
                      icon: Icons.storefront,
                      color: Colors.orange,
                      role: UserRole.merchant,
                    ),
                    _RoleCard(
                      title: tr.translate('role_driver'),
                      subtitle: tr.translate('role_driver_desc'),
                      icon: Icons.two_wheeler,
                      color: Colors.green,
                      role: UserRole.driver,
                    ),
                    _RoleCard(
                      title: tr.translate('role_admin'),
                      subtitle: tr.translate('role_admin_desc'),
                      icon: Icons.admin_panel_settings,
                      color: Colors.purple,
                      role: UserRole.admin,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final UserRole role;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(selectedRole: role),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: color.withOpacity(0.15),
                child: Icon(icon, color: color, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
