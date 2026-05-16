import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techbot/core/theme/colors.dart';
import 'package:techbot/core/widgets/buttons/buttons.dart';
import 'package:techbot/core/widgets/inputs.dart';
import 'package:techbot/features/view_subject/ui/cubit/cubit.dart';

class CreateDocumentDialog extends StatefulWidget {
  final int idSubject;

  const CreateDocumentDialog({super.key, required this.idSubject});

  @override
  State<CreateDocumentDialog> createState() => _CreateDocumentDialogState();
}

class _CreateDocumentDialogState extends State<CreateDocumentDialog> {
  File? _selectedFile;
  bool _isUploading = false;

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result == null || result.files.single.path == null) return;

      final file = File(result.files.single.path!);
      setState(() => _selectedFile = file);

      if (mounted) {
        context.read<ViewSubjectCubit>().setFile(file);
      }
    } catch (_) {}
  }

  void _submit() {
    if (_selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecciona un archivo')),
      );
      return;
    }
    context.read<ViewSubjectCubit>().uploadDocument(widget.idSubject);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ViewSubjectCubit, ViewSubjectState>(
      listener: (context, state) {
        if (state is UploadDocumentSuccess) {
          Navigator.pop(context);
        } else if (state is ViewSubjectLoading) {
          setState(() => _isUploading = true);
        } else if (state is UploadDocumentError || state is ViewSubjectLoaded) {
          setState(() => _isUploading = false);
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 1,
        backgroundColor: CustomColors.bgLight,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              CustomInput(
                hintText: 'Nombre',
                enabled: !_isUploading,
                onChanged: (value) =>
                    context.read<ViewSubjectCubit>().setNameDocument(value),
              ),
              const SizedBox(height: 16),
              _FilePicker(
                selectedFile: _selectedFile,
                isUploading: _isUploading,
                onTap: _pickFile,
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                onPressed: _submit,
                text: _isUploading ? 'Subiendo...' : 'Añadir Documento',
              ),
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
      ),
    );
  }
}

class _FilePicker extends StatelessWidget {
  final File? selectedFile;
  final bool isUploading;
  final VoidCallback onTap;

  const _FilePicker({
    required this.selectedFile,
    required this.isUploading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isUploading ? null : onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: CustomColors.lavender, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.attach_file_rounded, color: CustomColors.primary),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                selectedFile != null
                    ? selectedFile!.path.split('/').last
                    : 'Seleccionar archivo',
                style: TextStyle(
                  color: selectedFile != null
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
    );
  }
}
