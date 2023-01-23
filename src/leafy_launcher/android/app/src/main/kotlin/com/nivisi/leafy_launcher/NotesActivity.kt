package com.nivisi.leafy_launcher

import android.app.ActivityManager
import android.os.Bundle
import android.os.PersistableBundle
import io.flutter.embedding.engine.FlutterEngine


class NotesActivity: LeafyActivityBase() {
    override fun onResume() {
        super.onResume()

        overridePendingTransition(R.anim.app_launch_fade_in_long, R.anim.app_launch_fade_out_long)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val title: String = resources.getString(R.string.leafy_notes_title)

        setTaskDescription(ActivityManager.TaskDescription(title))
    }

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)

        val title: String = resources.getString(R.string.leafy_notes_title)

        setTaskDescription(ActivityManager.TaskDescription(title))
    }

    override fun appName(): String {
        return "leafyNotes"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        self = this
    }

    companion object {
        var self: NotesActivity? = null
    }
}