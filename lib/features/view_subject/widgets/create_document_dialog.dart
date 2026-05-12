import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:techbot/core/theme/colors.dart';
import 'package:techbot/core/widgets/buttons/buttons.dart';
import 'package:techbot/core/widgets/inputs.dart';

class CreateDocumentDialog extends StatelessWidget {
  final void Function(String)? onChangeName;
  final void Function() addDocument;
  final void Function(File file) onFileSelected; // 👈 nuevo
  final String? selectedFileName; // 👈 para mostrar el nombre

  const CreateDocumentDialog({
    super.key,
    required this.onChangeName,
    required this.addDocument,
    required this.onFileSelected,
    this.selectedFileName,
  });

  Future<void> _pickFile() async {
    final result = await FilePicker.pickFiles();
    if (result != null) {
      onFileSelected(File(result.files.single.path!));
    }
  }

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
              'Añadir Documento',
              style: TextStyle(
                color: CustomColors.textDark,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            CustomInput(hintText: 'Nombre', onChanged: onChangeName),
            const SizedBox(height: 16),
            // TODO: Review this widget
            GestureDetector(
              onTap: _pickFile,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: CustomColors.lavender, width: 1.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.attach_file_rounded,
                      color: CustomColors.primary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        selectedFileName ?? 'Seleccionar archivo',
                        style: TextStyle(
                          color: selectedFileName != null
                              ? CustomColors.textDark
                              : Colors.grey,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(onPressed: addDocument, text: 'Añadir Documento'),
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
