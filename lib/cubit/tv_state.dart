part of 'tv_cubit.dart';

enum TvStatus { initial, loading, success, failure }

class TvState extends Equatable {
  const TvState({this.status = TvStatus.initial, this.tvList, this.exception});

  final TvStatus status;
  final List<TvModel>? tvList;
  final Exception? exception;

  @override
  List<Object?> get props => [status, tvList, exception];

  TvState copyWith({
    TvStatus? status,
    List<TvModel>? tvList,
    Exception? exception,
  }) {
    return TvState(
        status: status ?? this.status,
        tvList: tvList ?? this.tvList,
        exception: exception ?? this.exception);
  }
}
