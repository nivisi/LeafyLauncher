package com.nivisi.leafy_launcher

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

public class AppChangeReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context?, intent: Intent?) {
        val packageName = intent?.data?.encodedSchemeSpecificPart ?: return

        val isRemoved = intent.action == Intent.ACTION_PACKAGE_REMOVED

        MainActivity.self.dispatchAppChangedEvent(packageName, isRemoved)
    }
}