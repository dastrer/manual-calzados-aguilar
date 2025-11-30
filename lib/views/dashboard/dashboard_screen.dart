import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/dashboard_viewmodel.dart';
import '../../utils/constants.dart';

// IMPORTS DE LAS VISTAS DE MÓDULOS (INDEPENDIENTES)
import '../manual/intro_module_view.dart';
import '../manual/instalacion_module_view.dart';
import '../manual/configuracion_inicial_module_view.dart';
import '../manual/uso_modulos_module_view.dart';
import '../manual/soporte_errores_module_view.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardVM = Provider.of<DashboardViewModel>(context);

    // ================================
    // 🔄 PANTALLA DE CARGA INICIAL
    // ================================
    if (dashboardVM.isInitializing) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'Cargando manual...',
                style: AppTextStyles.body,
              ),
            ],
          ),
        ),
      );
    }

    // VISTAS DE LOS 5 MÓDULOS
    const List<Widget> pages = [
      IntroModuleView(),                 // 0
      InstalacionModuleView(),           // 1
      ConfiguracionInicialModuleView(),  // 2
      UsoModulosModuleView(),            // 3
      SoporteErroresModuleView(),        // 4
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textLight,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              AppStrings.dashboard,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Sistema Web Integral - Manual de Usuario",
              style: AppTextStyles.body.copyWith(
                color: AppColors.textLight.withOpacity(0.9),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      drawer: _buildDrawer(context, dashboardVM),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: pages[dashboardVM.selectedIndex],
      ),
      bottomNavigationBar: _buildResponsiveBottomNavigationBar(
        dashboardVM,
        context,
      ),
    );
  }

  // ========== DRAWER ==========
  Drawer _buildDrawer(
    BuildContext context,
    DashboardViewModel dashboardVM,
  ) {
    return Drawer(
      backgroundColor: AppColors.backgroundVariant,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            accountName: Text(
              "Usuario Manual",
              style: AppTextStyles.body.copyWith(color: Colors.white),
            ),
            accountEmail: Text(
              "manual@sistema.com",
              style: AppTextStyles.body.copyWith(color: Colors.white70),
            ),
            currentAccountPicture: const CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.accent,
              child: Icon(Icons.menu_book, size: 40, color: Colors.white),
            ),
          ),

          // ITEMS DEL MENÚ (UNO POR CADA MÓDULO)
          _buildDrawerItem(
            context,
            Icons.menu_book,
            "Introducción y Alcance",
            0,
            dashboardVM,
          ),
          _buildDrawerItem(
            context,
            Icons.download,
            "Instalación del Sistema",
            1,
            dashboardVM,
          ),
          _buildDrawerItem(
            context,
            Icons.settings,
            "Configuración Inicial",
            2,
            dashboardVM,
          ),
          _buildDrawerItem(
            context,
            Icons.view_module,
            "Uso de los Módulos",
            3,
            dashboardVM,
          ),
          _buildDrawerItem(
            context,
            Icons.support_agent,
            "Soporte y Errores",
            4,
            dashboardVM,
          ),

          const Spacer(),
          const Divider(height: 1, color: AppColors.textSecondary),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.error),
            title: Text(
              AppStrings.logout,
              style: AppTextStyles.body.copyWith(color: AppColors.error),
            ),
            onTap: () {
              // TODO: Implementar logout
            },
          ),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
    DashboardViewModel dashboardVM,
  ) {
    final bool isSelected = dashboardVM.selectedIndex == index;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
      ),
      title: Text(
        label,
        style: AppTextStyles.body.copyWith(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: AppColors.primary.withOpacity(0.08),
      onTap: () {
        dashboardVM.changeIndex(index);
        Navigator.pop(context);
      },
    );
  }

  // ========== RESPONSIVE NAV ==========
  Widget _buildResponsiveBottomNavigationBar(
    DashboardViewModel dashboardVM,
    BuildContext context,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return _buildMobileBottomNavigationBar(dashboardVM, context);
    } else if (screenWidth < 1200) {
      return _buildTabletBottomNavigationBar(dashboardVM, context);
    } else {
      return _buildDesktopBottomNavigationBar(dashboardVM, context);
    }
  }

  // --- NAV MÓVIL ---
  Widget _buildMobileBottomNavigationBar(
    DashboardViewModel dashboardVM,
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundVariant,
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavItem(
                Icons.download,
                "Instalación",
                1,
                dashboardVM,
                isMobile: true,
              ),
              _buildNavItem(
                Icons.settings,
                "Config.",
                2,
                dashboardVM,
                isMobile: true,
              ),
              _buildNavItemInicio(dashboardVM, isMobile: true),
              _buildNavItem(
                Icons.view_module,
                "Uso",
                3,
                dashboardVM,
                isMobile: true,
              ),
              _buildNavItem(
                Icons.support_agent,
                "Soporte",
                4,
                dashboardVM,
                isMobile: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- NAV TABLET ---
  Widget _buildTabletBottomNavigationBar(
    DashboardViewModel dashboardVM,
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundVariant,
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      Icons.download,
                      "Instalación",
                      1,
                      dashboardVM,
                      isTablet: true,
                    ),
                    _buildNavItem(
                      Icons.settings,
                      "Configuración\nInicial",
                      2,
                      dashboardVM,
                      isTablet: true,
                    ),
                  ],
                ),
              ),
              _buildNavItemInicio(dashboardVM, isTablet: true),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      Icons.view_module,
                      "Uso de\nMódulos",
                      3,
                      dashboardVM,
                      isTablet: true,
                    ),
                    _buildNavItem(
                      Icons.support_agent,
                      "Soporte y\nErrores",
                      4,
                      dashboardVM,
                      isTablet: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- NAV ESCRITORIO ---
  Widget _buildDesktopBottomNavigationBar(
    DashboardViewModel dashboardVM,
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundVariant,
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.large),
          height: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(
                      Icons.download,
                      "Instalación del Sistema",
                      1,
                      dashboardVM,
                      isDesktop: true,
                    ),
                    _buildNavItem(
                      Icons.settings,
                      "Configuración Inicial",
                      2,
                      dashboardVM,
                      isDesktop: true,
                    ),
                  ],
                ),
              ),
              _buildNavItemInicio(dashboardVM, isDesktop: true),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(
                      Icons.view_module,
                      "Uso de los Módulos",
                      3,
                      dashboardVM,
                      isDesktop: true,
                    ),
                    _buildNavItem(
                      Icons.support_agent,
                      "Soporte y Errores",
                      4,
                      dashboardVM,
                      isDesktop: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ========== NAV ITEM GENÉRICO ==========
  Widget _buildNavItem(
    IconData icon,
    String label,
    int index,
    DashboardViewModel dashboardVM, {
    bool isMobile = false,
    bool isTablet = false,
    bool isDesktop = false,
  }) {
    final bool isSelected = dashboardVM.selectedIndex == index;

    return MaterialButton(
      minWidth: isMobile
          ? 40
          : isTablet
              ? 60
              : 80,
      onPressed: () => dashboardVM.changeIndex(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            size: isMobile
                ? 20
                : isTablet
                    ? 24
                    : 28,
          ),
          const SizedBox(height: 4),
          Flexible(
            child: Text(
              label,
              style: AppTextStyles.body.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontSize: isMobile
                    ? 10
                    : isTablet
                        ? 12
                        : 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
              maxLines: isTablet ? 2 : 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // ========== BOTÓN CENTRAL INTRO (GRADIENTE PREMIUM) ==========
  Widget _buildNavItemInicio(
    DashboardViewModel dashboardVM, {
    bool isMobile = false,
    bool isTablet = false,
    bool isDesktop = false,
  }) {
    final bool isSelected = dashboardVM.selectedIndex == 0;

    final double size = isMobile
        ? 56
        : isTablet
            ? 64
            : 72;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.medium : AppSpacing.large,
      ),
      child: GestureDetector(
        onTap: () => dashboardVM.changeIndex(0),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // GRADIENTE DORADO → AZUL CUANDO NO ESTÁ SELECCIONADO
            gradient: isSelected
                ? null
                : const LinearGradient(
                    colors: [
                      AppColors.accent,   // Dorado
                      AppColors.primary,  // Azul marino
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            // SOLO AZUL CUANDO ESTÁ SELECCIONADO
            color: isSelected ? AppColors.primary : null,
            boxShadow: [
              BoxShadow(
                color: AppColors.textSecondary.withOpacity(0.35),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(
            Icons.menu_book,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }
}
