import 'package:flutter/material.dart';
import 'package:tuneyverse/pages/chorus_and_instrumental/account_settings.dart';
import 'package:tuneyverse/pages/widgets/contact_us.dart';
import 'package:tuneyverse/pages/widgets/faq_section.dart';
import 'package:tuneyverse/pages/widgets/pricing_sectiont.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FeaturePage(),
  ));
}

class FeaturePage extends StatefulWidget {
  const FeaturePage({super.key});
  @override
  State<FeaturePage> createState() => _FeaturePageState();
}

// ---------- SIDEBAR ITEM DATA ----------

enum DashboardSection { sidebar, support }

class _FeaturePageState extends State<FeaturePage> {
  final GlobalKey<ScaffoldState> _mobileScaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0; // 0 = Track Splitting, 1 = Karaoke Video
  DashboardSection currentSection = DashboardSection.sidebar;

  final List<_SidebarItemData?> sidebarItems = [
    _SidebarItemData(
      text: 'Track Splitting',
      iconAsset: 'assets/icons/chorus_instrumental.png',
    ),
    _SidebarItemData(
      text: 'Karaoke Video',
      iconAsset: 'assets/icons/chorus_lyric.png',
    ),
    null,
    _SidebarItemData(
      text: 'Subscription',
      iconAsset: 'assets/icons/subscription.png',
    ),
  ];
  

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 450;
        return Scaffold(
          body: isMobile
              ? buildMobile(context)
              : buildDesktop(context),
        );
      },
    );
  }

  Widget buildMobile(BuildContext context) {
  return Scaffold(
    key: _mobileScaffoldKey,
    endDrawer: DrawerMenu(
      items: sidebarItems,
      onItemSelected: (int idx) {
        if (sidebarItems[idx] != null && selectedIndex != idx) {
          setState(() {
            selectedIndex = idx;
            currentSection = DashboardSection.sidebar;
          });
        }
        // Close drawer *after* (even if you tap the same item, it closes)
        Navigator.pop(context);
      },
      onSupport: () {
        setState(() {
          currentSection = DashboardSection.support;
        });
        Navigator.pop(context);
      },
      selectedIndex: selectedIndex, // Pass for highlighting
    ),
    backgroundColor: const Color(0xFFF0EFFA),
    body: SafeArea(
      child: Column(
        children: [
          UserDashboardMobileHeader(
            scaffoldKey: _mobileScaffoldKey,
            title: sidebarItems[selectedIndex]?.text ?? "",
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: _buildContent(selectedIndex, isMobile: true),
              ),
            ),
          ),
        ],
      ),
    ),
    bottomNavigationBar: MobileFooterBar(
      onSubmit: () {
        print("Submit for section $selectedIndex");
      },
    ),
  );
}


  Widget buildDesktop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        UserDashboardSidebar(
          selectedIndex: selectedIndex,
          currentSection: currentSection,
          onItemTap: (int idx) {
            if (sidebarItems[idx] != null) {
              setState(() {
                selectedIndex = idx;
                currentSection = DashboardSection.sidebar;
              });
            }
          },
          onSupport: () {
            setState(() {
              currentSection = DashboardSection.support;
            });
          },
          items: sidebarItems,
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double contentWidth = constraints.maxWidth;
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 74),
                    child: SingleChildScrollView(
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: _buildContent(selectedIndex, isMobile: false),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: DesktopFooterBar(
                      width: contentWidth,
                      onSubmit: () {
                        print("Submit for section $selectedIndex");
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContent(int index, {bool isMobile = false}) {
    if (currentSection == DashboardSection.support) {
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16.0 : 48.0,
          vertical: isMobile ? 20.0 : 40.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            FAQSection(),
            SizedBox(height: 40),
            ContactUsSection(),
          ],
        ),
      );
    }

    if (index == 0) {
      return isMobile
          ? TrackSplittingMobileSection(
              title: 'Track Splitting',
              sectionIndex: 0,
              onUpload: () {},
            )
          : TrackSplittingDesktopSection(
              title: 'Track Splitting',
              sectionIndex: 0,
              onUpload: () {},
            );
    }
    if (index == 1) {
      return isMobile
          ? KaraokeVideoMobileSection(
              title: 'Karaoke Video',
              sectionIndex: 1,
              onUpload: () {},
            )
          : KaraokeVideoDesktopSection(
              title: 'Karaoke Video',
              sectionIndex: 1,
              onUpload: () {},
            );
    }
    if (index == 3) {
      return Center(child: PricingSection());
    }
    return Center(child: Text("No page selected"));
  }
}



// ------------------- MOBILE HEADER -------------------

class UserDashboardMobileHeader extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;

  const UserDashboardMobileHeader({
    super.key,
    required this.scaffoldKey,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo and Tuneyverse text (left)
          GestureDetector(
            onTap: () {
              // <<<<< THIS IS THE IMPROVED NAVIGATION >>>>>
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 32,
                    height: 32,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Tuneyverse',
                    style: TextStyle(
                      color: Color(0xFFF0EFFA),
                      fontSize: 28.15,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                      height: 1.56,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Hamburger icon (right)
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white, size: 32),
            onPressed: () {
              scaffoldKey.currentState?.openEndDrawer();
            },
            splashRadius: 24,
          ),
        ],
      ),
    );
  }
}


// ------------------- SIDEBAR ITEM DATA (Mobile)-------------------

class _SidebarItemData {
  final String text;
  final String iconAsset;
  _SidebarItemData({required this.text, required this.iconAsset});
}

class HoverableDrawerItem extends StatefulWidget {
  final _SidebarItemData item;
  final VoidCallback onTap;

  const HoverableDrawerItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  State<HoverableDrawerItem> createState() => _HoverableDrawerItemState();
}

class _HoverableDrawerItemState extends State<HoverableDrawerItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final Color iconColor = (isHovered ? const Color(0xFFFFFFFF) : const Color(0xFFB3B3B3));
    final Color textColor = (isHovered ? const Color(0xFFFFFFFF) : const Color(0xFFB3B3B3));
    final Color tileColor = isHovered ? Colors.white.withOpacity(0.05) : Colors.transparent;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Container(
        color: tileColor,
        child: ListTile(
          leading: Image.asset(
            widget.item.iconAsset,
            width: 28,
            height: 28,
            color: iconColor,
          ),
          title: Text(
            widget.item.text,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: widget.onTap,
        ),
      ),
    );
  }
}


// ------------------- DRAWER MENU (MOBILE) -------------------

class DrawerMenu extends StatelessWidget {
  final List<_SidebarItemData?> items;
  final Function(int) onItemSelected;
  final VoidCallback? onSupport;
  final int selectedIndex; // << new

  const DrawerMenu({
    super.key,
    required this.items,
    required this.onItemSelected,
    this.onSupport,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            // Main content (logo + menu) scrolls if needed
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // LOGO & TEXT AT THE TOP
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 32,
                          height: 32,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 10),
                        const Text(
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
                  // SIDEBAR ITEMS
                  ...items.asMap().entries.map((entry) {
                    final idx = entry.key;
                    final item = entry.value;
                    if (item == null) {
                      return const Divider(
                        color: Colors.white24,
                        thickness: 1,
                        height: 12,
                        indent: 12,
                        endIndent: 12,
                      );
                    }
                    return ListTile(
                      leading: Image.asset(
                        item.iconAsset,
                        width: 28,
                        height: 28,
                        color: idx == selectedIndex ? Colors.white : const Color(0xFFB3B3B3),
                      ),
                      title: Text(
                        item.text,
                        style: TextStyle(
                          fontSize: 16,
                          color: idx == selectedIndex ? Colors.white : const Color(0xFFB3B3B3),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      selected: idx == selectedIndex,
                      onTap: () => onItemSelected(idx),
                    );
                  }).toList(),
                ],
              ),
            ),
            // User info pinned at the bottom
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 44, 20),
              child: UserDashboardSidebarUserInfo(
                onSupport: onSupport,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// ------------------- SIDEBAR (DESKTOP) -------------------

class UserDashboardSidebar extends StatelessWidget {
  final int selectedIndex;
  final DashboardSection currentSection;
  final void Function(int)? onItemTap;
  final VoidCallback? onSupport;
  final List<_SidebarItemData?> items;

  const UserDashboardSidebar({
    super.key,
    this.selectedIndex = 0,
    required this.currentSection,
    this.onItemTap,
    this.onSupport,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    // ***** FIX: Use only widget.items, no local re-declaration! *****
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
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: items.length,
              itemBuilder: (context, idx) {
                final item = items[idx];
                if (item == null) {
                  return const SizedBox(height: 32);
                }
                return _SidebarItem(
                  text: item.text,
                  iconAsset: item.iconAsset,
                  selected: currentSection == DashboardSection.sidebar && idx == selectedIndex,
                  onTap: () => onItemTap?.call(idx),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, bottom: 16, top: 4),
            child: UserDashboardSidebarUserInfo(
              onSupport: onSupport,
            ),
          ),
        ],
      ),
    );
  }
}
// ------------------- SIDEBAR ITEM WIDGET (DESKTOP) -------------------

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

// ------------------- SIDEBAR USER INFO & DROPDOWN -------------------
class UserDashboardSidebarUserInfo extends StatefulWidget {
  final VoidCallback? onSupport;
  const UserDashboardSidebarUserInfo({super.key, this.onSupport});



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
              offset: const Offset(-8, -420),
              child: Material(
                color: Colors.transparent,
                child: _UserDropdownMenu(
                  onClose: _removeDropdown,
                  onSupport: widget.onSupport,
                ),
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jonathan Freeman',
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




class _UserDropdownMenu extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback? onSupport;
  const _UserDropdownMenu({required this.onClose, this.onSupport});


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
              onTap: () {
                if (item.label == "Support") {
                    onSupport?.call();
                  } else if (item.label == "Account Settings") {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => AccountSettings()),
                    );
                  }
                  onClose();
              },
            ),
          ),
        ],
      ),
    );
  }
}

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


// --------- DESKTOP FOOTER BAR WIDGET (Always pinned, full width) ----------
class DesktopFooterBar extends StatelessWidget {
  final double width;
  final VoidCallback onSubmit;
  const DesktopFooterBar({required this.width, required this.onSubmit});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 74,
      color: const Color(0xFF251F48),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: [
          // Uploading status
          Row(
            children: [
              Image.asset(
                'assets/icons/upload_icon.png',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'uploading ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 1.72,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Submit button
          ElevatedButton(
            onPressed: onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF0EFFA),
              foregroundColor: const Color(0xFF30285C),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            child: Row(
              children: [
                const Text(
                  'Submit',
                  style: TextStyle(
                    color: Color(0xFF30285C),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/icons/arrow_right.png',
                  width: 24,
                  height: 24,
                  color: const Color(0xFF30285C),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------- Track Splitting MOBILE DASHBOARD CONTENT -------------------

class TrackSplittingMobileSection extends StatelessWidget {
  final String title;
  final int sectionIndex;
  final VoidCallback onUpload;

  const TrackSplittingMobileSection({
    super.key,
    required this.title,
    required this.sectionIndex,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final horizontalPadding = 20.0; // You can tweak this for your design
  final titleFontSize = (screenWidth * 0.085).clamp(22, 36).toDouble();
  final subtitleFontSize = (screenWidth * 0.042).clamp(13, 20).toDouble();

    return Container(
      width: screenWidth,
      color: const Color(0xFFF0EFFA),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 37),
            Text(
              'Tracking Splitting',
              style: TextStyle(
                color: const Color(0xFF30285C),
                fontSize: titleFontSize,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
                height: 0.93,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Isolate Vocals and Instrumental',
              style: TextStyle(
                color: const Color(0xFF30285C),
                fontSize: subtitleFontSize,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.32,
              ),
            ),
            const SizedBox(height: 48),
            _FeatureCardMobile(
              text: 'Chorus and Instrumental',
              iconAsset: 'assets/icons/chorus_instrumental.png',
            ),
            const SizedBox(height: 2),
            _FeatureCardMobile(
              text: 'Song Instrumental',
              iconAsset: 'assets/icons/chorus_lyric.png',
            ),
          ],
        ),
      ),
    );
  }
}


class _FeatureCardMobile extends StatelessWidget {
  final String text;
  final String iconAsset;

  const _FeatureCardMobile({
    required this.text,
    required this.iconAsset,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.92;   // 92% of screen width for better fit
    final cardHeight = (screenWidth * 0.19).clamp(50, 100).toDouble();
    final fontSize = (screenWidth * 0.034).clamp(12, 18).toDouble();
    final iconSize = (screenWidth * 0.065).clamp(18, 32).toDouble();
    final horizontalPadding = (screenWidth * 0.04).clamp(8, 18).toDouble();

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF251F48),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            iconAsset,
            width: iconSize,
            height: iconSize,
            color: Colors.white,
          ),
          SizedBox(width: horizontalPadding),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 1.72,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// ------------------- Track Splitting DESKTOP MAIN DASHBOARD CONTENT -------------------
class TrackSplittingDesktopSection extends StatelessWidget {
  final String title;
  final int sectionIndex;
  final VoidCallback onUpload;

  const TrackSplittingDesktopSection({
    super.key,
    required this.title,
    required this.sectionIndex,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 37, left: 63, right: 63, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + subtitle
          SizedBox(
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Tracking Splitting',
                  style: TextStyle(
                    color: Color(0xFF30285C),
                    fontSize: 32,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                    height: 0.93,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Isolate Vocals and Instrumental',
                  style: TextStyle(
                    color: Color(0xFF30285C),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.32,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _TabCardDesktop(text: 'Chorus and Instrumental',
                    iconAsset: 'assets/icons/chorus_instrumental.png',),
              const SizedBox(width: 40),
              _TabCardDesktop(text: 'Song Instrumental',
                    iconAsset: 'assets/icons/song_instrumental.png',),
            ],
          ),
        ],
      ),
    );
  }
}


class _TabCardDesktop extends StatelessWidget {
  final String text;
  final String iconAsset;
  const _TabCardDesktop({
    required this.text, 
    required this.iconAsset});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 74,
      decoration: BoxDecoration(
        color: Color(0xFF251F48),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(width: 33),
          Container(
            padding: const EdgeInsets.only(top: 8, left: 16, bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Image.asset(
                  iconAsset,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 6),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.72,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// ------------------- Mobile Footer Bar CONTENT -------------------
class MobileFooterBar extends StatelessWidget {
  final VoidCallback onSubmit;
  const MobileFooterBar({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: 64,
      color: const Color(0xFF251F48),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/icons/upload_icon.png',
                width: 22,
                height: 22,
              ),
              const SizedBox(width: 8),
              const Text(
                'uploading ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 1.72,
                ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF0EFFA),
              foregroundColor: const Color(0xFF30285C),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            child: Row(
              children: [
                const Text(
                  'Submit',
                  style: TextStyle(
                    color: Color(0xFF30285C),
                    fontSize: 15,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 8),
                Image.asset(
                  'assets/icons/arrow_right.png',
                  width: 22,
                  height: 22,
                  color: const Color(0xFF30285C),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------- Karaoke Video DESKTOP DASHBOARD CONTENT -------------------
class KaraokeVideoDesktopSection extends StatelessWidget {
  final String title;
  final int sectionIndex;
  final VoidCallback onUpload;
  const KaraokeVideoDesktopSection({
    Key? key,
    required this.title,
    required this.sectionIndex,
    required this.onUpload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List your background images from assets
    final List<String> backgroundImages = [
      'assets/images/bg1.png',
      'assets/images/bg2.png',
      'assets/images/bg3.png',
      'assets/images/bg4.png',
    ];

    // IMPORTANT: This fixes Stack layout bug!
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 600, // Or your preferred min height
        maxHeight: 900, // Or your preferred max height
      ),
      child: Stack(
        children: [
          // Optional debug background, remove if not needed
          Container(color: Color(0xFFF8F7FC)),
          // Main title and subtitle
          Positioned(
            left: 63,
            top: 37,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and subtitle
                const Text(
                  'Karaoke Video',
                  style: TextStyle(
                    color: Color(0xFF30285C),
                    fontSize: 32,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                    height: 0.93,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Create a Karaoke Video',
                  style: TextStyle(
                    color: Color(0xFF30285C),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.32,
                  ),
                ),
                const SizedBox(height: 80),
                // Option cards row 1
                SizedBox(
                  width: 670,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _KaraokeOptionCard(
                            iconAsset: 'assets/icons/chorus_lyric.png',
                            text: 'Chorus and Lyric Video',
                            textColor: const Color(0xFFFFECEC),
                          ),
                          const SizedBox(width: 44),
                          _KaraokeOptionCard(
                            iconAsset: 'assets/icons/vid_lyric.png',
                            text: 'Instrumental and Lyric Video',
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          _KaraokeOptionCard(
                            iconAsset: 'assets/icons/song_lyric.png',
                            text: 'Song and Lyric Video',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // "Choose a Background Image" title
          const Positioned(
            left: 63,
            top: 431,
            child: SizedBox(
              width: 292,
              child: Text(
                'Choose a Background Image',
                style: TextStyle(
                  color: Color(0xFF30285C),
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.40,
                ),
              ),
            ),
          ),
          // Background image previews (from assets)
          Positioned(
            left: 234,
            top: 490,
            child: Row(
              children: List.generate(backgroundImages.length, (i) {
                return Padding(
                  padding: EdgeInsets.only(right: i < backgroundImages.length - 1 ? 20.0 : 0),
                  child: Container(
                    width: 100,
                    height: 77,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(backgroundImages[i]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          // Upload background image text
          const Positioned(
            left: 373,
            top: 595,
            child: Text(
              'Upload background image',
              style: TextStyle(
                color: Color(0xFFEB221E),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KaraokeOptionCard extends StatelessWidget {
  final String iconAsset;
  final String text;
  final Color? textColor;

  const _KaraokeOptionCard({
    required this.iconAsset,
    required this.text,
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 74,
      decoration: BoxDecoration(
        color: const Color(0xFF251F48),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Image.asset(iconAsset, width: 24, height: 24, color: Colors.white),
          const SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: 13,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              height: 1.72,
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------- Karaoke Video MOBILE Section CONTENT -------------------

class KaraokeVideoMobileSection extends StatelessWidget {
  final String title;
  final int sectionIndex;
  final VoidCallback onUpload;

  const KaraokeVideoMobileSection({
    Key? key,
    required this.title,
    required this.sectionIndex,
    required this.onUpload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> backgroundImages = [
      'assets/images/bg1.png',
      'assets/images/bg2.png',
      'assets/images/bg3.png',
      'assets/images/bg4.png',
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Karaoke Video',
              style: TextStyle(
                color: Color(0xFF30285C),
                fontSize: 32,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
                height: 0.93,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create a Karaoke Video',
              style: TextStyle(
                color: Color(0xFF30285C),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.32,
              ),
            ),
            const SizedBox(height: 38),
            _KaraokeOptionCardMobile(
              iconAsset: 'assets/icons/chorus_lyric.png',
              text: 'Chorus and Lyric Video',
              textColor: const Color(0xFFFFECEC),
            ),
            const SizedBox(height: 16),
            _KaraokeOptionCardMobile(
              iconAsset: 'assets/icons/vid_lyric.png',
              text: 'Instrumental and Lyric Video',
            ),
            const SizedBox(height: 16),
            _KaraokeOptionCardMobile(
              iconAsset: 'assets/icons/song_lyric.png',
              text: 'Song and Lyric Video',
            ),
            const SizedBox(height: 40),
            const Text(
              'Choose a Background Image',
              style: TextStyle(
                color: Color(0xFF30285C),
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                letterSpacing: 0.40,
              ),
            ),
            const SizedBox(height: 20),

            // UPDATED: Use Column for images
            Column(
              children: List.generate(backgroundImages.length, (i) {
                return Padding(
                  padding: EdgeInsets.only(bottom: i < backgroundImages.length - 1 ? 18.0 : 0),
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(backgroundImages[i]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),
            Center(
              child: Text(
                'Upload background image',
                style: TextStyle(
                  color: Color(0xFFEB221E),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _KaraokeOptionCardMobile extends StatelessWidget {
  final String iconAsset;
  final String text;
  final Color? textColor;

  const _KaraokeOptionCardMobile({
    required this.iconAsset,
    required this.text,
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    // Responsive sizing:
    final double cardHeight = (screenWidth * 0.18).clamp(54.0, 90.0);
    final double iconSize = (screenWidth * 0.08).clamp(20.0, 32.0);
    final double fontSize = (screenWidth * 0.042).clamp(13.0, 18.0);
    final double horizontalPadding = (screenWidth * 0.045).clamp(8.0, 22.0);
    final double gap = (screenWidth * 0.03).clamp(8.0, 16.0);

    return Container(
      width: double.infinity,
      height: cardHeight,
      margin: EdgeInsets.symmetric(vertical: cardHeight * 0.08),
      decoration: BoxDecoration(
        color: const Color(0xFF251F48),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            iconAsset,
            width: iconSize,
            height: iconSize,
            color: Colors.white,
          ),
          SizedBox(width: gap),
          // Responsive text
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: fontSize,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

