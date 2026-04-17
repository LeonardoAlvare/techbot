part of '../page.dart';

class _Header extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onLogout;

  const _Header({required this.onLogout});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColors.bgLight,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          _Avatar(),
          const SizedBox(width: 12),
          Text(
            'TeachBot',
            style: TextStyle(
              color: CustomColors.primaryStrong,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: IconButton(
            onPressed: onLogout,
            icon: const Icon(Icons.logout_rounded),
            color: CustomColors.primary,
            style: IconButton.styleFrom(
              shape: const CircleBorder(),
              side: BorderSide(color: CustomColors.primaryLight, width: 1),
            ),
            tooltip: 'Cerrar sesión',
          ),
        ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CustomColors.lavender,
        border: Border.all(color: CustomColors.primaryLight, width: 2),
      ),
      child: ClipOval(child: const _DefaultAvatar()),
    );
  }
}

class _DefaultAvatar extends StatelessWidget {
  const _DefaultAvatar();

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.person_rounded, color: CustomColors.primary, size: 26);
  }
}
