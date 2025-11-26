import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import 'chat_screen.dart';
import 'settings_screen.dart';

enum AppView { home, settings }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _opacityAnimation;

  AppView _currentView = AppView.home;
  bool _isSidebarOpen = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<double>(begin: 0.0, end: 0.8).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
      if (_isSidebarOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _closeSidebar() {
    if (_isSidebarOpen) {
      setState(() {
        _isSidebarOpen = false;
        _animationController.reverse();
      });
    }
  }

  void _navigateTo(AppView view) {
    setState(() {
      _currentView = view;
      _closeSidebar();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidth = screenWidth > 500 ? 500.0 : screenWidth;
    final isDesktop = screenWidth > 500;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Container(
          width: maxWidth,
          height: MediaQuery.of(context).size.height,
          decoration: isDesktop
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(48),
                  border: Border.all(
                    color: Colors.grey.shade800,
                    width: 8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                )
              : null,
          clipBehavior: isDesktop ? Clip.hardEdge : Clip.none,
          child: Stack(
            children: [
              // Sidebar (always rendered, positioned behind)
              Sidebar(
                isOpen: _isSidebarOpen,
                onClose: _closeSidebar,
                onNavigate: _navigateTo,
              ),

              // Main Content with zoom/slide animation
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(screenWidth * _slideAnimation.value, 0),
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Opacity(
                        opacity: _opacityAnimation.value,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            _isSidebarOpen ? 24 : 0,
                          ),
                          child: Stack(
                            children: [
                              Container(
                                decoration: _isSidebarOpen
                                    ? BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.3),
                                            blurRadius: 20,
                                            spreadRadius: 5,
                                          ),
                                        ],
                                      )
                                    : null,
                                child: child,
                              ),
                              // Backdrop for closing sidebar (only over main content)
                              if (_isSidebarOpen)
                                Positioned.fill(
                                  child: GestureDetector(
                                    onTap: _closeSidebar,
                                    child: Container(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: _currentView == AppView.home
                    ? ChatScreen(onMenuClick: _toggleSidebar)
                    : SettingsScreen(onBack: () => _navigateTo(AppView.home)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
