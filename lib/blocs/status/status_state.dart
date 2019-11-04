import 'package:equatable/equatable.dart';

abstract class StatusState extends Equatable {
  const StatusState();

  @override
  List<Object> get props => [];
}

class StatusLoading extends StatusState {}

class StatusLoaded extends StatusState {
  final int numActive;
  final int numCompleted;

  const StatusLoaded(this.numActive, this.numCompleted);

  @override
  List<Object> get props => [numActive, numCompleted];

  @override
  String toString() => 'StatusLoaded { numActive: $numActive, numCompleted: $numCompleted}';
}