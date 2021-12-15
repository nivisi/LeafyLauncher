package com.nivisi.leafy_launcher

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine


class NotesActivity: FlutterActivity() {
    override fun onResume() {
        super.onResume()

        overridePendingTransition(R.anim.app_launch_fade_in_long, R.anim.app_launch_fade_out_long)
    }

    override fun getDartEntrypointFunctionName(): String {
        return "mainNotes";
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        self = this
    }

    companion object {
        lateinit var self: NotesActivity
    }
}