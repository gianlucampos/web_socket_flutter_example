library my_prj.globals;

import 'game_provider.dart';
import 'dart:developer' as devtools;

GameProvider gameProvider = GameProvider();
logger (String msg) => devtools.log(msg);