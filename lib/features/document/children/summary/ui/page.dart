import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techbot/features/document/children/summary/ui/cubit/cubit.dart';
import 'package:techbot/features/document/widgets/button_add.dart';

class SummaryPage extends StatelessWidget {
  final int documentId;
  final SummaryCubit cubit;
  const SummaryPage({super.key, required this.documentId, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: BlocProvider.value(
        value: cubit..getSummary(documentId),
        child: _Content(documentId),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final int documentId;
  const _Content(this.documentId);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SummaryCubit, SummaryState>(
      builder: (context, state) {
        if (state is SummaryLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is SummaryError) {
          return Center(child: Text(state.message));
        }

        return Stack(
          children: [
            Center(
              child: state.model.summary?.content?.isNotEmpty == true
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      margin: const EdgeInsets.only(bottom: 60),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          state.model.summary?.content ??
                              'No hay resumen disponible',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                    )
                  : Text('No hay resumen disponible'),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: ButtonAdd(
                onPressed: () =>
                    context.read<SummaryCubit>().createSummary(documentId),
                text: 'Nuevo Resumen',
              ),
            ),
          ],
        );
      },
    );
  }
}
