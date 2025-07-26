import 'package:flutter/material.dart';

class UserDashboardSidebar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int)? onItemTap;

  const UserDashboardSidebar({
    super.key,
    this.selectedIndex = 0,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<_SidebarItemData?> items = [
      _SidebarItemData(
        text: 'Chorus and Instrumental',
        iconAsset: 'assets/icons/chorus_instrumental.png',
      ),
      _SidebarItemData(
        text: 'Chorus and Lyric Video',
        iconAsset: 'assets/icons/chorus_lyric.png',
      ),
      _SidebarItemData(
        text: 'Instrumental and Lyric Video',
        iconAsset: 'assets/icons/vid_lyric.png',
      ),
      _SidebarItemData(
        text: 'Song and Lyric Video',
        iconAsset: 'assets/icons/song_lyric.png',
      ),
      _SidebarItemData(
        text: 'Song Instrumental',
        iconAsset: 'assets/icons/song_instrumental.png',
      ),
      null,
      _SidebarItemData(
        text: 'Subscription',
        iconAsset: 'assets/icons/subscription.png',
      ),
    ];

    return Container(
      width: 290,
      decoration: const BoxDecoration(color: Colors.black),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.24, top: 31, bottom: 44),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 32,
                  height: 32,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 12),
                Text(
                  'Tuneyverse',
                  style: TextStyle(
                    color: Color(0xFFF0EFFA),
                    fontSize: 28.15,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                    height: 1.06,
                  ),
                ),
              ],
            ),
          ),
          // Sidebar Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: items.length,
              itemBuilder: (context, idx) {
                final item = items[idx];
                if (item == null) {
                  return const SizedBox(height: 32);
                }
                int adjustedIndex = idx > 5 ? idx - 1 : idx;
                return _SidebarItem(
                  text: item.text,
                  iconAsset: item.iconAsset,
                  selected: adjustedIndex == selectedIndex,
                  onTap: () => onItemTap?.call(adjustedIndex),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, bottom: 16, top: 4),
            child: UserDashboardSidebarUserInfo(),
          ),
        ],
      ),
    );
  }
}

// ---- SIDEBAR ITEM WITH ICON ----
class _SidebarItemData {
  final String text;
  final String iconAsset;
  _SidebarItemData({required this.text, required this.iconAsset});
}

class _SidebarItem extends StatefulWidget {
  final String text;
  final String iconAsset;
  final bool selected;
  final VoidCallback? onTap;

  const _SidebarItem({
    required this.text,
    required this.iconAsset,
    this.selected = false,
    this.onTap,
  });

  @override
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool showHighlight = widget.selected || isHovered;
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          width: 225,
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.only(top: 8, left: 16, bottom: 8),
          decoration: showHighlight
              ? BoxDecoration(
                  color: const Color(0xFF232323),
                  borderRadius: BorderRadius.circular(10),
                )
              : null,
          child: Row(
            children: [
              Image.asset(
                widget.iconAsset,
                width: 24,
                height: 24,
                fit: BoxFit.contain,
                color: showHighlight ? Colors.white : const Color(0xFFB3B3B3),
              ),
              const SizedBox(width: 12),
              Text(
                widget.text,
                style: TextStyle(
                  color: showHighlight ? Colors.white : const Color(0xFFB3B3B3),
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 1.72,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---- USER INFO WIDGET WITH UPWARD DROPDOWN ----
class UserDashboardSidebarUserInfo extends StatefulWidget {
  const UserDashboardSidebarUserInfo({super.key});

  @override
  State<UserDashboardSidebarUserInfo> createState() =>
      _UserDashboardSidebarUserInfoState();
}

class _UserDashboardSidebarUserInfoState
    extends State<UserDashboardSidebarUserInfo> {
  OverlayEntry? _dropdownOverlay;
  final LayerLink _layerLink = LayerLink();
  bool isHovered = false;

  void _toggleDropdown() {
    if (_dropdownOverlay != null) {
      _removeDropdown();
    } else {
      _showDropdown();
    }
  }

  void _showDropdown() {
    final overlay = Overlay.of(context);
    _dropdownOverlay = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: Stack(
          children: [
            GestureDetector(
              onTap: _removeDropdown,
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: const Offset(-8, -420), // Adjust for your dropdown height
              child: Material(
                color: Colors.transparent,
                child: _UserDropdownMenu(onClose: _removeDropdown),
              ),
            ),
          ],
        ),
      ),
    );
    overlay.insert(_dropdownOverlay!);
  }

  void _removeDropdown() {
    _dropdownOverlay?.remove();
    _dropdownOverlay = null;
  }

  @override
  void dispose() {
    _removeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool showHighlight = isHovered;

    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: _toggleDropdown,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width: 220,
            decoration: showHighlight
                ? BoxDecoration(
                    color: const Color(0xFF232323),
                    borderRadius: BorderRadius.circular(10),
                  )
                : null,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar image from your assets
                Container(
                  width: 40,
                  height: 40,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/avatar.png'),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Name and "Free" label (keep your name logic here!)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jonathan Freeman', // <- Your original name
                        style: const TextStyle(
                          color: Color(0xFFF0EFFA),
                          fontSize: 15,
                          fontFamily: 'Heebo',
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Free',
                        style: TextStyle(
                          color: Color(0xFF0FE8B7),
                          fontSize: 12,
                          fontFamily: 'Heebo',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---- DROPDOWN MENU ----
class _UserDropdownMenu extends StatelessWidget {
  final VoidCallback onClose;
  const _UserDropdownMenu({required this.onClose});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      _DropdownMenuItem(
          icon: Icons.star_border,
          label: "Unlock All Features",
          color: const Color(0xFF0FE8B7)),
      _DropdownMenuItem(icon: Icons.settings, label: "Account Settings"),
      _DropdownMenuItem(icon: Icons.notifications_none, label: "Notifications"),
      _DropdownMenuItem(icon: Icons.phone_iphone, label: "Get Mobile App"),
      _DropdownMenuItem(icon: Icons.desktop_windows, label: "Get Desktop App"),
      _DropdownMenuItem(icon: Icons.headphones, label: "Support"),
      _DropdownMenuItem(icon: Icons.card_giftcard, label: "What's new?"),
      _DropdownMenuItem(icon: Icons.logout, label: "Sign Out"),
    ];

    return Container(
      width: 270,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF343434),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.13),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...menuItems.map(
            (item) => _HoverDropdownMenuTile(
              icon: item.icon,
              label: item.label,
              color: item.color,
              onTap: onClose,
            ),
          ),
        ],
      ),
    );
  }
}

// Custom tile to handle hover color for icon/text
class _HoverDropdownMenuTile extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback onTap;

  const _HoverDropdownMenuTile({
    required this.icon,
    required this.label,
    this.color,
    required this.onTap,
  });

  @override
  State<_HoverDropdownMenuTile> createState() => _HoverDropdownMenuTileState();
}

class _HoverDropdownMenuTileState extends State<_HoverDropdownMenuTile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final Color iconAndTextColor =
        isHovered ? Colors.white : (widget.color ?? const Color(0xFFF0EFFA));
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: double.infinity,
          decoration: isHovered
              ? BoxDecoration(
                  color: const Color(0xFF444444),
                  borderRadius: BorderRadius.circular(10),
                )
              : null,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: iconAndTextColor,
                size: 24,
              ),
              const SizedBox(width: 18),
              Text(
                widget.label,
                style: TextStyle(
                  color: iconAndTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DropdownMenuItem {
  final IconData icon;
  final String label;
  final Color? color;

  _DropdownMenuItem({required this.icon, required this.label, this.color});
}
