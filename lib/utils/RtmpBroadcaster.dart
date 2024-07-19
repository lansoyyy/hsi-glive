// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/services.dart';

class RTMPBroadcaster {
  static const MethodChannel channel = MethodChannel('rtmp_broadcaster');

  RTMPBroadcaster() {
    channel.setMethodCallHandler(_handleNativeEvents);
  }

  Future<void> startStream(String url) async {
    try {
      await channel.invokeMethod('startStream', {"url": url});
      log('startStream successful');
    } on PlatformException catch (e) {
      log("Failed to start stream: ${e.message}");
    }
  }

  Future<void> stopStream() async {
    try {
      await channel.invokeMethod('stopStream');
    } on PlatformException catch (e) {
      log("Failed to stop stream: ${e.message}");
    }
  }

  Future<void> _handleNativeEvents(MethodCall call) async {
    switch (call.method) {
      case 'onConnectionSuccess':
        log('Connection successful');
        break;
      case 'onConnectionFailed':
        log('Connection failed: ${call.arguments}');
        break;
      case 'onDisconnect':
        log('Disconnected');
        break;
      case 'onAuthError':
        log('Authentication error');
        break;
      case 'onAuthSuccess':
        log('Authentication successful');
        break;
      default:
        log('Unknown event: ${call.method}');
    }
  }
}
