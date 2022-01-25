package com.nivisi.leafy_launcher.broadcast_receivers

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.nivisi.leafy_launcher.MainActivity

class AppChangeReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context?, intent: Intent?) {
        val packageName = intent?.data?.encodedSchemeSpecificPart ?: return

        val isRemoved = intent.action == Intent.ACTION_PACKAGE_REMOVED

        MainActivity.self?.dispatchAppChangedEvent(packageName, isRemoved)
    }
}