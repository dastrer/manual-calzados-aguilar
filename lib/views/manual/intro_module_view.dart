import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class IntroModuleView extends StatelessWidget {
  const IntroModuleView({super.key});

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
                      "MÓDULO 1 DE 5",
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
                    backgroundColor: Color(0x141A2B4C), // primary con opacidad
                    child: Icon(
                      Icons.menu_book,
                      size: 40,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.large),
                  Text(
                    "Introducción y Alcance del Manual",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.small),
                  Text(
                    "Descripción general del sistema web, objetivos del manual y público al que está dirigido.",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.large),
                  Text(
                    "En esta sección se presentará una visión global del sistema web, "
                    "su propósito dentro de la microempresa y el alcance del manual de instalación y uso. "
                    "Aquí podrás entender qué resuelve el sistema, a quién va dirigido y cómo está estructurada "
                    "la documentación para facilitar su aprendizaje.",
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
