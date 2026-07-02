import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, this.animationController});
  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Avatar
            CircleAvatar(
              radius: 60,
              backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
              child: Icon(
                Icons.person,
                size: 60,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            // Name
            Text(
              'User Name',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Email or Subtitle
            Text(
              'user.name@example.com',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
            const SizedBox(height: 40),
            // Placeholder Buttons
            _buildProfileOption(
              context: context,
              icon: Icons.info_outline,
              title: 'About',
              onTap: () {
                // TODO: Implement About action
              },
            ),
            const Divider(),
            _buildProfileOption(
              context: context,
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {
                // TODO: Implement Settings action
              },
            ),
            const Divider(),
            _buildProfileOption(
              context: context,
              icon: Icons.logout,
              title: 'Logout',
              isDestructive: true,
              onTap: () {
                // TODO: Implement Logout action
              },
            ),
            const SizedBox(height: 40),
            // App Version
            Text(
              'App Version 1.0.0',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final theme = Theme.of(context);
    final color = isDestructive ? theme.colorScheme.error : theme.iconTheme.color;
    final textColor = isDestructive ? theme.colorScheme.error : theme.textTheme.bodyLarge?.color;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
