package com.nivisi.leafy_launcher

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import java.io.Serializable


class AppChangeReceiver(private var handler: StreamHandlerParams<Map<String, Serializable>>) : BroadcastReceiver() {

    override fun onReceive(context: Context?, intent: Intent?) {
        val packageName = intent?.data?.encodedSchemeSpecificPart ?: return

        val removed = intent.action == Intent.ACTION_PACKAGE_REMOVED

        handler.dispatch(
            mapOf(
                "package" to packageName,
                "isRemoved" to removed
            )
        )
    }
}