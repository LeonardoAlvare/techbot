import 'package:flutter/material.dart';
import 'package:techbot/core/theme/colors.dart';
import 'package:techbot/core/widgets/buttons/buttons.dart';
import 'package:techbot/core/widgets/inputs.dart';

class CreateSubjectDialog extends StatelessWidget {
  final void Function(String)? onChangeName;
  final void Function(String)? onChangeDescription;
  final void Function() addSubject;

  const CreateSubjectDialog({
    super.key,
    required this.onChangeName,
    required this.onChangeDescription,
    required this.addSubject,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 1,
      backgroundColor: CustomColors.bgLight,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Crear Materia',
              style: TextStyle(
                color: CustomColors.textDark,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            CustomInput(hintText: 'Nombre', onChanged: onChangeName),
            const SizedBox(height: 10),
            CustomInput(
              hintText: 'Descripción',
              maxLines: 5,
              onChanged: onChangeDescription,
            ),
            const SizedBox(height: 20),
            PrimaryButton(onPressed: addSubject, text: 'Crear Materia'),
            const SizedBox(height: 10),
            PrimaryButton(
              onPressed: () => Navigator.pop(context),
              text: 'Cancelar',
              backgroundColor: CustomColors.lavender,
              foregroundColor: CustomColors.textDark,
            ),
          ],
        ),
      ),
    );
  }
}
