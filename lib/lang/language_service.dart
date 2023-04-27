import 'dart:ui';

import 'package:translatebebasan/translatebebasan.dart';
import 'id_id.dart';

class LanguageService extends Glosarium {
  @override
  Map<String, Map<String, String>> get keys => {
        'id_ID': id_ID,
      };

  @override
  List<Locale> get supportedLocales => const [
        Locale('id', 'ID'),
      ];
}
