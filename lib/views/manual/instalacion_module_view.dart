import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class InstalacionModuleView extends StatefulWidget {
  const InstalacionModuleView({super.key});

  @override
  State<InstalacionModuleView> createState() => _InstalacionModuleViewState();
}

class _InstalacionModuleViewState extends State<InstalacionModuleView> {
  final List<bool> _completedSteps = List.generate(9, (index) => false);
  bool _moduleCompleted = false;

  final List<Map<String, dynamic>> _steps = [
    {
      'title': 'Descargar archivos',
      'description': 'Descarga el paquete completo desde Google Drive',
      'icon': Icons.download,
      'videoUrl': 'https://youtube.com/...',
      'folderUrl': 'https://drive.google.com/...',
    },
    {
      'title': 'Instalar XAMPP',
      'description': 'Instala XAMPP para servidor web y MySQL',
      'icon': Icons.storage,
      'videoUrl': 'https://youtube.com/...',
      'folderUrl': 'https://drive.google.com/...',
    },
    {
      'title': 'Instalar Node.js',
      'description': 'Instala Node.js para dependencias JavaScript',
      'icon': Icons.developer_mode,
      'videoUrl': 'https://youtube.com/...',
      'folderUrl': 'https://drive.google.com/...',
    },
    {
      'title': 'Instalar Composer',
      'description': 'Instala Composer para dependencias PHP',
      'icon': Icons.terminal,
      'videoUrl': 'https://youtube.com/...',
      'folderUrl': 'https://drive.google.com/...',
    },
    {
      'title': 'Copiar a htdocs',
      'description': 'Copia archivos a htdocs e inicia Apache y MySQL',
      'icon': Icons.folder_copy,
      'videoUrl': 'https://youtube.com/...',
      'folderUrl': 'https://drive.google.com/...',
    },
    {
      'title': 'Configurar .env',
      'description': 'Configura variables de entorno del proyecto',
      'icon': Icons.settings,
      'videoUrl': 'https://youtube.com/...',
      'folderUrl': 'https://drive.google.com/...',
    },
    {
      'title': 'Ejecutar comandos',
      'description': 'Ejecuta composer install, migraciones y seeders',
      'icon': Icons.play_arrow,
      'videoUrl': 'https://youtube.com/...',
      'folderUrl': 'https://drive.google.com/...',
    },
    {
      'title': 'Iniciar servidor',
      'description': 'Ejecuta php artisan serve',
      'icon': Icons.rocket_launch,
      'videoUrl': 'https://youtube.com/...',
      'folderUrl': 'https://drive.google.com/...',
    },
    {
      'title': 'Abrir navegador',
      'description': 'Abre http://localhost:8000',
      'icon': Icons.public,
      'videoUrl': 'https://youtube.com/...',
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
        content: const Text('¡Instalación completada!'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
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
            // HEADER FIJADO
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
                          Icons.install_desktop,
                          size: 30,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Instalación del Sistema",
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
                          "Guía completa para configurar el entorno",
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
                    // ESTADÍSTICAS RÁPIDAS
                    _buildProgressCard(),
                    const SizedBox(height: 16),

                    // LISTA DE PASOS
                    _buildStepsList(),
                    const SizedBox(height: 16),

                    // BOTÓN DE COMPLETAR
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
                    "Progreso de instalación",
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
              "Pasos de instalación",
              style: AppTextStyles.heading2.copyWith(
                color: AppColors.textPrimary,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Sigue estos pasos en orden para configurar el sistema",
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
          // INDICADOR CON LÍNEA
          Column(
            children: [
              // ICONO DEL PASO
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
              // LÍNEA CONECTORA
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
          
          // CONTENIDO DEL PASO
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
                                step['title'],
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
                    
                    // BOTONES DE ACCIÓN - VERTICAL EN MÓVIL
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth < 200) {
                          // DISPOSICIÓN VERTICAL PARA PANTALLAS MUY PEQUEÑAS
                          return Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: FilledButton.icon(
                                  onPressed: () {
                                    // Abrir video
                                  },
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppColors.accent,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                  ),
                                  icon: const Icon(Icons.play_arrow, size: 16),
                                  label: const Text('Video guía'),
                                ),
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    // Abrir carpeta
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppColors.primary,
                                    side: BorderSide(color: AppColors.primary),
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                  ),
                                  icon: const Icon(Icons.folder_open, size: 16),
                                  label: const Text('Abrir carpeta'),
                                ),
                              ),
                            ],
                          );
                        } else {
                          // DISPOSICIÓN HORIZONTAL PARA PANTALLAS NORMALES
                          return Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: [
                              FilledButton.icon(
                                onPressed: () {
                                  // Abrir video
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.accent,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  visualDensity: VisualDensity.compact,
                                ),
                                icon: const Icon(Icons.play_arrow, size: 14),
                                label: const Text(
                                  'Video',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              OutlinedButton.icon(
                                onPressed: () {
                                  // Abrir carpeta
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  side: BorderSide(color: AppColors.primary),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  visualDensity: VisualDensity.compact,
                                ),
                                icon: const Icon(Icons.folder_open, size: 14),
                                label: const Text(
                                  'Carpeta',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          );
                        }
                      },
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
                "Instalación Completada",
                textAlign: TextAlign.center,
                style: AppTextStyles.heading2.copyWith(
                  color: AppColors.success,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Has completado todos los pasos. El sistema está listo.",
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
            ] else ...[
              Text(
                "¿Completaste la instalación?",
                textAlign: TextAlign.center,
                style: AppTextStyles.heading2.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Marca los pasos o usa el botón para finalizar",
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
                      Text('Completar instalación'),
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