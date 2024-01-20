import 'package:equatable/equatable.dart';

abstract class RepositoryFailure extends Equatable {
  const RepositoryFailure();

  @override
  List<Object?> get props => [];
}

class RepositoryConnectionFailure extends RepositoryFailure {
  const RepositoryConnectionFailure();
}

class RepositoryForbiddenErrorFailure extends RepositoryFailure {
  const RepositoryForbiddenErrorFailure();
}

class RepositoryNotFoundErrorFailure extends RepositoryFailure {
  const RepositoryNotFoundErrorFailure();
}

class RepositoryInternalErrorFailure extends RepositoryFailure {
  const RepositoryInternalErrorFailure();
}

class RepositoryBadRequestErrorFailure extends RepositoryFailure {
  const RepositoryBadRequestErrorFailure();
}

class RepositoryUnknownFailure extends RepositoryFailure {
  final String? _message;
  const RepositoryUnknownFailure(this._message);

  @override
  String toString() {
    return "RepositoryUnknownFailure(); Exception message was: $message";
  }

  @override
  List<Object?> get props => [_message];

  String? get message => _message;
}
