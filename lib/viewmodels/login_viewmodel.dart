import 'package:flutter/material.dart';
import '../data/database_helper.dart';

/// =======================================
/// 🧑‍💼 MODELO SIMPLE DE USUARIO ACTUAL
/// =======================================
class UsuarioActual {
  final int id;
  final String nombreUsuario;
  final String nombres;
  final String apPaterno;
  final String apMaterno;
  final String correo;
  final String estado;
  final String? avatarRuta;

  const UsuarioActual({
    required this.id,
    required this.nombreUsuario,
    required this.nombres,
    required this.apPaterno,
    required this.apMaterno,
    required this.correo,
    required this.estado,
    this.avatarRuta,
  });

  String get nombreCorto => '$nombres $apPaterno'.trim();

  factory UsuarioActual.fromMap(Map<String, Object?> map) {
    return UsuarioActual(
      id: (map['id'] as int),
      nombreUsuario: (map['nombre_usuario'] as String),
      nombres: (map['nombres'] as String),
      apPaterno: (map['ap_paterno'] as String?) ?? '',
      apMaterno: (map['ap_materno'] as String?) ?? '',
      correo: (map['correo'] as String),
      estado: (map['estado'] as String),
      avatarRuta: map['avatar_ruta'] as String?,
    );
  }
}

/// =======================================
/// 🔐 LOGIN VIEWMODEL — CONECTADO A SQLITE
/// =======================================
class LoginViewModel extends ChangeNotifier {
  // Controladores para el formulario
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  UsuarioActual? _usuarioActual;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UsuarioActual? get usuarioActual => _usuarioActual;

  // Para mostrar si hay usuario logueado
  bool get isLoggedIn => _usuarioActual != null;

  /// 🔄 LIMPIAR ERRORES
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// =======================================
  /// 🔑 LOGIN CONTRA LA TABLA `usuario`
  /// =======================================
  Future<bool> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _errorMessage = 'Ingrese su correo y contraseña.';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final db = await DatabaseHelper.instance.database;

      // 🔎 BUSCAMOS POR CORREO + CONTRASEÑA + ESTADO ACTIVO (CASE-INSENSITIVE)
      final result = await db.query(
        'usuario',
        where: 'correo = ? AND contrasena = ? AND UPPER(estado) = UPPER(?)',
        whereArgs: [email, password, 'ACTIVO'],
        limit: 1,
      );

      if (result.isEmpty) {
        _usuarioActual = null;
        _errorMessage =
            'Correo o contraseña incorrectos, o el usuario está inactivo.';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      _usuarioActual = UsuarioActual.fromMap(result.first);
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Error al acceder a la base de datos: $e';
      notifyListeners();
      return false;
    }
  }

  /// 🚪 LOGOUT
  Future<void> logout() async {
    _usuarioActual = null;
    emailController.clear();
    passwordController.clear();
    _errorMessage = null;
    notifyListeners();
  }

  /// 🧹 LIMPIAR RECURSOS
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
