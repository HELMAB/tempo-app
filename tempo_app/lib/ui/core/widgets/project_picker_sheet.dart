import 'package:flutter/material.dart';

import '../../../domain/models/project.dart';
import '../localization.dart';
import 'project_chip.dart';

/// The user's choice; `projectId` is null for "No project".
typedef ProjectChoice = ({int? projectId});

/// Lets the user pick one of [projects]. Returns null when dismissed.
Future<ProjectChoice?> showProjectPicker(
  BuildContext context, {
  required List<Project> projects,
  required int? selectedId,
}) {
  return showModalBottomSheet<ProjectChoice>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) =>
        _ProjectPicker(projects: projects, selectedId: selectedId),
  );
}

class _ProjectPicker extends StatelessWidget {
  const _ProjectPicker({required this.projects, required this.selectedId});

  final List<Project> projects;
  final int? selectedId;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Widget option(Project? project) {
      final id = project?.id;
      return ListTile(
        leading: ProjectDot(project: project, size: 12),
        title: Text(project?.name ?? context.l10n.noProject),
        trailing: id == selectedId ? const Icon(Icons.check) : null,
        onTap: () => Navigator.pop<ProjectChoice>(context, (projectId: id)),
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.7,
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 16),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              context.l10n.projectPickerTitle,
              style: textTheme.titleMedium,
            ),
          ),
          for (final project in projects) option(project),
          option(null),
        ],
      ),
    );
  }
}
