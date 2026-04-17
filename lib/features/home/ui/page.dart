import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:techbot/core/router/router.dart';
import 'package:techbot/core/theme/colors.dart';
import 'package:techbot/features/home/ui/cubit/cubit.dart';

part 'sections/header.dart';

class HomePage extends StatelessWidget {
  final HomeCubit cubit;
  final String token;

  const HomePage({super.key, required this.cubit, required this.token});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit..getSubject(token),
      child: Scaffold(
        appBar: _Header(
          onLogout: () => context.pushReplacementNamed(Routes.login),
        ),
        body: _Body(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: CustomColors.primary,
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text(
            'Añadir Materia',
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Mis Materias',
            style: TextStyle(
              color: CustomColors.primaryStrong,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Continúa con tu progreso académico hoy.',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final subjects = state.model.subjects;

                if (subjects == null || subjects.isEmpty) {
                  return const Center(
                    child: Text(
                      'No hay materias cargadas',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: subjects.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, index) => _SubjectCard(
                    name: subjects[index].name ?? '',
                    documentCount:
                        subjects[index].count?.documents?.toInt() ?? 0,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SubjectCard extends StatelessWidget {
  final String name;
  final int? documentCount;

  const _SubjectCard({required this.name, this.documentCount});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: CustomColors.lavender, width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: CustomColors.bgLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.book_rounded,
                color: CustomColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: CustomColors.primaryStrong,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$documentCount Documentos',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
