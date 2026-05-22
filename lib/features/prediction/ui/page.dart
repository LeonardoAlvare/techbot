import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techbot/core/widgets/appbar.dart';
import 'package:techbot/core/widgets/buttons/buttons.dart';
import 'package:techbot/features/prediction/ui/cubit/cubit.dart';

class PredictionPage extends StatelessWidget {
  final PredictionCubit cubit;
  const PredictionPage({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Predicción',
          onBack: () => Navigator.pop(context),
          centerTitle: true,
        ),
        body: _Content(),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: BlocBuilder<PredictionCubit, PredictionState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Resultado
              Expanded(child: _buildResult(state)),

              // Botón
              PrimaryButton(
                text: 'Predecir',
                onPressed: state is PredictionLoading
                    ? () {}
                    : () => context.read<PredictionCubit>().predict(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildResult(PredictionState state) {
    if (state is PredictionLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is PredictionError) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
            SizedBox(height: 12),
            Text(
              'Ocurrió un error al realizar la predicción.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.redAccent),
            ),
          ],
        ),
      );
    }

    final prediction = state.model.prediction;

    if (prediction == null) {
      return const Center(
        child: Text(
          'Presiona el botón para obtener una predicción.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ResultCard(
            icon: Icons.lightbulb_outline,
            label: 'Resultado',
            value: prediction.resultado ?? '-',
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ResultCard(
                  icon: Icons.verified_outlined,
                  label: 'Confianza',
                  value: prediction.confianza != null
                      ? '${prediction.confianza!.toStringAsFixed(1)}%'
                      : '-',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ResultCard(
                  icon: Icons.percent,
                  label: 'Probabilidad',
                  value: prediction.probabilidad != null
                      ? '${(prediction.probabilidad! * 100).toStringAsFixed(2)}%'
                      : '-',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ResultCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 28),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
