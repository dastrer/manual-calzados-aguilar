import 'package:flutter/material.dart';

class DashboardViewModel extends ChangeNotifier {
  // ================================
  // 🔹 ÍNDICE DEL MÓDULO SELECCIONADO
  // ================================
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  // ================================
  // 🔹 BANDERA DE CARGA INICIAL
  // ================================
  bool _isInitializing = true;
  bool get isInitializing => _isInitializing;

  // ================================
  // 🔹 INICIALIZAR DESPUÉS DEL LOGIN
  // ================================
  DashboardViewModel() {
    _init();
  }

  Future<void> _init() async {
    // 🔄 Simulación de carga (evita barras amarillas y lag inicial)
    await Future.delayed(const Duration(milliseconds: 600));
    _isInitializing = false;
    notifyListeners();
  }

  /// 🔄 REINICIAR PARA VOLVER A MOSTRAR LA PANTALLA DE CARGA
  Future<void> restart() async {
    _selectedIndex = 0;
    _isInitializing = true;
    notifyListeners();      // Para que el Dashboard vea el estado "cargando"
    await _init();          // Vuelve a ejecutar la animación de carga
  }

  // ================================
  // 🔹 CAMBIAR ENTRE MÓDULOS
  // ================================
  void changeIndex(int index) {
    if (_selectedIndex == index) return; // evita refrescos innecesarios
    _selectedIndex = index;
    notifyListeners();
  }
}
