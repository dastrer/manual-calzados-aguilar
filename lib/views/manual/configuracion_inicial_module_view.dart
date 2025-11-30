import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class ConfiguracionInicialModuleView extends StatelessWidget {
  const ConfiguracionInicialModuleView({super.key});

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
                      "MÓDULO 3 DE 5",
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
                      Icons.settings,
                      size: 40,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.large),
                  Text(
                    "Configuración Inicial",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.small),
                  Text(
                    "Primer inicio de sesión, creación de usuarios y parámetros básicos del sistema.",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.large),
                  Text(
                    "En esta sección se documentarán los pasos posteriores a la instalación: "
                    "acceso inicial al sistema, creación del usuario administrador, "
                    "configuración de datos de la empresa, parámetros generales y seguridad básica. "
                    "Más adelante se incluirán capturas de pantalla y ejemplos de configuraciones recomendadas.",
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
