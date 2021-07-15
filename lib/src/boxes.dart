import 'package:hive/hive.dart';

export 'boxes/settings.dart';
export 'boxes/favorites.dart';
export 'boxes/countdown.dart';
//export 'boxes/fontsize_setting.dart';
export 'boxes/fontsize_setting.dart';
export 'boxes/locale_setting.dart';
export 'boxes/theme_setting.dart';

Future<void> openBoxes() async {
  await Hive.openBox<int>('favorites');
  await Hive.openBox<int>('countdown');
  await Hive.openBox('settings');
}
