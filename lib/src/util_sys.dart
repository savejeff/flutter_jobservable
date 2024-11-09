import 'opt.dart';


import 'dart:developer';


void LogE(String tag, String msg) {
  log(msg, name: tag, level: 1000);
}


void LogW(String tag, String msg) {
  log(msg, name: tag, level: 900);
}


void Log(String tag, String msg) {
  log(msg, name: tag, level: 800);
}


void LogD(String tag, String msg) {
  if(opt.debug) {
    log(msg, name: tag, level: 700);
  }
}


void LogV(String tag, String msg) {
  if(opt.verbose) {
    log(msg, name: tag, level: 600);
  }
}




