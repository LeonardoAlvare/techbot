import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:techbot/core/router/router.dart';
import 'package:techbot/core/theme/colors.dart';
import 'package:techbot/core/widgets/appbar.dart';
import 'package:techbot/core/widgets/toast.dart';
import 'package:techbot/features/home/ui/cubit/cubit.dart';
import 'package:techbot/features/home/widgets/create_subject_dialog.dart';

class HomePage extends StatelessWidget {
  final HomeCubit cubit;

  const HomePage({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit..getSubject(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'TeachBot',
          onLogout: () async {
            await cubit.logout();
            if (!context.mounted) return;
            context.goNamed(Routes.login);
          },
        ),
        body: _Body(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => CreateSubjectDialog(
                onChangeName: (value) => cubit.setName(value),
                onChangeDescription: (value) => cubit.setDescription(value),
                addSubject: () {
                  cubit.createSubject();
                  Navigator.pop(context);
                },
              ),
            );
          },
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

                if (state is HomeError) {
                  return const Center(
                    child: Text(
                      'Error al cargar las materias',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  );
                }

                if (state is SubjectCreatedSuccess) {
                  Toast.show(
                    context: context,
                    text: 'Materia creada con éxito',
                  );
                }

                return ListView.separated(
                  itemCount: subjects.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, index) => _SubjectCard(
                    name: subjects[index].name,
                    description: subjects[index].description,
                    id: subjects[index].id,
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
  final String description;
  final int id;

  const _SubjectCard({
    required this.name,
    required this.description,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.pushNamed(
              Routes.viewSubject,
              extra: {'idSubject': id, 'nameSubject': name},
            );
          },
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
                Expanded(
                  child: Column(
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
                        description,
                        maxLines: 3,
                        softWrap: true,
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
