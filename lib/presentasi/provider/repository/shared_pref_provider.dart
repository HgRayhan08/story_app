import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:story_app/data/shared_preferennces/shared_pref_data.dart';

part 'shared_pref_provider.g.dart';

@riverpod
SharedPrefData sharedPrefData(SharedPrefDataRef ref) => SharedPrefData();
