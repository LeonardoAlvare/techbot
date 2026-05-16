import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techbot/core/theme/colors.dart';
import 'package:techbot/features/view_subject/ui/cubit/cubit.dart';
import 'package:techbot/features/view_subject/widgets/create_document_dialog.dart';

class ViewSubjectPage extends StatelessWidget {
  final int idSubject;
  final String nameSubject;
  final ViewSubjectCubit cubit;

  const ViewSubjectPage({
    super.key,
    required this.idSubject,
    required this.nameSubject,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit..getDocuments(idSubject),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.bgLight,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: CustomColors.lavender,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: CustomColors.primary,
                size: 18,
              ),
            ),
          ),
          title: Text(
            nameSubject,
            style: const TextStyle(
              color: CustomColors.textDark,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
        ),
        body: _Body(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => BlocProvider.value(
                value: cubit,
                child: CreateDocumentDialog(idSubject: idSubject),
              ),
            );
          },
          backgroundColor: CustomColors.primary,
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text(
            'Añadir Documento',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: BlocBuilder<ViewSubjectCubit, ViewSubjectState>(
        builder: (context, state) {
          if (state is ViewSubjectLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ViewSubjectError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
            );
          }

          final documents = state.model.documents;

          if (documents == null || documents.isEmpty) {
            return const Center(
              child: Text(
                'No hay documentos cargados',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: documents.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) =>
                _DocumentCard(title: documents[index].title ?? ''),
          );
        },
      ),
    );
  }
}

class _DocumentCard extends StatelessWidget {
  final String title;

  const _DocumentCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: navegar al detalle del documento
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: CustomColors.lavender, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: CustomColors.primary.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [CustomColors.primary, CustomColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.description_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: CustomColors.primaryStrong,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.1,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right_rounded,
              color: CustomColors.primaryLight,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
