import 'package:equatable/equatable.dart';

import '../../../model/data_model.dart';

class DataEvent extends Equatable {
  final List<Datum> oldData;
  final bool isFirstFetch;
  const DataEvent(this.oldData, this.isFirstFetch);
  @override
  List<Object?> get props => [oldData, isFirstFetch];
}
