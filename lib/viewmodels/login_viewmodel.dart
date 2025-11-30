import 'package:flutter/material.dart';
import '../data/database_helper.dart';

/// =======================================
/// 🧑‍💼 MODELO SIMPLE DE USUARIO ACTUAL
/// =======================================
class UsuarioActual {
  final int id;
  final int rolId;
  final String rolNombre;
  final String nombreUsuario;
  final String nombres;
  final String apPaterno;
  final String apMaterno;
  final String correo;
  final String estado;
  final String? avatarRuta;

  const UsuarioActual({
    required this.id,
    required this.rolId,
    required this.rolNombre,
    required this.nombreUsuario,
    required this.nombres,
    required this.apPaterno,
    required this.apMaterno,
    required this.correo,
    required this.estado,
    this.avatarRuta,
  });

  /// Nombre corto, útil para saludos: "Juan Pablo Ramirez"
  String get nombreCorto => '$nombres $apPaterno'.trim();

  /// Nombre completo para mostrar en el Drawer, encabezados, etc.
  String get nombreCompleto => '$nombres $apPaterno $apMaterno'.trim();

  /// Texto amigable de rol ("ADMIN", "EMPLEADO", etc.)
  String get rolLabel => rolNombre;

  factory UsuarioActual.fromMap(Map<String, Object?> map) {
    return UsuarioActual(
      id: (map['id'] as int),
      rolId: (map['rol_id'] as int),
      rolNombre: (map['rol_nombre'] as String),
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
  /// 🔑 LOGIN CONTRA LA TABLA `usuario` + `rol`
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

      // 🔎 JOIN usuario + rol para traer también el rol del usuario
      final result = await db.rawQuery(
        '''
        SELECT 
          u.id,
          u.rol_id,
          r.nombre AS rol_nombre,
          u.nombre_usuario,
          u.nombres,
          u.ap_paterno,
          u.ap_materno,
          u.correo,
          u.contrasena,
          u.estado,
          u.avatar_ruta,
          u.fecha_creacion,
          u.fecha_actualizacion
        FROM usuario u
        JOIN rol r ON r.id = u.rol_id
        WHERE u.correo = ? 
          AND u.contrasena = ? 
          AND UPPER(u.estado) = UPPER(?)
        LIMIT 1
        ''',
        [email, password, 'ACTIVO'],
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
