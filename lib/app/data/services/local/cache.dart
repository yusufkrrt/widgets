/// Minimal in-memory cache. Replace with get_storage / shared_preferences as needed.
class CacheService {
  CacheService._();

  static final _storage = <String, dynamic>{};

  static T? read<T>(String key) => _storage[key] as T?;

  static void write(String key, dynamic value) => _storage[key] = value;

  static void remove(String key) => _storage.remove(key);

  static void clear() => _storage.clear();
}
