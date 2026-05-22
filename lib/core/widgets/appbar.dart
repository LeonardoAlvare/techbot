import 'package:flutter/material.dart';
import 'package:techbot/core/theme/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onLogout;
  final void Function()? onAvatarTap;
  final bool? centerTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.onLogout,
    this.onAvatarTap,
    this.centerTitle = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColors.bgLight,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      leading: onBack != null
          ? GestureDetector(
              onTap: onBack,
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: CustomColors.lavender,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: CustomColors.primary,
                  size: 18,
                ),
              ),
            )
          : null,
      title: onBack == null
          ? Row(
              children: [
                _Avatar(onAvatarTap),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: CustomColors.primaryStrong,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          : Text(
              title,
              style: TextStyle(
                color: CustomColors.primaryStrong,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
      centerTitle: centerTitle,
      actions: onLogout != null
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                  onPressed: onLogout,
                  icon: const Icon(Icons.logout_rounded),
                  color: CustomColors.primary,
                  style: IconButton.styleFrom(
                    shape: const CircleBorder(),
                    side: BorderSide(
                      color: CustomColors.primaryLight,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ]
          : null,
    );
  }
}

class _Avatar extends StatelessWidget {
  final void Function()? onTap;
  const _Avatar(this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColors.lavender,
          border: Border.all(color: CustomColors.primaryLight, width: 2),
        ),
        child: ClipOval(
          child: Icon(
            Icons.person_rounded,
            color: CustomColors.primary,
            size: 26,
          ),
        ),
      ),
    );
  }
}
