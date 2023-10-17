import 'package:equatable/equatable.dart';

/// TaskList class
class TaskList extends Equatable {
  /// TaskList constructor
  const TaskList({
    required this.id,
    required this.name,
  });

  /// string id
  final String id;

  /// string name
  final String name;

  @override
  List<Object?> get props => [id, name];
}
