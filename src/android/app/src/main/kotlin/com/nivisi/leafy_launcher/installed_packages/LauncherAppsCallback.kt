package com.nivisi.leafy_launcher.installed_packages

import android.content.pm.LauncherApps
import android.os.UserHandle
import com.nivisi.leafy_launcher.broadcast_receivers.AppChangeReceiver

class LauncherAppsCallback : LauncherApps.Callback() {
    override fun onPackageAdded(packageName: String, user: UserHandle) {
        AppChangeReceiver.handle(
            "android.intent.action.PACKAGE_ADDED",
            packageName,
            false
        )
    }

    override fun onPackageChanged(packageName: String, user: UserHandle) {
        // Not implemented
    }

    override fun onPackageRemoved(packageName: String, user: UserHandle) {
        AppChangeReceiver.handle(
            "android.intent.action.PACKAGE_REMOVED",
            packageName,
            false
        )
    }


    override fun onPackagesAvailable(
        packageNames: Array<out String>?,
        user: UserHandle?,
        replacing: Boolean
    ) {
        // Not implemented
    }

    override fun onPackagesUnavailable(
        packageNames: Array<out String>?,
        user: UserHandle?,
        replacing: Boolean
    ) {
        // Not implemented
    }
}