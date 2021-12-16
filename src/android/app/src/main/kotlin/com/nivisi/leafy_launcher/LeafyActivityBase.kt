package com.nivisi.leafy_launcher

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


abstract class LeafyActivityBase: FlutterActivity() {
    abstract fun appName() :String

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.nivisi.leafy_launcher/app").setMethodCallHandler { call, result ->
            when (call.method) {
                "app" -> {
                    result.success(appName())
                    return@setMethodCallHandler
                }
                else -> result.notImplemented()
            }
        }
    }
}