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
import android.os.PersistableBundle
import android.util.Base64
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream

class MainActivity: FlutterActivity() {
    private lateinit var _appMaps: List<Map<String, String>>

    override fun onResume() {
        super.onResume()

        overridePendingTransition(R.anim.app_launch_fade, R.anim.app_launch_fade)

    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

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
        private const val initApps = "initApps";
        private const val getApps = "getApps";
        private const val launch = "launch";
        private const val getAppIcon = "getAppIcon";
        private const val launchSearch = "launchSearch";
        private const val launchGoogleSearchInput = "launchGoogleSearchInput";

        private const val argumentPackageName = "packageName";
        private const val argumentTransition = "transition";
        private const val argumentLaunchQuery = "launchQuery";
    }
}
