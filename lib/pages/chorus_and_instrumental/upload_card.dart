import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:tuneyverse/pages/chorus_and_instrumental/account_settings.dart';
import 'package:tuneyverse/pages/chorus_and_instrumental/user_dashboard.dart';
import 'package:tuneyverse/pages/widgets/pricing_sectiont.dart';
import 'package:tuneyverse/pages/widgets/faq_section.dart';
import 'package:tuneyverse/pages/widgets/contact_us.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UploadCard(sectionIndex: 0),
  ));
}

// --- Section Titles & Sidebar Items ---
class _SidebarItemData {
  final String text;
  final String iconAsset;
  const _SidebarItemData({required this.text, required this.iconAsset});
}

final List<_SidebarItemData?> sidebarItems = [
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

// --- Main Upload Card Widget ---
class UploadCard extends StatefulWidget {
  final int sectionIndex;

  const UploadCard({Key? key, required this.sectionIndex}) : super(key: key);

  @override
  State<UploadCard> createState() => _UploadCardState();
}


enum DashboardSection { sidebar, support }

class _UploadCardState extends State<UploadCard> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late int selectedIndex; // <-- ADDED

  bool showSupport = false;
  DashboardSection currentSection = DashboardSection.sidebar; // UPDATED

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.sectionIndex; // <-- ADDED
  }

  void _handleSidebarTap(int idx) {
    if (sidebarItems[idx] != null) {
      setState(() {
        selectedIndex = idx;
        currentSection = DashboardSection.sidebar;
      });
    }
  }

  void _handleSupportTap() {
    setState(() {
      currentSection = DashboardSection.support;
    });
  }

  Widget _buildContent({required bool isMobile}) {
    // Show Support Section
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
    // Show Upload/Other Section
    if (selectedIndex < 0 || selectedIndex >= sidebarItems.length || sidebarItems[selectedIndex] == null) {
      return const Center(child: Text("No page selected"));
    }
    if (selectedIndex == 6) {
      return SingleChildScrollView(
        child: Center(
          child: PricingSection(),
        ),
      );
    }
    // Your upload content
    final sectionTitle = sidebarItems[selectedIndex]?.text ?? "";
    return isMobile
        ? DashboardContentMobile(title: sectionTitle)
        : _DashboardContent(title: sectionTitle);
  }

  

  @override
  Widget build(BuildContext context) {
    final sectionTitle = sidebarItems[selectedIndex]?.text ?? "";
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
                  selectedIndex: selectedIndex, // <-- ADDED
                  onItemSelected: (int idx) {
                    // Only update if NOT a divider (null)
                    if (sidebarItems[idx] != null) { // <-- UPDATED
                      setState(() {
                        selectedIndex = idx;                        
                        currentSection = DashboardSection.sidebar; // UPDATED
                      });
                    }
                  },
                  onSupport: _handleSupportTap,
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
                        child: _buildContent(isMobile: true),
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
        onItemTap: _handleSidebarTap,
        items: sidebarItems, // <-- ADDED
        currentSection: currentSection, // UPDATED
        onSupport: _handleSupportTap,
      ),
      Expanded(
        child: SingleChildScrollView(
          child: Container(
            height: 832,
            alignment: Alignment.topCenter,
            child: _buildContent(isMobile: false),   // <-- THIS IS THE KEY UPDATE
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


// ------------------- DRAWER MENU (MOBILE) -------------------
class DrawerMenu extends StatelessWidget {
  final List<_SidebarItemData?> items;
  final int selectedIndex;
  final Function(int) onItemSelected;
  final VoidCallback? onSupport;

  const DrawerMenu({
    super.key,
    required this.items,
    required this.selectedIndex,
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
                      selected: idx == selectedIndex, // <-- ADDED
                      onTap: () {
                        Navigator.pop(context);   // <-- CLOSES THE DRAWER!
                        onItemSelected(idx);

                      },
                    );
                  }).toList(),
                  // Support Button (Mobile)
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

class HoverableDrawerItem extends StatefulWidget {
  final _SidebarItemData item;
  final VoidCallback onTap;
  final bool selected; // <-- ADDED

  const HoverableDrawerItem({
    super.key,
    required this.item,
    required this.onTap,
    this.selected = false, // <-- ADDED
  });

  @override
  State<HoverableDrawerItem> createState() => _HoverableDrawerItemState();
}

class _HoverableDrawerItemState extends State<HoverableDrawerItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool showHighlight = widget.selected || isHovered;
    final Color iconColor = showHighlight ? Colors.white : const Color(0xFFB3B3B3);
    final Color textColor = showHighlight ? Colors.white : const Color(0xFFB3B3B3);
    final Color tileColor = showHighlight ? Colors.white.withOpacity(0.09) : Colors.transparent;

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

// ------------------- SIDEBAR (DESKTOP) -------------------
class UserDashboardSidebar extends StatelessWidget {
  final int selectedIndex;
  final DashboardSection currentSection; // ADDED
  final void Function(int)? onItemTap;
  final List<_SidebarItemData?> items;
  final VoidCallback? onSupport;

  const UserDashboardSidebar({
    super.key,
    required this.selectedIndex,
    required this.currentSection, // UPDATED
    required this.onItemTap,
    required this.items,
    this.onSupport,
  });

  @override
  Widget build(BuildContext context) {
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
                    MaterialPageRoute(builder: (_) => HomepageDashboard(),),
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
                return _SidebarItem(
                  text: item.text,
                  iconAsset: item.iconAsset,
                  selected: idx == selectedIndex,
                  onTap: () => onItemTap?.call(idx),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 18, bottom: 16, top: 4),
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
  final VoidCallback? onSupport; // <-- add this line

  const UserDashboardSidebarUserInfo({super.key, this.onSupport}); // <-- update constructor

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
                child: _UserDropdownMenu(onClose: _removeDropdown,
                onSupport: widget.onSupport, // <-- ADD THIS
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
  final VoidCallback? onSupport; // <-- new
  const _UserDropdownMenu({required this.onClose, this.onSupport}); // <-- update


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
            (item) {
                return _HoverDropdownMenuTile(
                  icon: item.icon,
                  label: item.label,
                  color: item.color,
                  onTap: () {

                    onClose(); // Close the dropdown
                    if (item.label == "Support" && onSupport != null) {
                        onSupport!();
                      } else if (item.label == "Account Settings") {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => AccountSettings()),
                        );
                      }
                  },
                );
            }
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


class _DashboardContent extends StatefulWidget {
  final String title;
  const _DashboardContent({super.key, required this.title});

  @override
  State<_DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<_DashboardContent> {
  List<String> selectedFileNames = [];

  void _onFilesSelected(List<dynamic> files) {
    setState(() {
      selectedFileNames = files.map((file) {
        if (file is PlatformFile) {
          return file.name;
        } else if (file is Map && file['name'] != null) {
          return file['name'].toString();
        } else {
          return 'Unknown';
        }
      }).toList();
    });
    // You can add your upload logic here!
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    final double headerFontSize = isMobile ? 22.0 : isTablet ? 26.0 : 32.0;
    double cardWidth = (screenWidth * (isMobile ? 0.94 : isTablet ? 0.7 : 0.55)).clamp(280, 707);

    return Container(
      color: const Color(0xFFE9E6F8),
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          // Title at the top
          Positioned(
            left: isMobile ? 16 : 63,
            top: isMobile ? 16 : 37,
            child: Text(
              widget.title,
              style: TextStyle(
                color: const Color(0xFF30285C),
                fontSize: headerFontSize,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: cardWidth,
                  child: CenteredDropZoneCard(
                    onFilesSelected: _onFilesSelected,
                  ),
                ),
                if (selectedFileNames.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        const Text(
                          "Selected files:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        for (final file in selectedFileNames)
                          Text(file, style: const TextStyle(fontSize: 14)),
                      ],
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




// ------------------- MOBILE DASHBOARD CONTENT -------------------

class DashboardContentMobile extends StatefulWidget {
  final String title;
  const DashboardContentMobile({super.key, required this.title});

  @override
  State<DashboardContentMobile> createState() => _DashboardContentMobileState();
}

class _DashboardContentMobileState extends State<DashboardContentMobile> {
  List<String> selectedFileNames = [];

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'flac', 'm4a', 'mp4', 'mov', 'wma'],
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedFileNames = result.files.map((f) => f.name).toList();
      });
      // You can trigger your upload here as well.
    }
  }

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: const Color(0xFF30285C),
                  fontSize: scale(14),
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w700,
                  height: 2.12,
                ),
              ),
            ],
          ),
          SizedBox(height: scale(6)),
          // Tap-to-select upload card
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: _pickFiles,
                child: DottedBorder(
                  dashPattern: [5, 5],
                  color: const Color(0xFFB3B3B3),
                  strokeWidth: 1.3,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(scale(10)),
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      maxWidth: scale(360),
                      minHeight: scale(120),
                      maxHeight: scale(170),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: scale(24),
                      horizontal: scale(16),
                    ),
                    color: Colors.white,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: scale(40),
                          height: scale(40),
                          decoration: const BoxDecoration(
                            color: Color(0xFF251F48),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(Icons.upload_rounded, color: Colors.white, size: 28),
                          ),
                        ),
                        SizedBox(width: scale(16)),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tap to select up to 10 files',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: scale(14),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(height: scale(4)),
                              Text(
                                'Supported: MP3, WAV, FLAC, M4A, MP4, MOV, WMA',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: scale(11),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
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
            ),
          ),
          if (selectedFileNames.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: scale(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selected files:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: scale(13)),
                  ),
                  ...selectedFileNames.map((file) => Text(
                        file,
                        style: TextStyle(fontSize: scale(12)),
                      )),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ------------------- Dropdown CONTENT -------------------
class CenteredDropZoneCard extends StatefulWidget {
  final Function(List<dynamic> files) onFilesSelected;

  const CenteredDropZoneCard({Key? key, required this.onFilesSelected}) : super(key: key);

  @override
  State<CenteredDropZoneCard> createState() => _CenteredDropZoneCardState();
}

class _CenteredDropZoneCardState extends State<CenteredDropZoneCard> {
  DropzoneViewController? dropzoneController;
  bool isHighlighted = false;

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'flac', 'm4a', 'mp4', 'mov', 'wma'],
    );
    if (result != null && result.files.isNotEmpty) {
      widget.onFilesSelected(result.files); // List<PlatformFile>
    }
  }

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;
    final bool isDesktop = platform == TargetPlatform.macOS ||
        platform == TargetPlatform.windows ||
        platform == TargetPlatform.linux;

    return Stack(
      children: [
        if (isDesktop)
          DropzoneView(
            onCreated: (controller) => dropzoneController = controller,
            onDrop: (ev) async {
              final name = await dropzoneController!.getFilename(ev);
              final bytes = await dropzoneController!.getFileData(ev);
              widget.onFilesSelected([
                {
                  'name': name,
                  'bytes': bytes,
                }
              ]);
              setState(() => isHighlighted = false);
            },
            onHover: () => setState(() => isHighlighted = true),
            onLeave: () => setState(() => isHighlighted = false),
          ),
        GestureDetector(
          onTap: _pickFiles,
          child: DottedBorder(
            dashPattern: [5, 6],
            color: isHighlighted ? Colors.blue : const Color(0xFFB3B3B3),
            strokeWidth: 1.3,
            borderType: BorderType.RRect,
            radius: const Radius.circular(10),
            child: Container(
              width: 500,
              constraints: const BoxConstraints(
                minHeight: 120,
                maxHeight: 200,
              ),
              color: const Color(0xFFF0EFFA),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(
                          color: Color(0xFF251F48),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.upload_rounded, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Drop or select up to 10 files here',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.48,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Supported: MP3, WAV, FLAC, M4A, MP4, MOV, WMA',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.32,
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
          ),
        ),
      ],
    );
  }
}







class FadeScalePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  FadeScalePageRoute({required this.page})
      : super(
          transitionDuration: const Duration(milliseconds: 420),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.98, end: 1.0)
                    .animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
                child: child,
              ),
            );
          },
        );
}

