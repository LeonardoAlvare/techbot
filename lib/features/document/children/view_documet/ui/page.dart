import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:techbot/features/document/children/view_documet/ui/cubit/cubit.dart';

class ViewDocumentPage extends StatelessWidget {
  final int documentId;
  final ViewDocumentCubit cubit;

  const ViewDocumentPage({
    super.key,
    required this.documentId,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit..getDocument(documentId),
      child: BlocBuilder<ViewDocumentCubit, ViewDocumentState>(
        builder: (context, state) {
          if (state is ViewDocumentLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is ViewDocumentError) {
            return Center(child: Text(state.message));
          }

          return PDFView(
            filePath: state.model.filePath,
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: true,
            pageFling: true,
          );
        },
      ),
    );
  }
}
