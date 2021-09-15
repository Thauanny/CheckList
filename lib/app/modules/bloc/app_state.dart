part of 'app_bloc.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class AppNoteRegistred extends AppState {}

class AppAddNoteLoaded extends AppState {}

class AppRemoveSucess extends AppState {}

class AppRemoveError extends AppState {}
