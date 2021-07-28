package com.example.leafy_launcher

import android.app.ActivityOptions
import android.app.SearchManager
import android.content.ActivityNotFoundException
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.ResolveInfo
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.Drawable
import android.os.Bundle
import android.provider.AlarmClock
import android.util.Base64
import android.view.KeyEvent
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream

class MainActivity: FlutterActivity() {
    private lateinit var _appMaps: List<Map<String, String>>

    private var homeEventChannel: EventChannel? = null
    private var homeEventStreamHandler: StreamHandler = StreamHandler()

    override fun onResume() {
        super.onResume()

        overridePendingTransition(R.anim.app_launch_fade_long, R.anim.app_launch_fade_long)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        homeEventChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger, Companion.homePressedChannel)
        homeEventChannel!!.setStreamHandler(homeEventStreamHandler)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, Companion.commonChannel).setMethodCallHandler {
            call, result ->
            when (call.method) {
                Companion.launchGoogleSearchInput -> {
                   val searchManager = context.getSystemService(Context.SEARCH_SERVICE) as SearchManager
                    val globalSearchActivity: ComponentName? = searchManager.globalSearchActivity
                    if (globalSearchActivity == null) {
                        result.error("no activity", "la", "1")
                        return@setMethodCallHandler
                    }
                    val intent = Intent(SearchManager.INTENT_ACTION_GLOBAL_SEARCH)
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    intent.component = globalSearchActivity
                    val appSearchData = Bundle()
                    appSearchData.putString("source", packageName)

                    intent.putExtra(SearchManager.APP_DATA, appSearchData)
                    intent.putExtra(SearchManager.QUERY, "")
                    intent.putExtra(SearchManager.EXTRA_SELECT_QUERY, true)
                    try {
                        context.startActivity(intent)
                        result.success(null)
                    } catch (ex: ActivityNotFoundException) {
                        result.error("no activity", "lala", "1")
                    }

                }
                Companion.launchSearch -> {
                   val arg = call.argument<String>(Companion.argumentLaunchQuery);

                   val intent = Intent(Intent.ACTION_WEB_SEARCH)
                   intent.putExtra(SearchManager.QUERY, arg)
                   startActivity(intent)
                   
                   result.success(null)

                }
                Companion.openPhoneApp -> {
                    val intent = Intent(Intent.ACTION_DIAL)

                    val options: ActivityOptions = ActivityOptions.makeCustomAnimation(context, R.anim.app_launch_fade, 0)
                    context.startActivity(intent, options.toBundle())
                }
                Companion.openCameraApp -> {
                    val intent = Intent("android.media.action.IMAGE_CAPTURE")

                    val options: ActivityOptions = ActivityOptions.makeCustomAnimation(context, R.anim.app_launch_fade, 0)

                    val launchIntent = packageManager.getLaunchIntentForPackage(
                            intent.resolveActivity(packageManager).packageName
                    )

                    context.startActivity(launchIntent, options.toBundle())
                }
                Companion.openMessagesApp -> {
                    val intent = Intent(Intent.ACTION_MAIN)
                    intent.addCategory(Intent.CATEGORY_APP_MESSAGING)

                    val options: ActivityOptions = ActivityOptions.makeCustomAnimation(context, R.anim.app_launch_fade, 0)

                    context.startActivity(intent, options.toBundle())
                }
                Companion.openClockApp -> {
                    val mClockIntent = Intent(AlarmClock.ACTION_SHOW_ALARMS)
                    mClockIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK

                    val options: ActivityOptions = ActivityOptions.makeCustomAnimation(context, R.anim.app_launch_fade, 0)

                    context.startActivity(mClockIntent, options.toBundle())
                }
                Companion.openLauncherPreferences -> {
                    val intent = Intent(android.provider.Settings.ACTION_MANAGE_DEFAULT_APPS_SETTINGS)

                    val options: ActivityOptions = ActivityOptions.makeCustomAnimation(context, R.anim.app_launch_fade, 0)

                    context.startActivity(intent, options.toBundle())
                }
                else -> result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, Companion.applicationChannel).setMethodCallHandler {
            call, result ->

            when (call.method) {
                Companion.initApps -> {
                    getApps()

                    result.success(null)

                    return@setMethodCallHandler
                }
                Companion.launch -> {
                    launchApp(call, result)

                    return@setMethodCallHandler
                }
                Companion.getApps -> {
                    result.success(_appMaps)

                    return@setMethodCallHandler
                }
                Companion.getAppIcon -> {
                    val name = call.argument<String>(Companion.argumentPackageName)

                    val icon: Drawable = packageManager.getApplicationIcon(name!!)
                    val bitmap = getBitmapFromDrawable(icon)
                    if (bitmap == null)
                    {
                        result.success(null)
                        return@setMethodCallHandler
                    }

                    val encodedImage: String? = encodeToBase64(bitmap!!)

                    result.success(encodedImage)

                    return@setMethodCallHandler
                }
                else -> result.notImplemented()
            }
        }
    }

    override fun onNewIntent(intent: Intent) {
        if (intent.action == Intent.ACTION_MAIN) {
            homeEventStreamHandler.dispatch()
        }

        super.onNewIntent(intent)
    }

    private fun encodeToBase64(image: Bitmap): String? {

        val byteArrayOS = ByteArrayOutputStream()
        image.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOS)
        return Base64.encodeToString(byteArrayOS.toByteArray(), Base64.NO_WRAP)
    }

    private fun getBitmapFromDrawable(drawable: Drawable): Bitmap? {
        val bmp = Bitmap.createBitmap(
                drawable.intrinsicWidth,
                drawable.intrinsicHeight,
                Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bmp)
        drawable.setBounds(0, 0, canvas.getWidth(), canvas.getHeight())
        drawable.draw(canvas)
        return bmp
    }

    private fun launchApp(call: MethodCall, result: MethodChannel.Result) {
        if (!call.hasArgument(Companion.argumentPackageName)) {
            result.error("No Package Name provided", null, null);

            return
        }

        var transition = 0

        if (call.hasArgument(Companion.argumentTransition)) {
            transition = call.argument<Int>(Companion.argumentTransition)!!
        }

        var packageName = call.argument<String>(Companion.argumentPackageName);

        val intent = context.packageManager.getLaunchIntentForPackage(packageName!!)

        if (intent == null) {
            result.error("Launch", "Apps was not launched.", "")

            return
        }

        intent.addFlags(Intent.FLAG_ACTIVITY_RESET_TASK_IF_NEEDED)

        var anim = when (transition) {
            0 -> R.anim.app_launch_fade;
            1 -> R.anim.app_launch_left
            2 -> R.anim.app_launch_right
            else -> 0
        }

        val options: ActivityOptions = ActivityOptions.makeCustomAnimation(context, anim, 0)

        context.startActivity(intent, options.toBundle())

        result.success(true)
    }

    private fun getMap(name: String, packageName: String): Map<String, String> {
        return mapOf<String, String>("name" to name, "package" to packageName);
    }

    private fun getApps() {
        val intent = Intent(Intent.ACTION_MAIN, null)
        intent.addCategory(Intent.CATEGORY_LAUNCHER)
        val list: List<ResolveInfo> = packageManager.queryIntentActivities(intent, 0)

        val apps = mutableListOf<Map<String, String>>()

        for (resolveInfo in list) {
            val name = resolveInfo.activityInfo.loadLabel(packageManager).toString()
            val packageName = resolveInfo.activityInfo.packageName

            val map = getMap(name, packageName)

            apps.add(map)
        }

        _appMaps = apps;
    }

    companion object {
        private const val commonChannel = "com.nivisi.leafy_launcher/common";
        private const val applicationChannel = "com.nivisi.leafy_launcher/applicationChannel";
        private const val homePressedChannel = "com.nivisi.leafy_launcher/homePressedChannel";

        private const val initApps = "initApps";
        private const val getApps = "getApps";
        private const val launch = "launch";
        private const val getAppIcon = "getAppIcon";
        private const val launchSearch = "launchSearch";
        private const val launchGoogleSearchInput = "launchGoogleSearchInput";
        private const val openPhoneApp = "openPhoneApp";
        private const val openCameraApp = "openCameraApp";
        private const val openMessagesApp = "openMessagesApp";
        private const val openClockApp = "openClockApp";
        private const val openLauncherPreferences = "openLauncherPreferences";

        private const val argumentPackageName = "packageName";
        private const val argumentTransition = "transition";
        private const val argumentLaunchQuery = "launchQuery";
    }
}

class StreamHandler: EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null

    fun dispatch() {
        eventSink!!.success(null)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events;
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

}