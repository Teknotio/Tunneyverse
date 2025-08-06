import 'package:flutter/material.dart';
import 'package:tuneyverse/pages/chorus_and_instrumental/upload_card.dart';
import 'package:tuneyverse/pages/widgets/contact_us.dart';
import 'package:tuneyverse/pages/widgets/faq_section.dart';
import 'package:tuneyverse/pages/widgets/pricing_sectiont.dart';
import 'package:tuneyverse/pages/chorus_and_instrumental/account_settings.dart';


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FeatureSection(),
  ));
}

class FeatureSection extends StatefulWidget {
  const FeatureSection({super.key});

  @override
  State<FeatureSection> createState() => _FeatureSectionState();
}


enum DashboardSection { sidebar, support }


class _FeatureSectionState extends State<FeatureSection> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedIndex = 0;

  bool showSupport = false;
  DashboardSection currentSection = DashboardSection.sidebar; // UPDATED

  // Use one source of truth for sidebar items
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
                  }
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

  if (index == 3) {
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
          sectionIndex: index,
          onUpload: uploadHandler, // Or your upload handler
        )
      : _DashboardContent(
          title: sidebarItems[index]!.text,
          sectionIndex: index,
          onUpload: uploadHandler, // Or your upload handler
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
  final VoidCallback? onSupport; // <-- ADDED

  const DrawerMenu({
    super.key,
    required this.items,
    required this.onItemSelected,
    this.onSupport,
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
  final int sectionIndex;      // <--- ADDED
  final VoidCallback onUpload; // <--- ADDED

  const DashboardContentMobile({
    super.key,
    required this.title,
    required this.sectionIndex,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width.clamp(250, 375);
    double scale(double designSize) => (screenWidth / 375) * designSize;

    return Container(
      width: 375,
      height: 694,
      padding: EdgeInsets.symmetric(horizontal: scale(20)),
      decoration: const BoxDecoration(
        color: Color(0xFFE9E6F8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: scale(24)),
          // Header Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: const Color(0xFF30285C),
                  fontSize: scale(14),
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w700,
                  height: 2.12,
                ),
              ),
              const Spacer(),
              TuneyverseButton(
                filled: true,
                text: "Upload",
                iconSize: scale(24),
                fontSize: scale(18),
                borderRadius: scale(6),
                circleBorderWidth: scale(3),
                padding: EdgeInsets.symmetric(
                  horizontal: scale(12),
                  vertical: scale(6),
                ),
                onTap: onUpload, // <--- UPDATED
              ),
            ],
          ),
          SizedBox(height: scale(32)),
          // Search Bar
          Container(
            width: double.infinity,
            height: scale(56),
            decoration: BoxDecoration(
              color: const Color(0xFFE9E6F8),
              borderRadius: BorderRadius.circular(scale(4)),
              border: Border.all(
                width: 1,
                color: const Color(0xFF79747E),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: scale(2)),
            alignment: Alignment.center,
            child: Row(
              children: [
                Container(
                  width: scale(48),
                  height: scale(48),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(Icons.search, color: const Color(0xFF656B8D), size: scale(28)),
                ),
                SizedBox(width: scale(8)),
                Expanded(
                  child: TextField(
                    style: TextStyle(
                      color: const Color(0xFF6A6A6A),
                      fontSize: scale(15),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: const Color(0xFF6A6A6A),
                        fontSize: scale(15),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: scale(12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: scale(64)),
          // Empty State Section
          Center(
            child: Column(
              children: [
                Text(
                  'Start adding songs \nUpload from local files ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0x80000000),
                    fontSize: scale(24),
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: scale(24)),
                TuneyverseButton(
                  filled: false,
                  text: "Upload",
                  iconSize: scale(24),
                  fontSize: scale(18),
                  borderRadius: scale(6),
                  circleBorderWidth: scale(3),
                  padding: EdgeInsets.symmetric(
                    horizontal: scale(22),
                    vertical: scale(10),
                  ),
                  onTap: onUpload, 
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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

  const UserDashboardSidebar({
    super.key,
    this.selectedIndex = 0,
    required this.currentSection, // UPDATED
    this.onItemTap,
    this.onSupport,
  });

  

  @override
  Widget build(BuildContext context) {
    final List<_SidebarItemData?> items = [
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

// ------------------- DESKTOP MAIN DASHBOARD CONTENT -------------------
class _DashboardContent extends StatelessWidget {
  final String title;
  final int sectionIndex;      // <--- ADDED
  final VoidCallback onUpload; // <--- ADDED

  const _DashboardContent({
    super.key,
    required this.title,
    required this.sectionIndex,
    required this.onUpload,
  });
  
  
  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    final width = MediaQuery.of(context).size.width;

    // Responsive breakpoints
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;
    final isDesktop = width >= 1024;

    // Responsive paddings and font sizes
    final horizontalPadding = isMobile ? 16.0 : isTablet ? 32.0 : 48.0;
    final headerFontSize = isMobile ? 22.0 : isTablet ? 26.0 : 32.0;
    final sectionFontSize = isMobile ? 16.0 : 20.0;

    return Container(
      color: const Color(0xFFE9E6F8),
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: isMobile ? 24 : 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Title, Search, Upload button (responsive)
          if (isDesktop || isTablet)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: const Color(0xFF30285C),
                      fontSize: headerFontSize,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                // Search bar
                SizedBox(
                  width: isDesktop ? 220 : 140,
                  child: DashboardSearchBar(),
                ),
                SizedBox(width: 16),
                // Upload Button
                SizedBox(
                  height: 50,
                  child: UploadButton(
                    onPressed: onUpload, // <--- UPDATED
                    borderColor: const Color(0xFF2A2E44),
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    filledBackground: true,
                  ),
                ),
              ],
            ),
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFF30285C),
                    fontSize: headerFontSize,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                DashboardSearchBar(),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: UploadButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UploadCard(sectionIndex: 0)),
                      );
                    },
                    borderColor: const Color(0xFF2A2E44),
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    filledBackground: true,
                  ),
                ),
              ],
            ),
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title, // <--- CHANGED
                  style: TextStyle(
                    color: const Color(0xFF30285C),
                    fontSize: headerFontSize,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                DashboardSearchBar(),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: UploadButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UploadCard(sectionIndex: 0)),
                      );
                    },
                    borderColor: const Color(0xFF2A2E44),
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    filledBackground: true,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 48),
          // Centered Section (responsive)
          Expanded(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(isMobile ? 16 : 32),
                constraints: BoxConstraints(
                  maxWidth: isMobile ? 400 : 500,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Start adding songs \nUpload from local files ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0x80000000), // Black 50% opacity
                        fontSize: sectionFontSize,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 163,
                      height: 52,
                      child: UploadButton(
                        onPressed: onUpload, // <--- UPDATED
                        borderColor: const Color(0xFF2A2E44),
                        iconColor: const Color(0xFF2A2E44),
                        textColor: const Color(0xFF2A2E44),
                        filledBackground: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------- REUSABLE UPLOAD BUTTON -------------------
class UploadButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;
  final double iconSize;
  final double circleSize;
  final double fontSize;
  final bool filledBackground;

  const UploadButton({
    super.key,
    this.onPressed,
    this.borderColor = const Color(0xFF656B8D),
    this.iconColor = const Color(0xFF656B8D),
    this.textColor = const Color(0xFF2A2E44),
    this.iconSize = 20,
    this.circleSize = 28,
    this.fontSize = 20,
    this.filledBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: borderColor),
        backgroundColor: filledBackground ? borderColor : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        elevation: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: circleSize,
            height: circleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              color: const Color.fromARGB(0, 0, 0, 0),
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
            'Upload',
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------- REUSABLE SEARCH BAR -------------------
class DashboardSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const DashboardSearchBar({
    super.key,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 219,
      height: 46,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(
          color: Color(0xFF6A6A6A),
          fontSize: 15,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          filled: true,
          fillColor: Color(0xFFE9E6F8), // matches your bg
          hintText: "Search",
          hintStyle: const TextStyle(
            color: Color(0xFF6A6A6A),
            fontSize: 15,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF656B8D), size: 22),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: const BorderSide(color: Color(0xFF656B8D), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: const BorderSide(color: Color(0xFF656B8D), width: 1.4),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: const BorderSide(color: Color(0xFF656B8D), width: 1),
          ),
        ),
      ),
    );
  }
}