package com.nivisi.leafy_launcher.broadcast_receivers

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.nivisi.leafy_launcher.MainActivity

class DateChangedBroadcastReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action == Intent.ACTION_DATE_CHANGED) {
            MainActivity.self.dispatchDateChangedEvent()
        }
    }
}