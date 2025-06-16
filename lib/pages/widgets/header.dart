import 'package:flutter/material.dart';
import 'package:tuneyverse/pages/ChorusAndInstrumental.dart';
import 'package:tuneyverse/pages/chorus_lyric_video.dart';
import 'package:tuneyverse/pages/instrumental_lyric_video.dart';
import 'package:tuneyverse/pages/song_instrumental.dart';
import 'package:tuneyverse/pages/song_lyric_video.dart';

class ResponsiveHeader extends StatelessWidget {
  final VoidCallback? onLogin;
  final VoidCallback? onSignUp;
  final VoidCallback? onHome;
  final VoidCallback? onPricing;
  final VoidCallback? onAboutUs;
  final VoidCallback? onContactUs;

  const ResponsiveHeader({
    super.key,
    this.onLogin,
    this.onSignUp,
    this.onHome,
    this.onPricing,
    this.onAboutUs,
    this.onContactUs,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 800) {
          return _DesktopHeader(
            onLogin: onLogin,
            onSignUp: onSignUp,
            onHome: onHome,
            onPricing: onPricing,
            onAboutUs: onAboutUs,
            onContactUs: onContactUs,
          );
        } else {
          return _MobileHeader(
            onLogin: onLogin,
            onSignUp: onSignUp,
            onHome: onHome,
            onPricing: onPricing,
            onAboutUs: onAboutUs,
            onContactUs: onContactUs,
          );
        }
      },
    );
  }
}

// Logo + Name
class _LogoName extends StatelessWidget {
  const _LogoName();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 40,
          width: 40,
        ),
        const SizedBox(width: 10),
        const Text(
          'Tuneyverse',
          style: TextStyle(
            color: Color(0xFF50449A),
            fontSize: 28.15,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w700,
            height: 1.06,
          ),
        ),
      ],
    );
  }
}

// Desktop Header
class _DesktopHeader extends StatelessWidget {
  final VoidCallback? onLogin;
  final VoidCallback? onSignUp;
  final VoidCallback? onHome;
  final VoidCallback? onPricing;
  final VoidCallback? onAboutUs;
  final VoidCallback? onContactUs;

  const _DesktopHeader({
    this.onLogin,
    this.onSignUp,
    this.onHome,
    this.onPricing,
    this.onAboutUs,
    this.onContactUs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 64),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _LogoName(),
          Row(
            children: [
              _NavButton(title: 'Home', onTap: onHome),
              _FeaturesDropdownButton(),
              _NavButton(title: 'Pricing', onTap: onPricing),
              _SupportDropdownButton(
                onAboutUs: onAboutUs,
                onContactUs: onContactUs,
              ),
              const SizedBox(width: 32),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF50449A)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                ),
                onPressed: onLogin ?? () {},
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Color(0xFF50449A),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF50449A),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                ),
                onPressed: onSignUp ?? () {},
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Nav Button for non-dropdown items
class _NavButton extends StatelessWidget {
  final String title;
  final bool hasDropdown;
  final VoidCallback? onTap;

  const _NavButton({
    required this.title,
    this.hasDropdown = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: TextButton(
        onPressed: onTap ?? () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size(88, 40),
          alignment: Alignment.centerLeft,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            if (hasDropdown) ...[
              const SizedBox(width: 4),
              const Icon(Icons.arrow_drop_down, size: 20, color: Colors.black),
            ]
          ],
        ),
      ),
    );
  }
}

// Desktop: Features Dropdown (hover/clickable)
class _FeaturesDropdownButton extends StatefulWidget {
  @override
  State<_FeaturesDropdownButton> createState() => _FeaturesDropdownButtonState();
}

class _FeaturesDropdownButtonState extends State<_FeaturesDropdownButton> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;

  void _toggleDropdown(BuildContext context) {
    if (_isDropdownOpen) {
      _removeDropdown();
    } else {
      _showDropdown(context);
    }
  }

  void _showDropdown(BuildContext context) {
    if (_overlayEntry != null) return;
    _overlayEntry = _createOverlayEntry(context);
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isDropdownOpen = true);
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isDropdownOpen = false);
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: 240,
        child: MouseRegion(
          onExit: (_) => _removeDropdown(),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _DropdownItem(
                  text: 'Song Instrumental',
                  onTap: () {
                    _removeDropdown();
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SongInstrumental()));
                  },
                ),
                _DropdownItem(
                  text: 'Chorus and Instrumental',
                  onTap: () {
                    _removeDropdown();
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ChorusAndInstrumental()));
                  },
                ),
                _DropdownItem(
                  text: 'Chorus and Lyric Video',
                  onTap: () {
                    _removeDropdown();
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ChorusLyricVideo()));
                  },
                ),
                _DropdownItem(
                  text: 'Song and Lyric Video',
                  onTap: () {
                    _removeDropdown();
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SongLyricVideo()));
                  },
                ),
                _DropdownItem(
                  text: 'Instrumental and Lyric Video',
                  onTap: () {
                    _removeDropdown();
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const InstrumentalAndLyricVideo()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _toggleDropdown(context),
      child: CompositedTransformTarget(
        link: _layerLink,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Features',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                _isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                size: 20,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _removeDropdown();
    super.dispose();
  }
}

// Support Dropdown (unchanged, works on desktop)
class _SupportDropdownButton extends StatefulWidget {
  final VoidCallback? onAboutUs;
  final VoidCallback? onContactUs;

  const _SupportDropdownButton({
    this.onAboutUs,
    this.onContactUs,
  });

  @override
  State<_SupportDropdownButton> createState() => _SupportDropdownButtonState();
}

class _SupportDropdownButtonState extends State<_SupportDropdownButton> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isHovering = false;

  void _showDropdown(BuildContext context) {
    if (_overlayEntry != null) return;
    _overlayEntry = _createOverlayEntry(context);
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isHovering = true);
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isHovering = false);
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: 180,
        child: MouseRegion(
          onExit: (_) => _removeDropdown(),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _DropdownItem(
                  text: 'About Us',
                  onTap: () {
                    _removeDropdown();
                    widget.onAboutUs?.call();
                  },
                ),
                _DropdownItem(
                  text: 'Contact Us',
                  onTap: () {
                    _removeDropdown();
                    widget.onContactUs?.call();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: (_) => _showDropdown(context),
        onExit: (_) {
          Future.delayed(const Duration(milliseconds: 80), () {
            if (!_isHovering) _removeDropdown();
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Support',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_drop_down, size: 20, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _removeDropdown();
    super.dispose();
  }
}

// Dropdown Item
class _DropdownItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _DropdownItem({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

// Mobile Header (unchanged)
class _MobileHeader extends StatelessWidget {
  final VoidCallback? onLogin;
  final VoidCallback? onSignUp;
  final VoidCallback? onHome;
  final VoidCallback? onPricing;
  final VoidCallback? onAboutUs;
  final VoidCallback? onContactUs;

  const _MobileHeader({
    this.onLogin,
    this.onSignUp,
    this.onHome,
    this.onPricing,
    this.onAboutUs,
    this.onContactUs,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (ctx) => Container(
        width: double.infinity,
        height: 64,
        padding: const EdgeInsets.only(left: 20, right: 12),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _LogoName(),
            IconButton(
              icon: const Icon(Icons.menu, size: 32, color: Color(0xFF50449A)),
              onPressed: () {
                try {
                  Scaffold.of(ctx).openEndDrawer();
                } catch (e) {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    const SnackBar(
                      content: Text('Drawer cannot be opened from here!'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Drawer for Mobile Navigation
class AppDrawer extends StatefulWidget {
  final VoidCallback? onHome;
  final VoidCallback? onLogin;
  final VoidCallback? onSignUp;
  final VoidCallback? onPricing;
  final VoidCallback? onAboutUs;
  final VoidCallback? onContactUs;

  const AppDrawer({super.key, 
    this.onHome,
    this.onLogin,
    this.onSignUp,
    this.onPricing,
    this.onAboutUs,
    this.onContactUs,
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool _supportExpanded = false;
  bool _featuresExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
          children: [
            const _LogoName(),
            const SizedBox(height: 20),
            _NavButton(title: 'Home', onTap: widget.onHome),
            // Features expandable nav
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _featuresExpanded = !_featuresExpanded;
                      });
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(88, 40),
                      alignment: Alignment.centerLeft,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Features',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          _featuresExpanded
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          size: 20,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  if (_featuresExpanded) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 8.0),
                            title: const Text(
                              'Song Instrumental',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onTap: () {
                              setState(() => _featuresExpanded = false);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const SongInstrumental()));
                            },
                            dense: true,
                            visualDensity: VisualDensity.compact,
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 8.0),
                            title: const Text(
                              'Chorus and Instrumental',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onTap: () {
                              setState(() => _featuresExpanded = false);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const ChorusAndInstrumental()));
                            },
                            dense: true,
                            visualDensity: VisualDensity.compact,
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 8.0),
                            title: const Text(
                              'Chorus and Lyric Video',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onTap: () {
                              setState(() => _featuresExpanded = false);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const ChorusLyricVideo()));
                            },
                            dense: true,
                            visualDensity: VisualDensity.compact,
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 8.0),
                            title: const Text(
                              'Song and Lyric Video',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onTap: () {
                              setState(() => _featuresExpanded = false);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const SongLyricVideo()));
                            },
                            dense: true,
                            visualDensity: VisualDensity.compact,
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 8.0),
                            title: const Text(
                              'Instrumental and Lyric Video',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onTap: () {
                              setState(() => _featuresExpanded = false);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const InstrumentalAndLyricVideo()));
                            },
                            dense: true,
                            visualDensity: VisualDensity.compact,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            _NavButton(title: 'Pricing', onTap: widget.onPricing),
            // Support expandable nav
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _supportExpanded = !_supportExpanded;
                      });
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(88, 40),
                      alignment: Alignment.centerLeft,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Support',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          _supportExpanded
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          size: 20,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  if (_supportExpanded) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 8.0),
                            title: const Text(
                              'About Us',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onTap: () {
                              setState(() => _supportExpanded = false);
                              widget.onAboutUs?.call();
                            },
                            dense: true,
                            visualDensity: VisualDensity.compact,
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 8.0),
                            title: const Text(
                              'Contact Us',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onTap: () {
                              setState(() => _supportExpanded = false);
                              widget.onContactUs?.call();
                            },
                            dense: true,
                            visualDensity: VisualDensity.compact,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Divider(height: 32),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF50449A)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              ),
              onPressed: widget.onLogin ?? () {},
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Color(0xFF50449A),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF50449A),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              ),
              onPressed: widget.onSignUp ?? () {},
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
