import 'package:get_storage/get_storage.dart';

class LocalStorage {
  final _storage = GetStorage();

  void write_session() {
    _storage.write('session', true);
  }

  void write_currentUser(email) {
    _storage.write('user', email);
  }

  read_currentUser() {
    var x = _storage.getKeys().toList();

    if (x.contains('user')) {
      return _storage.read('user');
    } else {
      return null;
    }
  }

  void write_createdAt() {
    _storage.write('createdAt', DateTime.now().toString());
  }

  void remove_session() {
    _storage.write('session', false);
  }

  read_createdAt() {
    var x = _storage.getKeys().toList();

    if (x.contains('createdAt')) {
      return _storage.read('createdAt');
    } else {
      return null;
    }
  }

  read_session() {
    var x = _storage.getKeys().toList();

    if (x.contains('session')) {
      return _storage.read('session');
    } else {
      return null;
    }
  }
}
