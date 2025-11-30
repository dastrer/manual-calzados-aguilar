import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../utils/constants.dart';

class SoporteErroresModuleView extends StatefulWidget {
  const SoporteErroresModuleView({super.key});

  @override
  State<SoporteErroresModuleView> createState() => _SoporteErroresModuleViewState();
}

class _SoporteErroresModuleViewState extends State<SoporteErroresModuleView> {
  final String _supportEmail = "ramirez.9933315@gmail.com";
  final String _supportPhone = "+59160696135"; // Sin espacios para WhatsApp
  
  int _selectedCategory = 0;
  final List<String> _categories = [
    "Todos",
    "Errores de instalación",
    "Errores de inicio de sesión", 
    "Errores de reportes",
    "Errores de base de datos"
  ];

  final List<Map<String, dynamic>> _commonErrors = [
    {
      'title': 'No se puede conectar a la base de datos',
      'description': 'Error al establecer conexión con MySQL',
      'category': 'Errores de base de datos',
      'causes': [
        'Apache/MySQL no están iniciados en XAMPP',
        'Configuración incorrecta en el archivo .env',
        'Puerto de MySQL bloqueado por otra aplicación',
        'Credenciales de base de datos incorrectas'
      ],
      'solutions': [
        'Abrir XAMPP Control Panel y iniciar Apache y MySQL',
        'Verificar las credenciales en el archivo .env (DB_USERNAME, DB_PASSWORD)',
        'Comprobar que el puerto 3306 no esté en uso',
        'Validar que la base de datos exista en phpMyAdmin'
      ]
    },
    {
      'title': 'No abre el sistema en el navegador',
      'description': 'Error 404 o página no encontrada',
      'category': 'Errores de instalación',
      'causes': [
        'Servidor Apache no está corriendo',
        'Archivos no copiados en la carpeta htdocs',
        'Puerto 80 u 8080 ocupado por otra aplicación',
        'URL incorrecta en el navegador'
      ],
      'solutions': [
        'Verificar que Apache esté iniciado en XAMPP',
        'Confirmar que los archivos estén en htdocs/carpeta_del_sistema',
        'Acceder mediante http://localhost o http://localhost:8080',
        'Revisar que no haya aplicaciones usando los puertos 80 o 8080'
      ]
    },
    {
      'title': 'Usuario o contraseña incorrectos',
      'description': 'Error de autenticación en el login',
      'category': 'Errores de inicio de sesión',
      'causes': [
        'Credenciales ingresadas incorrectamente',
        'Usuario no existe en la base de datos',
        'Problema con el hash de contraseñas',
        'Base de datos no tiene datos de prueba'
      ],
      'solutions': [
        'Verificar usuario y contraseña (mayúsculas/minúsculas)',
        'Ejecutar php artisan db:seed para cargar usuarios de prueba',
        'Revisar que la migración se ejecutó correctamente',
        'Contactar al administrador para resetear contraseña'
      ]
    },
    {
      'title': 'No se puede generar reporte',
      'description': 'Error al generar documentos PDF o Excel',
      'category': 'Errores de reportes',
      'causes': [
        'Falta de permisos en carpetas de almacenamiento',
        'Librerías de PDF no instaladas correctamente',
        'Espacio insuficiente en disco',
        'Problema con la plantilla del reporte'
      ],
      'solutions': [
        'Ejecutar: chmod -R 755 storage/ (Linux) o dar permisos de escritura (Windows)',
        'Verificar que las dependencias de Composer estén instaladas',
        'Comprobar espacio disponible en el disco duro',
        'Revisar logs en storage/logs para más detalles'
      ]
    },
    {
      'title': 'Error 500 - Internal Server Error',
      'description': 'Error genérico del servidor',
      'category': 'Errores de instalación',
      'causes': [
        'Problemas con las dependencias de Composer',
        'Archivo .env mal configurado',
        'Permisos incorrectos en carpetas',
        'Error en la sintaxis del código'
      ],
      'solutions': [
        'Ejecutar: composer install y composer update',
        'Verificar que APP_KEY esté generada en .env',
        'Ejecutar: php artisan config:clear y php artisan cache:clear',
        'Revisar el archivo storage/logs/laravel.log para detalles específicos'
      ]
    },
    {
      'title': 'Token expirado o inválido',
      'description': 'Error de sesión o token CSRF',
      'category': 'Errores de inicio de sesión',
      'causes': [
        'Sesión expirada por inactividad',
        'Problema con la configuración de sesión',
        'Navegador con cookies bloqueadas',
        'Token CSRF no coincide'
      ],
      'solutions': [
        'Refrescar la página y volver a intentar',
        'Limpiar cache del navegador y cookies',
        'Verificar que JavaScript esté habilitado',
        'En .env, verificar SESSION_DRIVER y SESSION_LIFETIME'
      ]
    }
  ];

  final List<Map<String, dynamic>> _faqs = [
    {
      'question': '¿Cómo cambio mi contraseña?',
      'answer': 'Puedes cambiar tu contraseña desde el perfil de usuario dentro del sistema. Ve a "Mi Perfil" → "Cambiar Contraseña". Si no puedes acceder, contacta al administrador.'
    },
    {
      'question': '¿Qué hago si olvidé el usuario?',
      'answer': 'Contacta al administrador del sistema con tu información personal (nombre, correo) para que pueda recuperar tu usuario. No es posible recuperarlo automáticamente por seguridad.'
    },
    {
      'question': '¿Cómo hago copia de seguridad de la base de datos?',
      'answer': 'Puedes hacer backup desde phpMyAdmin: 1) Abre phpMyAdmin, 2) Selecciona tu base de datos, 3) Ve a la pestaña "Exportar", 4) Elige formato SQL y haz clic en "Continuar".'
    },
    {
      'question': '¿El sistema funciona en internet?',
      'answer': 'La instalación actual es local. Para ponerlo en internet necesitas: hosting con PHP, MySQL, dominio y configurar el .env con los datos del servidor remoto.'
    },
    {
      'question': '¿Cómo actualizo el sistema?',
      'answer': '1) Haz backup de la base de datos, 2) Descarga la nueva versión, 3) Reemplaza archivos (excepto .env), 4) Ejecuta: composer install, php artisan migrate, php artisan db:seed'
    }
  ];

  final List<Map<String, dynamic>> _maintenanceTips = [
    {
      'tip': 'Respaldar BD regularmente',
      'description': 'Realiza copias de seguridad semanales de la base de datos para prevenir pérdida de información.'
    },
    {
      'tip': 'No apagar el servidor a la fuerza',
      'description': 'Siempre detén Apache y MySQL desde XAMPP Control Panel antes de apagar la computadora.'
    },
    {
      'tip': 'Mantener XAMPP actualizado',
      'description': 'Actualiza XAMPP periódicamente para tener las últimas correcciones de seguridad.'
    },
    {
      'tip': 'Monitorear espacio en disco',
      'description': 'Verifica regularmente que tengas al menos 1GB de espacio libre para el funcionamiento óptimo.'
    },
    {
      'tip': 'Revisar logs periódicamente',
      'description': 'Consulta storage/logs/laravel.log para identificar problemas antes de que se vuelvan críticos.'
    }
  ];

  // Getter para errores filtrados
  List<Map<String, dynamic>> get _filteredErrors {
    if (_selectedCategory == 0) return _commonErrors;
    return _commonErrors.where((error) => 
      error['category'] == _categories[_selectedCategory]
    ).toList();
  }

  Future<void> _launchEmail() async {
    try {
      final subject = Uri.encodeComponent('Soporte - Sistema Integral de Calzados Aguilar');
      final body = Uri.encodeComponent(
        'Hola equipo de soporte,\n\n'
        'Necesito ayuda con el Sistema Integral de Calzados Aguilar.\n\n'
        'Problema que estoy experimentando:\n'
        '[Describe tu problema aquí]\n\n'
        'Pasos que ya intenté:\n'
        '[Lista los pasos que ya probaste]\n\n'
        'Información del sistema:\n'
        '- Sistema: Calzados Aguilar\n'
        '- Módulo afectado: [Especifica el módulo]\n'
        '- Error específico: [Describe el error]\n\n'
        'Espero su pronta respuesta.\n\n'
        'Saludos cordiales'
      );
      
      final uri = Uri.parse('mailto:$_supportEmail?subject=$subject&body=$body');
      
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        // Fallback: intentar abrir Gmail directamente
        final gmailUri = Uri.parse('https://mail.google.com/mail/?view=cm&fs=1&to=$_supportEmail&su=$subject&body=$body');
        if (await canLaunchUrl(gmailUri)) {
          await launchUrl(
            gmailUri,
            mode: LaunchMode.externalApplication,
          );
        } else {
          _showErrorSnackbar('No se pudo abrir la aplicación de correo. Verifica que tengas una app de email instalada.');
        }
      }
    } catch (e) {
      _showErrorSnackbar('Error al abrir el correo: $e');
    }
  }

  Future<void> _launchPhoneCall() async {
    try {
      // Solicitar permiso para llamadas
      final status = await Permission.phone.request();
      
      if (status.isGranted) {
        final uri = Uri.parse('tel:$_supportPhone');
        if (await canLaunchUrl(uri)) {
          await launchUrl(
            uri,
            mode: LaunchMode.externalApplication,
          );
        } else {
          _showErrorSnackbar('No se pudo realizar la llamada. Verifica que tu dispositivo pueda hacer llamadas.');
        }
      } else if (status.isPermanentlyDenied) {
        _showErrorSnackbar('El permiso de llamada fue denegado permanentemente. Actívalo en Configuración de la app.');
      } else {
        _showErrorSnackbar('Permiso de llamada denegado');
      }
    } catch (e) {
      _showErrorSnackbar('Error al realizar la llamada: $e');
    }
  }

  // Método mejorado para WhatsApp
  Future<void> _launchWhatsAppAlternative() async {
    try {
      final message = 'Hola, necesito soporte para el Sistema Integral de Calzados Aguilar. Tengo un problema que necesito resolver. ¿Podrían ayudarme por favor?';
      final whatsappNumber = _supportPhone.replaceAll(RegExp(r'[^0-9]'), '');
      
      // Lista de URLs a intentar en orden
      final urlsToTry = [
        'https://wa.me/$whatsappNumber?text=${Uri.encodeComponent(message)}',
        'https://api.whatsapp.com/send?phone=$whatsappNumber&text=${Uri.encodeComponent(message)}',
        'whatsapp://send?phone=$whatsappNumber&text=${Uri.encodeComponent(message)}',
        'https://web.whatsapp.com/send?phone=$whatsappNumber&text=${Uri.encodeComponent(message)}',
      ];
      
      bool launched = false;
      
      for (final url in urlsToTry) {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(
            uri,
            mode: LaunchMode.externalApplication,
          );
          launched = true;
          break;
        }
        // Pequeña pausa entre intentos
        await Future.delayed(const Duration(milliseconds: 100));
      }
      
      if (!launched) {
        _showErrorSnackbar('No se pudo abrir WhatsApp. Verifica que la aplicación esté instalada.');
      }
      
    } catch (e) {
      _showErrorSnackbar('Error al intentar abrir WhatsApp: $e');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _contactSupport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Contactar Soporte',
          style: AppTextStyles.heading2.copyWith(color: AppColors.primary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Elige tu método preferido:',
              style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: 16),
            _buildContactOption(
              icon: Icons.email,
              title: 'Correo Electrónico',
              subtitle: _supportEmail,
              onTap: () {
                Navigator.pop(context);
                _launchEmail();
                _showSuccessSnackbar('Abriendo aplicación de correo...');
              },
            ),
            const SizedBox(height: 12),
            _buildContactOption(
              icon: Icons.phone,
              title: 'Llamada Telefónica',
              subtitle: _supportPhone,
              onTap: () {
                Navigator.pop(context);
                _launchPhoneCall();
                _showSuccessSnackbar('Iniciando llamada...');
              },
            ),
            const SizedBox(height: 12),
            _buildContactOption(
              icon: Icons.chat,
              title: 'WhatsApp',
              subtitle: _supportPhone,
              onTap: () {
                Navigator.pop(context);
                _launchWhatsAppAlternative();
                _showSuccessSnackbar('Abriendo WhatsApp...');
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cerrar',
              style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        title: Text(title, style: AppTextStyles.body.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        )),
        subtitle: Text(subtitle, style: AppTextStyles.body.copyWith(
          color: AppColors.textSecondary,
          fontSize: 14,
        )),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
        onTap: onTap,
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // HEADER
            SliverAppBar(
              backgroundColor: AppColors.background,
              expandedHeight: 180,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withOpacity(0.9),
                        AppColors.primary,
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.support_agent,
                          size: 30,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Soporte y Errores Comunes",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Soluciones a problemas frecuentes y contacto de soporte",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // CONTENIDO PRINCIPAL
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // FILTRO DE CATEGORÍAS
                    _buildCategoryFilter(),
                    const SizedBox(height: 20),

                    // ERRORES FRECUENTES
                    _buildErrorsSection(),
                    const SizedBox(height: 24),

                    // PREGUNTAS FRECUENTES
                    _buildFAQSection(),
                    const SizedBox(height: 24),

                    // TIPS DE MANTENIMIENTO
                    _buildMaintenanceTipsSection(),
                    const SizedBox(height: 24),

                    // CONTACTO DE SOPORTE
                    _buildContactSection(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Filtrar por categoría:",
              style: AppTextStyles.body.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.asMap().entries.map((entry) {
                  final index = entry.key;
                  final category = entry.value;
                  final isSelected = _selectedCategory == index;

                  return Padding(
                    padding: EdgeInsets.only(right: 8, left: index == 0 ? 0 : 0),
                    child: FilterChip(
                      label: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = index;
                        });
                      },
                      backgroundColor: Colors.white,
                      selectedColor: AppColors.primary,
                      checkmarkColor: Colors.white,
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: AppColors.primary.withOpacity(0.3),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorsSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Errores Frecuentes",
              style: AppTextStyles.heading2.copyWith(
                color: AppColors.textPrimary,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Soluciones paso a paso para problemas comunes",
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            ..._filteredErrors.map((error) => _buildErrorCard(error)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorCard(Map<String, dynamic> error) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: ExpansionTile(
        leading: Icon(
          Icons.warning,
          color: AppColors.accent,
        ),
        title: Text(
          error['title'],
          style: AppTextStyles.body.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          error['description'],
          style: AppTextStyles.body.copyWith(
            color: AppColors.textSecondary,
            fontSize: 13,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Causas posibles:',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ...error['causes'].map<Widget>((cause) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.circle, size: 6, color: AppColors.textSecondary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          cause,
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
                const SizedBox(height: 12),
                Text(
                  'Soluciones:',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ...error['solutions'].map<Widget>((solution) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle, size: 14, color: AppColors.success),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          solution,
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Preguntas Frecuentes",
              style: AppTextStyles.heading2.copyWith(
                color: AppColors.textPrimary,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Respuestas a las dudas más comunes",
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            ..._faqs.map((faq) => _buildFAQItem(faq)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(Map<String, dynamic> faq) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: ExpansionTile(
        leading: Icon(
          Icons.help_outline,
          color: AppColors.primary,
        ),
        title: Text(
          faq['question'],
          style: AppTextStyles.body.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              faq['answer'],
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceTipsSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tips de Mantenimiento",
              style: AppTextStyles.heading2.copyWith(
                color: AppColors.textPrimary,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Buenas prácticas para mantener el sistema estable",
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _maintenanceTips.map((tip) => _buildTipCard(tip)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard(Map<String, dynamic> tip) {
    return Container(
      width: 150,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: AppColors.accent.withOpacity(0.2)),
        ),
        color: AppColors.accent.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.lightbulb_outline,
                size: 20,
                color: AppColors.accent,
              ),
              const SizedBox(height: 8),
              Text(
                tip['tip'],
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                tip['description'],
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              Icons.contact_support,
              size: 40,
              color: AppColors.primary,
            ),
            const SizedBox(height: 12),
            Text(
              "¿No encontraste solución?",
              style: AppTextStyles.heading2.copyWith(
                color: AppColors.textPrimary,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Contacta a nuestro equipo de soporte técnico",
              textAlign: TextAlign.center,
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Horarios: Lunes a Viernes 8:00 - 18:00",
              textAlign: TextAlign.center,
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _contactSupport,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.chat, size: 18),
                label: const Text('Contactar Soporte'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}