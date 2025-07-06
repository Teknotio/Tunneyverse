import 'package:flutter/material.dart';
import 'package:tuneyverse/pages/chorus_and_instrumental/upload_card.dart';
import 'package:tuneyverse/pages/chorus_and_instrumental/user_dashboard.dart';
import 'package:tuneyverse/pages/widgets/contact_us.dart';
import 'package:tuneyverse/pages/widgets/faq_section.dart';
import 'package:tuneyverse/pages/widgets/pricing_sectiont.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AccountSettings(),
  ));
}

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

enum DashboardSection { sidebar, support, accountsettings}


class _AccountSettingsState extends State<AccountSettings> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedIndex = 0;

  bool showSupport = false;
  DashboardSection currentSection = DashboardSection.sidebar; // UPDATED

  // Use one source of truth for sidebar items
  final List<_SidebarItemData?> sidebarItems = [
    _SidebarItemData(
      text: 'Account',
      iconAsset: 'assets/icons/account.png',
    ),
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

        if (isMobile) {
          return Scaffold(
            key: scaffoldKey,
            endDrawer: Drawer(
              child: Container(
                color: Colors.black,
                child: DrawerMenu(
                  items: sidebarItems,
                  onItemSelected: (int idx) {
                    // Only update if NOT a divider (null)
                    if (sidebarItems[idx] != null) { // <-- UPDATED
                      setState(() {
                        selectedIndex = idx;                        
                        currentSection = DashboardSection.sidebar; // UPDATED
                      });
                    }
                  },
                  onSupport: () {
                    setState(() {
                      currentSection = DashboardSection.support; // UPDATED
                    });
                  },
                  onAccountSettings: () {
                    setState(() {
                      currentSection = DashboardSection.accountsettings; // UPDATED
                    });
                  },
                ),
              ),
            ),
            backgroundColor: const Color(0xFFF0EFFA),
            body: SafeArea(
              child: Column(
                children: [
                  UserDashboardMobileHeader(
                    scaffoldKey: scaffoldKey,
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
          );
        } else {
          // --- DESKTOP/TABLET VIEW ---
          return Scaffold(
            backgroundColor: const Color(0xFFE9E6F8),
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserDashboardSidebar(
                  selectedIndex: selectedIndex,
                  currentSection: currentSection, // UPDATED
                  onItemTap: (int idx) {
                    // Only update if NOT a divider (null)
                    if (sidebarItems[idx] != null) { // <-- UPDATED
                      setState(() {
                        selectedIndex = idx;
                        currentSection = DashboardSection.sidebar; // UPDATED 
                      });
                    }
                  },
                  // ----------- UPDATED: Support callback for dropdown on desktop
                  onSupport: () {
                    setState(() {
                      currentSection = DashboardSection.support; // UPDATED
                    });
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      height: 832,
                      alignment: Alignment.topCenter,
                      child: _buildContent(selectedIndex, isMobile: false),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  // Centralized content builder for desktop & mobile
  Widget _buildContent(int index, {bool isMobile = false}) {
  if (currentSection == DashboardSection.support) { // UPDATED
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


  if (index < 0 || index >= sidebarItems.length || sidebarItems[index] == null) {
    return Center(child: Text("No page selected"));
  }

  if (index == 1) {
    return SingleChildScrollView(
      child: Center(
        child: PricingSection(),
      ),
    );
  }

  


  // -------- The fix: always pass sectionIndex for navigation --------
  VoidCallback uploadHandler = () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UploadCard(sectionIndex: index),
        ),
      );
    };

  return isMobile
      ? DashboardContentMobile(
          title: sidebarItems[index]!.text,
          sectionIndex: index, // Or your upload handler
        )
      : _DashboardContent(
          title: sidebarItems[index]!.text,
          sectionIndex: index,
          // Or your upload handler
        );
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
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => HomepageDashboard()),
                (route) => false,
              );
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
  final VoidCallback? onSupport; // <-- ADDED
  final VoidCallback? onAccountSettings; // <-- ADDED

  const DrawerMenu({
    super.key,
    required this.items,
    required this.onItemSelected,
    this.onSupport,
    this.onAccountSettings, // <-- ADDED
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
                      return HoverableDrawerItem(
                        item: item,
                        onTap: () {
                          Navigator.pop(context);
                          // Only call onItemSelected for non-divider
                          if (item != null) {
                            onItemSelected(idx);
                          }
                        },
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




// ------------------- MOBILE DASHBOARD CONTENT -------------------

class DashboardContentMobile extends StatelessWidget {
  final String title;
  final int sectionIndex;

  const DashboardContentMobile({
    super.key,
    required this.title,
    required this.sectionIndex,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width.clamp(250, 375);
    double scale(double size) => (screenWidth / 375) * size;

    if (sectionIndex == 0) {
      // ACCOUNT SECTION
      return Container(
        width: 375,
        height: 694,
        padding: EdgeInsets.symmetric(horizontal: scale(20)),
        decoration: const BoxDecoration(
          color: Color(0xFFE9E6F8),
        ),
        child: Column(
          children: [
            SizedBox(height: scale(32)),
            // Avatar Centered
            Center(
              child: Container(
                width: scale(90),
                height: scale(90),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage("assets/avatar.png"),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(color: Colors.white, width: scale(3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: scale(18)),
            // Name & Email Centered
            Center(
              child: Column(
                children: [
                  Text(
                    'Jonathan Freeman',
                    style: TextStyle(
                      color: const Color(0xFF30285C),
                      fontSize: scale(22),
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: scale(2)),
                  Text(
                    'jonathanfreeman@gmail.com',
                    style: TextStyle(
                      color: const Color(0xFF30285C),
                      fontSize: scale(13),
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: scale(30)),
            // Account Info Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: scale(24),
                horizontal: scale(18),
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(scale(2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _mobileAccountRow(
                    label: 'Username',
                    value: 'Jonathan Freeman',
                    scale: scale,
                  ),
                  SizedBox(height: scale(18)),
                  _mobileAccountRow(
                    label: 'Email',
                    value: 'jonathanfreeman@gmail.com',
                    scale: scale,
                  ),
                  SizedBox(height: scale(18)),
                  _mobileAccountRow(
                    label: 'Password',
                    value: '************',
                    scale: scale,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // OTHER SECTIONS (e.g. uploads) — you can handle here!
    return Center(child: Text(title));
  }
}

Widget _mobileAccountRow({
  required String label,
  required String value,
  required double Function(double) scale,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        width: scale(80),
        child: Text(
          label,
          style: TextStyle(
            color: const Color(0xFF251F48),
            fontSize: scale(16),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(left: scale(10)),
          child: Text(
            value,
            style: TextStyle(
              color: const Color(0xFF30285C),
              fontSize: scale(13),
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: scale(6)),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF30285C),
            padding: EdgeInsets.symmetric(
              horizontal: scale(14),
              vertical: scale(6),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(scale(2)),
            ),
            elevation: 0,
          ),
          onPressed: () {},
          child: Text(
            'Modify',
            style: TextStyle(
              color: const Color(0xFFF0EFFA),
              fontSize: scale(12),
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    ],
  );
}

// ------------------ REUSABLE BUTTON CLASS ------------------

class TuneyverseButton extends StatelessWidget {
  final bool filled;
  final String text;
  final double iconSize;
  final double fontSize;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double circleBorderWidth;

  const TuneyverseButton({
    super.key,
    this.filled = false,
    required this.text,
    this.iconSize = 24,
    this.fontSize = 18,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.borderRadius = 6,
    this.circleBorderWidth = 3,
  });

  @override
  Widget build(BuildContext context) {
    final Color fillColor = filled ? const Color(0xFF2A2548) : Colors.transparent;
    final Color borderColor = filled ? const Color(0xFF2A2548) : const Color(0xFF656B8D);
    final Color textColor = filled ? Colors.white : const Color(0xFF2A2548);
    final Color iconBorderColor = filled ? Colors.white : const Color(0xFF656B8D);
    final Color iconColor = filled ? Colors.white : const Color(0xFF656B8D);

    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: fillColor,
          border: Border.all(color: borderColor, width: 1.5),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: iconSize + 8,
              height: iconSize + 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: iconBorderColor, width: circleBorderWidth),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_upward_rounded,
                  color: iconColor,
                  size: iconSize,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
                fontSize: fontSize,
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
  final DashboardSection currentSection; // ADDED
  final void Function(int)? onItemTap;
  final VoidCallback? onSupport; // <---- NEW
  final VoidCallback? onAccountSettings; // <-- Add this

  const UserDashboardSidebar({
    super.key,
    this.selectedIndex = 0,
    required this.currentSection, // UPDATED
    this.onItemTap,
    this.onSupport,
    this.onAccountSettings, // <-- Add this
  });

  

  @override
  Widget build(BuildContext context) {
    final List<_SidebarItemData?> items = [
      _SidebarItemData(
        text: 'Account',
        iconAsset: 'assets/icons/account.png',
      ),
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
            child: GestureDetector(
              onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => HomepageDashboard()),
                    (route) => false,
                  );
                },

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
                //int adjustedIndex = idx > 7 ? idx - 1 : idx;
                return _SidebarItem(
                  text: item.text,
                  iconAsset: item.iconAsset,
                  selected: currentSection == DashboardSection.sidebar && idx == selectedIndex, // UPDATED
                  onTap: () => onItemTap?.call(idx),
                );
              },
            ),
          ),
          Padding(
                      padding: const EdgeInsets.only(left: 18, bottom: 16, top: 4),
            child: UserDashboardSidebarUserInfo(
              onSupport: onSupport,
              onAccountSettings: onAccountSettings, // <-- Forward the callback
            ),
          ),// User info, dropdown etc.
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
  final VoidCallback? onAccountSettings;
  const UserDashboardSidebarUserInfo({super.key, this.onSupport, this.onAccountSettings});



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
                  onAccountSettings: widget.onAccountSettings, // <-- ADD THIS
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
  final VoidCallback? onAccountSettings; // <-- ADD THIS

  const _UserDropdownMenu({required this.onClose, this.onSupport, this.onAccountSettings});


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
                if (item.label == "Account Settings") {
                  onAccountSettings?.call(); // <-- TRIGGER THE DASHBOARD SWITCH
                } else if (item.label == "Support") {
                  onSupport?.call();
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

// ------------------- DESKTOP MAIN DASHBOARD CONTENT -------------------
class _DashboardContent extends StatelessWidget {
  final String title;
  final int sectionIndex;

  const _DashboardContent({
    super.key,
    required this.title,
    required this.sectionIndex,
  });

  @override
  Widget build(BuildContext context) {
    // --- Account Section (Index 0) ---
    if (sectionIndex == 0) {
      // Responsive breakpoints
      final double screenWidth = MediaQuery.of(context).size.width;
      final double maxCardWidth = 540;
      final double cardWidth = screenWidth < (maxCardWidth + 80)
          ? (screenWidth - 64).clamp(300, maxCardWidth)
          : maxCardWidth;
      final double avatarSize = screenWidth < 420 ? 72 : 120;
      final double titleFont = screenWidth < 500 ? 22 : 32;
      final double labelFont = screenWidth < 500 ? 16 : 20;
      return Container(
        width: double.infinity,
        height: 832,
        color: const Color(0xFFE9E6F8),
        child: Stack(
          children: [
            // Account Settings Title (top left)
            Positioned(
              left: screenWidth < 360 ? 8 : 43,
              top: 33,
              child: Text(
                'Account Settings',
                style: TextStyle(
                  color: Color(0xFF30285C),
                  fontSize: 32,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w700,
                  height: 0.93,
                ),
              ),
            ),
            // Centered Content
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: screenWidth < 500 ? 40 : 80,
                  bottom: 60,
                ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Avatar
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage("assets/avatar.png"),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  // Name
                  const Text(
                    'Jonathan Freeman',
                    style: TextStyle(
                      color: Color(0xFF30285C),
                      fontSize: 32,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                      height: 0.93,
                    ),
                  ),
                  // Email
                  const Text(
                    'jonathanfreeman@gmail.com',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF30285C),
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                      height: 1.86,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Account Info Card
                  Container(
                    width: cardWidth,
                      padding: EdgeInsets.symmetric(
                        vertical: screenWidth < 500 ? 16 : 30,
                        horizontal: screenWidth < 500 ? 16 : 32,
                      ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _accountRow(label: 'Username', value: 'Jonathan Freeman'),
                        const SizedBox(height: 24),
                        _accountRow(label: 'Email', value: 'jonathanfreeman@gmail.com'),
                        const SizedBox(height: 24),
                        _accountRow(label: 'Password', value: '************'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ),
          ],
        ),
      );
    }

    // --- Subscription Section (Index 1) ---
    if (sectionIndex == 1) {
      return SingleChildScrollView(
        child: Center(
          child: PricingSection(),
        ),
      );
    }

    // --- Default/Other Section ---
    return const Center(child: Text('Section not implemented'));
  }
}

// Helper for account rows
Widget _accountRow({required String label, required String value}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        width: 130, // consistent label width
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF251F48),
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: const TextStyle(
            color: Color(0xFF30285C),
            fontSize: 16,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      _modifyButton(),
    ],
  );
}

// Helper for Modify button
Widget _modifyButton() {
  return Container(
    margin: const EdgeInsets.only(left: 12),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF30285C),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        elevation: 0,
      ),
      onPressed: () {},
      child: const Text(
        'Modify',
        style: TextStyle(
          color: Color(0xFFF0EFFA),
          fontSize: 16,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}






