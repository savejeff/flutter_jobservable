library jobservable;

export 'src/observable_base.dart';
export 'src/observable_value.dart';
export 'src/observable_state.dart';
export 'src/observable_list.dart';

import 'src/opt.dart';

class jObservableConfig {

  static setDebug(bool debug, bool verbose) {
    opt.debug = debug;
    opt.verbose = verbose;
  }

}