package com.nivisi.leafy_launcher

import android.app.ActivityOptions
import android.app.SearchManager
import android.content.*
import android.content.pm.ApplicationInfo
import android.content.pm.LauncherApps
import android.content.pm.ResolveInfo
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.Drawable
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.AlarmClock
import android.provider.Settings
import android.util.AttributeSet
import android.util.Base64
import android.view.View
import android.view.WindowInsets
import android.view.WindowManager
import com.nivisi.leafy_launcher.installed_packages.LauncherAppsCallback
import io.flutter.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import java.io.Serializable

class MainActivity: LeafyActivityBase() {
    private lateinit var _appMaps: List<Map<String, Serializable>>

    private var homeEventChannel: EventChannel? = null
    private var homeEventStreamHandler: StreamHandler = StreamHandler()
    private var appsChangedEventChannel: EventChannel? = null
    private var appsChangedEventStreamHandler: StreamHandlerParams<Map<String, Serializable>> = StreamHandlerParams()

    private var deleteAppResult: MethodChannel.Result? = null

    private var systemCameraAppPackage: String? = null

    override fun appName(): String {
        return "launcher"
    }

    override fun onResume() {
        super.onResume()

        overridePendingTransition(R.anim.app_launch_fade_in_long, R.anim.app_launch_fade_out_long)
    }

    private fun registerHomeEventChannel(flutterEngine: FlutterEngine) {
        homeEventChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger,
            homePressedChannel
        )
        homeEventChannel!!.setStreamHandler(homeEventStreamHandler)
    }

    private fun registerAppsChangedEventChannel(flutterEngine: FlutterEngine) {
        appsChangedEventChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger,
            appsChangedChannel
        )
        appsChangedEventChannel!!.setStreamHandler(appsChangedEventStreamHandler)

    }

    private fun openCameraApp(result: MethodChannel.Result) {
        if (systemCameraAppPackage == null) {
            val intent = Intent("android.media.action.IMAGE_CAPTURE")
            val options: ActivityOptions = getDefaultLaunchOptions()
            val launchIntent = packageManager.getLaunchIntentForPackage(
                intent.resolveActivity(packageManager).packageName
            )
            launchIntent?.flags = Intent.FLAG_ACTIVITY_NEW_TASK
            context.startActivity(launchIntent, options.toBundle())
            result.success(null)
            return
        }

        val options: ActivityOptions = getDefaultLaunchOptions()
        val launchIntent = packageManager.getLaunchIntentForPackage(
            systemCameraAppPackage!!
        )
        if (launchIntent != null ) {
            launchIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
            try {
                context.startActivity(launchIntent, options.toBundle())
                result.success(null)
            } catch (ex: ActivityNotFoundException) {
                result.error("No Camera App Activity", "error", "1")
            }

            return
        }

        result.error("No Camera App Activity", "error", "1")
    }

    private fun registerCommonChannel(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, commonChannel).setMethodCallHandler {
                call, result ->
            when (call.method) {
                launchGoogleSearchInput -> {
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
                        result.error("no activity", "error", "1")
                    }

                }
                launchSearch -> {
                    val arg = call.argument<String>(argumentLaunchQuery)
                    val intent = Intent(Intent.ACTION_WEB_SEARCH)
                    intent.putExtra(SearchManager.QUERY, arg)
                    startActivity(intent)
                    result.success(null)
                }
                openPhoneApp -> {
                    val intent = Intent(Intent.ACTION_DIAL)
                    val options: ActivityOptions = getDefaultLaunchOptions()
                    context.startActivity(intent, options.toBundle())
                    result.success(null)
                }
                openCameraApp -> {
                    openCameraApp(result)
                }
                openMessagesApp -> {
                    val intent = Intent(Intent.ACTION_MAIN)
                    intent.addCategory(Intent.CATEGORY_APP_MESSAGING)
                    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                    val options: ActivityOptions = getDefaultLaunchOptions()
                    context.startActivity(intent, options.toBundle())
                    result.success(null)
                }
                openClockApp -> {
                    val mClockIntent = Intent(AlarmClock.ACTION_SHOW_ALARMS)
                    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                    mClockIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                    val options: ActivityOptions = getDefaultLaunchOptions()
                    context.startActivity(mClockIntent, options.toBundle())
                    result.success(null)
                }
                openLauncherPreferences -> {
                    val intent = Intent(Settings.ACTION_MANAGE_DEFAULT_APPS_SETTINGS)
                    val options: ActivityOptions = getDefaultLaunchOptions()
                    context.startActivity(intent, options.toBundle())
                    result.success(null)
                }
                openLeafyNotes -> {
                    val intent = Intent(context, NotesActivity::class.java)
                    val options: ActivityOptions = getDefaultLaunchOptions()
                    context.startActivity(intent, options.toBundle())
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun registerApplicationChannel(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, applicationChannel).setMethodCallHandler {
                call, result ->

            when (call.method) {
                initApps -> {
                    getApps()
                    result.success(null)
                    return@setMethodCallHandler
                }
                launch -> {
                    launchApp(call, result)
                    return@setMethodCallHandler
                }
                getApps -> {
                    result.success(_appMaps)
                    return@setMethodCallHandler
                }
                getAppIcon -> {
                    val name = call.argument<String>(argumentPackageName)
                    val icon: Drawable = packageManager.getApplicationIcon(name!!)
                    val bitmap = getBitmapFromDrawable(icon)
                    if (bitmap == null)
                    {
                        result.success(null)
                        return@setMethodCallHandler
                    }

                    val encodedImage: String? = encodeToBase64(bitmap)
                    result.success(encodedImage)
                    return@setMethodCallHandler
                }
                deleteApp -> {
                    deleteAppResult = result
                    val name = call.argument<String>(argumentPackageName)
                    deleteApp(name!!)
                    return@setMethodCallHandler
                }
                viewInfo -> {
                    val name = call.argument<String>(argumentPackageName)
                    viewInfo(name!!)
                    result.success(null)
                    return@setMethodCallHandler
                }
                else -> result.notImplemented()
            }
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        self = this

        registerHomeEventChannel(flutterEngine)
        registerAppsChangedEventChannel(flutterEngine)

        registerCommonChannel(flutterEngine)
        registerApplicationChannel(flutterEngine)

        subscribeToInstalledAppsChanges()
    }

    private fun subscribeToInstalledAppsChanges() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            // Android < 8.0 (Oreo) still good to go with the receiver.
            // https://developer.android.com/guide/components/broadcast-exceptions

            val launcherAppsService = this.getSystemService(Context.LAUNCHER_APPS_SERVICE) ?: return

            if (launcherAppsService !is LauncherApps) {
                return
            }

            launcherAppsService.registerCallback(LauncherAppsCallback())
        }
    }

    override fun onCreateView(name: String, context: Context, attrs: AttributeSet): View? {
        @Suppress("DEPRECATION")
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            window.insetsController?.hide(WindowInsets.Type.statusBars())
        } else {
            window.setFlags(
                WindowManager.LayoutParams.FLAG_FULLSCREEN,
                WindowManager.LayoutParams.FLAG_FULLSCREEN
            )
        }

        return super.onCreateView(name, context, attrs)
    }

    override fun onCreateView(parent: View?, name: String, context: Context, attrs: AttributeSet): View? {
        @Suppress("DEPRECATION")
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            window.insetsController?.hide(WindowInsets.Type.statusBars())
        } else {
            window.setFlags(
                WindowManager.LayoutParams.FLAG_FULLSCREEN,
                WindowManager.LayoutParams.FLAG_FULLSCREEN
            )
        }
        return super.onCreateView(parent, name, context, attrs)
    }

    override fun onNewIntent(intent: Intent) {
        if (intent.action == Intent.ACTION_MAIN) {
            homeEventStreamHandler.dispatch()
        }

        super.onNewIntent(intent)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == UNINSTALL_REQUEST_CODE) {
            if (deleteAppResult == null) {
                return
            }

            when (resultCode) {
                0 -> {
                    deleteAppResult!!.success(true)
                }
                else -> deleteAppResult!!.success(false)
            }

            deleteAppResult = null
        }
    }

    private fun getDefaultLaunchOptions() : ActivityOptions {
        return ActivityOptions.makeCustomAnimation(context, R.anim.app_launch_fade_in, R.anim.app_launch_fade_out)
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
        drawable.setBounds(0, 0, canvas.width, canvas.height)
        drawable.draw(canvas)
        return bmp
    }

    private fun launchApp(call: MethodCall, result: MethodChannel.Result) {
        if (!call.hasArgument(argumentPackageName)) {
            result.error("No Package Name provided", null, null)

            return
        }

        var transition = 0

        if (call.hasArgument(argumentTransition)) {
            transition = call.argument<Int>(argumentTransition)!!
        }

        val packageName = call.argument<String>(argumentPackageName)

        val intent = context.packageManager.getLaunchIntentForPackage(packageName!!)

        if (intent == null) {
            result.error("Launch", "Apps was not launched.", "")

            return
        }

        intent.addFlags(Intent.FLAG_ACTIVITY_RESET_TASK_IF_NEEDED)

        val anim = when (transition) {
            0 -> R.anim.app_launch_fade_in
            1 -> R.anim.app_launch_left
            2 -> R.anim.app_launch_right
            else -> 0
        }

        val options: ActivityOptions = ActivityOptions.makeCustomAnimation(context, anim, R.anim.app_launch_fade_out)

        context.startActivity(intent, options.toBundle())

        result.success(true)
    }

    private fun getMap(name: String, packageName: String, isSystemApp: Boolean): Map<String, Serializable> {
        return mapOf(
                "name" to name,
                "package" to packageName,
                "isSystem" to isSystemApp
        )
    }

    private fun getApps() {
        val intent = Intent(Intent.ACTION_MAIN, null)
        intent.addCategory(Intent.CATEGORY_LAUNCHER)
        val list: List<ResolveInfo> = packageManager.queryIntentActivities(intent, 0)

        val apps = mutableListOf<Map<String, Serializable>>()

        for (resolveInfo in list) {
            val activityInfo = resolveInfo.activityInfo

            val packageName = activityInfo.packageName

            if (packageName == context.packageName) {
                continue
            }

            val name = activityInfo.loadLabel(packageManager).toString()

            val isSystemApp = activityInfo.applicationInfo.flags and ApplicationInfo.FLAG_SYSTEM != 0

            val map = getMap(name, packageName, isSystemApp)

            apps.add(map)
        }

        _appMaps = apps

        try {
            val cameraApps = packageManager.queryIntentActivities(
                Intent("android.media.action.IMAGE_CAPTURE"),
                0
            )
            val systemCameraApp = cameraApps.find { app ->
                app.activityInfo.flags and ApplicationInfo.FLAG_SYSTEM == 0
            }

            systemCameraAppPackage = systemCameraApp?.activityInfo?.packageName
        } catch (ex:Exception) {
            Log.e("MainActivity", "Unable to find the system camera app")
        }

    }

    private fun deleteApp(packageName: String) {
        val intent = Intent(Intent.ACTION_DELETE, Uri.parse("package:$packageName"))

        startActivityForResult(intent, UNINSTALL_REQUEST_CODE)
    }

    private fun viewInfo(packageName: String) {
        val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.parse("package:$packageName"))

        startActivity(intent)
    }

    fun dispatchAppChangedEvent(packageName: String, isRemoved: Boolean) {
        appsChangedEventStreamHandler.dispatch(
            mapOf(
                "package" to packageName,
                "isRemoved" to isRemoved
            )
        )
    }

    companion object {
        var self: MainActivity? = null

        private const val commonChannel = "com.nivisi.leafy_launcher/common"
        private const val applicationChannel = "com.nivisi.leafy_launcher/applicationChannel"
        private const val homePressedChannel = "com.nivisi.leafy_launcher/homePressedChannel"
        private const val appsChangedChannel = "com.nivisi.leafy_launcher/appsChangedChannel"

        private const val initApps = "initApps"
        private const val getApps = "getApps"
        private const val launch = "launch"
        private const val getAppIcon = "getAppIcon"
        private const val launchSearch = "launchSearch"
        private const val launchGoogleSearchInput = "launchGoogleSearchInput"
        private const val openPhoneApp = "openPhoneApp"
        private const val openCameraApp = "openCameraApp"
        private const val openMessagesApp = "openMessagesApp"
        private const val openClockApp = "openClockApp"
        private const val openLauncherPreferences = "openLauncherPreferences"
        private const val deleteApp = "deleteApp"
        private const val viewInfo = "viewInfo"
        private const val openLeafyNotes = "openLeafyNotes"

        private const val argumentPackageName = "packageName"
        private const val argumentTransition = "transition"
        private const val argumentLaunchQuery = "launchQuery"

        private const val UNINSTALL_REQUEST_CODE = 3213123
    }
}

class StreamHandler: EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null
    private var isCancelled: Boolean = false

    fun dispatch() {
        if (isCancelled) {
            return
        }

        if (eventSink == null) {
            Log.e(
                "StreamHandler",
                "Tried to fire an event, but eventSink was null"
            )

            return
        }

        try {
            eventSink!!.success(null)
        } catch (ex:Exception) {
            Log.e(
                "StreamHandler",
                "Tried to fire an event, but got an error " + ex.localizedMessage
            )
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        Log.i(
            "StreamHandler",
            "Started listening"
        )
        isCancelled = false
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        Log.i(
            "StreamHandlerParams",
            "Cancelled"
        )

        isCancelled = true
        eventSink = null
    }
}

class StreamHandlerParams<T>: EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null
    private var isCancelled: Boolean = false

    fun dispatch(param: T) {
        if (isCancelled) {
            return
        }

        if (eventSink == null) {
            Log.e(
                "StreamHandlerParams",
                "Tried to fire an event, but eventSink was null"
            )

            return
        }

        try {
            eventSink!!.success(param)
        } catch (ex:Exception) {
            Log.e(
                "StreamHandlerParams",
                "Tried to fire an event, but got an error " + ex.localizedMessage
            )
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        Log.i(
            "StreamHandlerParams",
            "Started listening"
        )
        isCancelled = false
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        Log.i(
            "StreamHandlerParams",
            "Cancelled"
        )

        isCancelled = true
        eventSink = null
    }
}