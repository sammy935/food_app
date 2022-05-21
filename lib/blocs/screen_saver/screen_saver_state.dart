part of 'screen_saver_cubit.dart';

abstract class ScreenSaverState extends Equatable {
  const ScreenSaverState();
}

class ScreenSaverInitial extends ScreenSaverState {
  @override
  List<Object> get props => [];
}

class ScreenSaverFailed extends ScreenSaverState {
  @override
  List<Object> get props => [];
}

class ScreenSaverCompleted extends ScreenSaverState {
  const ScreenSaverCompleted(this.element);
  final ScreenSaverMaster element;
  @override
  List<Object> get props => [element];
}

class ScreenSaverLoadingInProgress extends ScreenSaverState {
  @override
  List<Object> get props => [];
}
