import 'package:flutter/material.dart';
import 'package:foodie_app/services/theme_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Themes',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 15),
            _buildThemeOption(
              context,
              title: 'Light Mode',
              icon: Icons.light_mode_outlined,
              value: AppTheme.light,
              currentValue: themeService.currentTheme,
              onChanged: (val) => themeService.setTheme(val!),
            ),
            const SizedBox(height: 10),
            _buildThemeOption(
              context,
              title: 'Dark Mode',
              icon: Icons.dark_mode_outlined,
              value: AppTheme.dark,
              currentValue: themeService.currentTheme,
              onChanged: (val) => themeService.setTheme(val!),
            ),
            const SizedBox(height: 10),
            _buildThemeOption(
              context,
              title: 'Pink Theme',
              icon: Icons.palette_outlined,
              value: AppTheme.pink,
              currentValue: themeService.currentTheme,
              onChanged: (val) => themeService.setTheme(val!),
            ),
            const SizedBox(height: 10),
            _buildThemeOption(
              context,
              title: 'Green Theme',
              icon: Icons.palette_outlined,
              value: AppTheme.green,
              currentValue: themeService.currentTheme,
              onChanged: (val) => themeService.setTheme(val!),
            ),
            const SizedBox(height: 10),
            _buildThemeOption(
              context,
              title: 'Blue Theme',
              icon: Icons.palette_outlined,
              value: AppTheme.blue,
              currentValue: themeService.currentTheme,
              onChanged: (val) => themeService.setTheme(val!),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 30),
            InkWell(
              onTap: () => context.push('/cart'),
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.shopping_cart_outlined),
                    SizedBox(width: 15),
                    Text(
                      'Cart',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context, {
    required String title,
    required IconData icon,
    required AppTheme value,
    required AppTheme currentValue,
    required ValueChanged<AppTheme?> onChanged,
  }) {
    final isSelected = value == currentValue;
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: isSelected
              ? Border.all(color: colorScheme.primary, width: 2)
              : Border.all(color: Colors.transparent, width: 2),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? colorScheme.primary : null),
            const SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            const Spacer(),
            Radio<AppTheme>(
              value: value,
              groupValue: currentValue,
              onChanged: onChanged,
              activeColor: colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
