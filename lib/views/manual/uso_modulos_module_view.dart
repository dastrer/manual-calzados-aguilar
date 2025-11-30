import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class UsoModulosModuleView extends StatelessWidget {
  const UsoModulosModuleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.all(AppSpacing.large),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Card(
            color: Colors.white,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.large),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.large),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ETIQUETA MÓDULO
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.medium,
                      vertical: AppSpacing.small,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: AppColors.accent.withOpacity(0.6),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      "MÓDULO 4 DE 5",
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.large),
                  const CircleAvatar(
                    radius: 34,
                    backgroundColor: Color(0x141A2B4C),
                    child: Icon(
                      Icons.view_module,
                      size: 40,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.large),
                  Text(
                    "Uso de los Módulos Principales",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.small),
                  Text(
                    "Guía para utilizar las principales funcionalidades del sistema web.",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.large),
                  Text(
                    "En este apartado se describirá el uso de los módulos clave del sistema "
                    "(por ejemplo: clientes, vehículos, servicios, inventario, pagos, reportes). "
                    "El objetivo es explicar, paso a paso, cómo utilizar cada módulo en las tareas "
                    "diarias del taller. La versión final incluirá flujos de trabajo, ejemplos prácticos "
                    "y pantallas ilustrativas.",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
