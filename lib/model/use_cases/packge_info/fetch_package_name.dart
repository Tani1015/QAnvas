import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:qanvas/model/repositories/package_info/packdge_info_repository.dart';

final fetchPackageNameProvider = Provider<String>((ref) => ref.read(packageInfoRepositoryProvider).packageName);