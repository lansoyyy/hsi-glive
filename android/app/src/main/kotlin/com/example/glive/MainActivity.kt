package com.example.glive

import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "rtmp_broadcaster"
    private lateinit var rtmpBroadcaster: RtmpBroadcaster

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "startStream" -> {
                        val url = call.argument<String>("url")
                        startStream(url)
                        result.success(null)
                    }
                    "stopStream" -> {
                        stopStream()
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }

        rtmpBroadcaster =  RtmpBroadcaster( MainActivity() , this)

    }

    private fun startStream(url: String?) {
        if (rtmpBroadcaster != null && url != null) {
            rtmpBroadcaster?.startStream(url)
        }
    }

    private fun stopStream() {
        if(rtmpBroadcaster != null){
            rtmpBroadcaster?.stopStream()
        }

    }

     fun sendEventToFlutter(event: String) {
        flutterEngine?.dartExecutor?.binaryMessenger?.let {
            MethodChannel(it, CHANNEL)
                .invokeMethod(event, null)
        }
    }

     fun sendEventToFlutter(event: String, message: String) {
        flutterEngine?.dartExecutor?.binaryMessenger?.let {
            MethodChannel(it, CHANNEL)
                .invokeMethod(event, message)
        }
    }
}


//Add library 'Gradle: com.github.pedroSG94.rtmp-rtsp-stream-client-java:rtmp:1.9.6@aar' to classpath