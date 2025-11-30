import 'package:flutter/material.dart';

/// ===========================
/// 🎨 COLORES DE LA APP (ALINEADOS AL SISTEMA WEB)
/// ===========================
class AppColors {
  // PALETA PRINCIPAL (COINCIDE CON TU CSS)
  static const primary = Color(0xFF1A2B4C); // Azul marino -> --primary-color
  static const accent = Color(0xFFD4AF37); // Dorado suave -> --accent-color
  static const background = Color(0xFFFAFAF5); // Beige claro -> --background-light

  // TONOS OSCUROS PARA LAYOUTS (SIDEBAR / HEADER / FOOTER)
  static const secondary = Color(0xFF212B36); // Gris azulado oscuro (sb-sidenav / dark)
  static const headerBackground = Color(0xFF1F2A38); // navbar-custom-dark
  static const footerBackground = Color(0xFF1C252E); // footer-custom-dark
  static const sidebarBackground = Color(0xFF212B36); // sb-sidenav-custom
  static const sidebarItemBackground = Color(0xFF2A3642); // Submenús

  // TEXTO
  static const textPrimary = Color(0xFF2C2C2C); // --text-dark
  static const textSecondary = Color(0xFFA89F91); // Dorado grisáceo (headers, footer)
  static const textLight = Color(0xFFFFFFFF); // --text-light
  static const sidebarText = Color(0xFFD1D5DB); // Gris claro en sidebar

  // BORDES / DETALLES
  static const borderAccent = Color(0xFFA89F91); // Bordes de header/footer/detalles

  // ESTADOS (PUEDES AJUSTARLOS SI QUIERES IGUALAR 100% AL WEB)
  static const success = Color(0xFF38A169); // Verde éxito
  static const error = Color(0xFFE53E3E); // Rojo error
  static const warning = Color(0xFFD69E2E); // Ámbar advertencia

  // VARIANTE DE FONDO (UN POCO MÁS OSCURA QUE background)
  static Color get backgroundVariant => const Color(0xFFF0F0EA);
}

/// ===========================
/// ✍️ ESTILOS DE TEXTO
/// ===========================
class AppTextStyles {
  static const heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const body = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
  );

  static const button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
  );
}

/// ===========================
/// 📏 ESPACIADOS Y RADIOS
/// ===========================
class AppSpacing {
  static const small = 8.0;
  static const medium = 16.0;
  static const large = 24.0;
}

class AppRadius {
  static const small = 8.0;
  static const medium = 16.0;
  static const large = 24.0;
}

/// ===========================
/// 🖼️ ASSETS / ICONOS
/// ===========================
class AppAssets {
  static const logo = "assets/logo.png";
  static const userPlaceholder = "assets/images/user.png";
}

/// ===========================
/// 🔑 STRINGS COMUNES
/// ===========================
class AppStrings {
  static const appName = "Incos App";
  static const login = "Iniciar Sesión";
  static const logout = "Cerrar Sesión";
  static const dashboard = "Manual - Calzados Aguilar";
}

/// ===========================
/// 👤 ROLES DE USUARIO
/// ===========================
class UserRoles {
  static const administrador = 'Administrador';
  static const estudiante = 'Estudiante';
  static const futuroEstudiante = 'FuturoEstudiante';
}

/// ===========================
/// 📌 ESTADOS
/// ===========================
class Estados {
  static const activo = 'Activo';
  static const inactivo = 'Inactivo';
  static const pendiente = 'Pendiente';
  static const aprobado = 'Aprobado';
  static const rechazado = 'Rechazado';
  static const inscrito = 'Inscrito';
  static const cancelado = 'Cancelado';
}

/// ===========================
/// 📚 TIPOS DE ACTIVIDAD
/// ===========================
class TiposActividad {
  static const seminario = 'Seminario';
  static const taller = 'Taller';
  static const curso = 'Curso';
}

/// ===========================
/// 🗄️ COLECCIONES FIRESTORE
/// ===========================
class Collections {
  static const usuarios = 'usuarios';
  static const docentes = 'docentes';
  static const actividades = 'actividades';
  static const seminarios = 'seminarios';
  static const postulaciones = 'postulaciones';
  static const inscripciones = 'inscripciones';
  static const mensajes = 'mensajes';
  static const programasEstudio = 'programas_estudio';
  static const ofertasAcademicas = 'ofertas_academicas';
  static const notificaciones = 'notificaciones';
}

/// ===========================
/// 💬 MENSAJES COMUNES
/// ===========================
class Messages {
  static const loginError = 'Usuario o contraseña incorrectos';
  static const campoRequerido = 'Este campo es obligatorio';
  static const correoInvalido = 'Correo electrónico inválido';
  static const passwordCorta =
      'La contraseña debe tener al menos 6 caracteres';
}
