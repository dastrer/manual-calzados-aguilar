import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../utils/constants.dart';

class ConfiguracionInicialModuleView extends StatefulWidget {
  const ConfiguracionInicialModuleView({super.key});

  @override
  State<ConfiguracionInicialModuleView> createState() => _ConfiguracionInicialModuleViewState();
}

class _ConfiguracionInicialModuleViewState extends State<ConfiguracionInicialModuleView> {
  final List<bool> _completedSteps = List.generate(4, (index) => false);
  bool _moduleCompleted = false;

  final List<Map<String, dynamic>> _steps = [
    {
      'title': 'Configurar archivo .env',
      'description': 'Configura las variables de entorno del proyecto Laravel',
      'icon': Icons.settings,
      'videoUrl': 'https://youtube.com/...',
      'fileUrl': 'env_ejemplo.txt',
      'folderUrl': 'https://drive.google.com/...',
    },
    {
      'title': 'Ejecutar comandos de instalación',
      'description': 'Ejecuta el archivo batch con: composer install, npm install, php artisan migrate --seed',
      'icon': Icons.play_arrow,
      'videoUrl': 'https://youtube.com/...',
      'fileUrl': 'comandos_instalacion.bat',
      'folderUrl': 'https://drive.google.com/...',
    },
    {
      'title': 'Iniciar servidor Laravel',
      'description': 'Ejecuta el batch con: php artisan serve',
      'icon': Icons.rocket_launch,
      'videoUrl': 'https://youtube.com/...',
      'fileUrl': 'iniciar_servidor.bat',
      'folderUrl': 'https://drive.google.com/...',
    },
    {
      'title': 'Abrir en navegador',
      'description': 'Abre http://localhost:8000 en tu navegador web',
      'icon': Icons.public,
      'videoUrl': 'https://youtube.com/...',
      'fileUrl': 'acceso_rapido.url',
      'folderUrl': 'https://drive.google.com/...',
    },
  ];

  void _toggleStep(int index) {
    setState(() {
      _completedSteps[index] = !_completedSteps[index];
      _checkModuleCompletion();
    });
  }

  void _checkModuleCompletion() {
    final allCompleted = _completedSteps.every((step) => step);
    setState(() {
      _moduleCompleted = allCompleted;
    });
  }

  void _markModuleAsCompleted() {
    setState(() {
      _moduleCompleted = true;
      for (int i = 0; i < _completedSteps.length; i++) {
        _completedSteps[i] = true;
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('¡Configuración inicial completada!'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _launchVideo(String videoUrl) async {
    final uri = Uri.parse(videoUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      _showErrorSnackbar('No se pudo abrir el video');
    }
  }

  Future<void> _saveFile(String fileName) async {
    final status = await Permission.storage.request();
    
    if (status.isGranted) {
      try {
        _showSuccessSnackbar('Archivo $fileName descargado correctamente');
      } catch (e) {
        _showErrorSnackbar('Error al descargar el archivo: $e');
      }
    } else {
      _showErrorSnackbar('Permiso de almacenamiento denegado');
    }
  }

  Future<void> _launchFolder(String folderUrl) async {
    final uri = Uri.parse(folderUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      _showErrorSnackbar('No se pudo abrir la carpeta');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
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
                          Icons.settings,
                          size: 30,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Configuración Inicial",
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
                          "Primer inicio de sesión, creación de usuarios y parámetros básicos del sistema",
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

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildProgressCard(),
                    const SizedBox(height: 16),
                    _buildStepsList(),
                    const SizedBox(height: 16),
                    _buildCompletionSection(),
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

  Widget _buildProgressCard() {
    final completedCount = _completedSteps.where((step) => step).length;
    final progress = _steps.isEmpty ? 0.0 : completedCount / _steps.length;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Progreso de configuración",
                    style: AppTextStyles.heading2.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  "${(progress * 100).toInt()}%",
                  style: AppTextStyles.heading2.copyWith(
                    color: AppColors.primary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.backgroundVariant,
              color: AppColors.success,
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
            const SizedBox(height: 8),
            Text(
              "$completedCount de ${_steps.length} pasos completados",
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepsList() {
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
              "Pasos de configuración",
              style: AppTextStyles.heading2.copyWith(
                color: AppColors.textPrimary,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Completa estos pasos para poner en marcha el sistema",
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            ..._steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              final isCompleted = _completedSteps[index];

              return _buildStepItem(
                step: step,
                index: index,
                isCompleted: isCompleted,
                isLast: index == _steps.length - 1,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem({
    required Map<String, dynamic> step,
    required int index,
    required bool isCompleted,
    required bool isLast,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isCompleted 
                      ? AppColors.success.withOpacity(0.1)
                      : AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isCompleted ? AppColors.success : AppColors.primary,
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  step['icon'],
                  size: 18,
                  color: isCompleted ? AppColors.success : AppColors.primary,
                ),
              ),
              if (!isLast)
                Container(
                  width: 1.5,
                  height: 16,
                  margin: const EdgeInsets.only(top: 2),
                  color: AppColors.textSecondary.withOpacity(0.2),
                ),
            ],
          ),
          
          const SizedBox(width: 12),
          
          Expanded(
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isCompleted 
                      ? AppColors.success.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.1),
                  width: 1,
                ),
              ),
              color: isCompleted 
                  ? AppColors.success.withOpacity(0.02)
                  : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Paso ${index + 1}: ${step['title']}',
                                style: AppTextStyles.heading2.copyWith(
                                  color: isCompleted 
                                      ? AppColors.textSecondary 
                                      : AppColors.textPrimary,
                                  decoration: isCompleted 
                                      ? TextDecoration.lineThrough 
                                      : TextDecoration.none,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                step['description'],
                                style: AppTextStyles.body.copyWith(
                                  color: isCompleted 
                                      ? AppColors.textSecondary.withOpacity(0.7)
                                      : AppColors.textSecondary,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Checkbox(
                          value: isCompleted,
                          onChanged: (value) => _toggleStep(index),
                          activeColor: AppColors.success,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // TRES BOTONES EN LA MISMA FILA
                    SizedBox(
                      height: 32,
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildCompactButton(
                              icon: Icons.play_arrow,
                              label: 'Video',
                              isFilled: true,
                              onPressed: () => _launchVideo(step['videoUrl']),
                            ),
                          ),
                          const SizedBox(width: 6),
                          
                          Expanded(
                            child: _buildCompactButton(
                              icon: Icons.save_alt,
                              label: 'Guardar',
                              isFilled: false,
                              onPressed: () => _saveFile(step['fileUrl']),
                            ),
                          ),
                          const SizedBox(width: 6),
                          
                          Expanded(
                            child: _buildCompactButton(
                              icon: Icons.folder_open,
                              label: 'Carpeta',
                              isFilled: false,
                              onPressed: () => _launchFolder(step['folderUrl']),
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
        ],
      ),
    );
  }

  Widget _buildCompactButton({
    required IconData icon,
    required String label,
    required bool isFilled,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 32,
      child: isFilled
          ? FilledButton(
              onPressed: onPressed,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                visualDensity: VisualDensity.compact,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 14),
                  const SizedBox(width: 2),
                  Text(
                    label,
                    style: const TextStyle(fontSize: 11),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                visualDensity: VisualDensity.compact,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 14),
                  const SizedBox(width: 2),
                  Text(
                    label,
                    style: const TextStyle(fontSize: 11),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildCompletionSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_moduleCompleted) ...[
              Icon(
                Icons.verified,
                size: 50,
                color: AppColors.success,
              ),
              const SizedBox(height: 12),
              Text(
                "Configuración Completada",
                textAlign: TextAlign.center,
                style: AppTextStyles.heading2.copyWith(
                  color: AppColors.success,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Has completado todos los pasos. El sistema está listo para usar.",
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
            ] else ...[
              Text(
                "¿Completaste la configuración?",
                textAlign: TextAlign.center,
                style: AppTextStyles.heading2.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Marca todos los pasos como completados o usa el botón para finalizar",
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _markModuleAsCompleted,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, size: 18),
                      SizedBox(width: 8),
                      Text('Completar configuración'),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}