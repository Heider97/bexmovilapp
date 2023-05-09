package com.example.bexmovil


import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

    companion object {
        const val METHOD_CHANNEL_NAME = "io.bexmovil.utils"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            METHOD_CHANNEL_NAME
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "preventScreenCapture" -> {
                    call.argument<Boolean>("enable")?.let {
                        if (it) {
                            window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
                        } else {
                            window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
                        }

                        result.success(null)
                    } ?: run {
                        result.error("1", "Missing parameters", "Missing parameter 'enable'")
                    }
                }
            }
        }
    }
}
