package com.nivisi.leafy_launcher

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel


abstract class LeafyActivityBase: FlutterActivity() {
    abstract fun appName() :String

    private var deviceLocaleChangedEventChannel: EventChannel? = null
    private var deviceLocaleChangedEventStreamHandler: StreamHandlerParams<String> = StreamHandlerParams()

    private fun registerDeviceLocaleChangedEventChannel(flutterEngine: FlutterEngine) {
        deviceLocaleChangedEventChannel = EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            deviceLocaleChangedChannel
        )
        deviceLocaleChangedEventChannel!!.setStreamHandler(deviceLocaleChangedEventStreamHandler)
    }

    fun dispatchDeviceLocaleChangedEvent(locale: String) {
        deviceLocaleChangedEventStreamHandler.dispatch(locale)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        registerDeviceLocaleChangedEventChannel(flutterEngine)

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

    companion object {
        private const val deviceLocaleChangedChannel = "com.nivisi.leafy_launcher/deviceLocaleChangedChannel"
    }
}