package com.nivisi.leafy_launcher.broadcast_receivers

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.nivisi.leafy_launcher.MainActivity
import java.util.*

class DeviceLocaleChangedBroadcastReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action == Intent.ACTION_LOCALE_CHANGED) {
            MainActivity.self.dispatchDeviceLocaleChangedEvent(
                Locale.getDefault().toLanguageTag()
            )
        }
    }
}