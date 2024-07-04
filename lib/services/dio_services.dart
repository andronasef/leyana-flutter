import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:path_provider/path_provider.dart';

class DioService {
  static Dio? _instance;

  static Future<void> init() async {
    final dir = await getApplicationCacheDirectory();
    _instance = Dio();
    _instance!.interceptors.add(
      DioCacheInterceptor(
        options: CacheOptions(
          store: FileCacheStore(dir.path),
          policy: CachePolicy.request,
          hitCacheOnErrorExcept: [401, 403],
        ),
      ),
    );
  }

  static Future<Dio> getInstance() async {
    if (_instance == null) {
      await init();
    }
    return _instance!;
  }
}
