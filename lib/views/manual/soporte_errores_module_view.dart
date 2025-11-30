import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class SoporteErroresModuleView extends StatelessWidget {
  const SoporteErroresModuleView({super.key});

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
                      "MÓDULO 5 DE 5",
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
                      Icons.support_agent,
                      size: 40,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.large),
                  Text(
                    "Soporte y Errores Comunes",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.small),
                  Text(
                    "Guía para resolver problemas frecuentes y contactar soporte.",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.large),
                  Text(
                    "En esta sección se documentarán los errores más comunes durante la instalación "
                    "y el uso del sistema, así como sus posibles soluciones. También se podrá incluir "
                    "información de contacto para soporte técnico, buenas prácticas y recomendaciones "
                    "para mantener el sistema funcionando de forma correcta.",
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
