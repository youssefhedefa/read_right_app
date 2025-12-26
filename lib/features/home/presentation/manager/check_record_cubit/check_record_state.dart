enum CheckRecordEnum {
  initial,
  loading,
  success,
  error,
}

class CheckRecordState {
  final CheckRecordEnum state;
  final String? error;
  final String? success;

  CheckRecordState({required this.state, this.error, this.success});

  CheckRecordState copyWith({
    CheckRecordEnum? state,
    String? error,
    String? success,
  }) {
    return CheckRecordState(
      state: state ?? this.state,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }

  @override
  String toString() {
    return 'CheckRecordState(state: $state, error: $error, success: $success)';
  }
}
