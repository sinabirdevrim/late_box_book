package com.onerevolutionstudio.late_box_book

import com.onerevolutionstudio.late_box_book.common.FirebaseCloudMessagingPluginRegistrant
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService

class LBApplication : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {

    override fun onCreate() {
        super.onCreate()
        FlutterFirebaseMessagingService.setPluginRegistrant(this)
    }

    override fun registerWith(p0: PluginRegistry?) {
        FirebaseCloudMessagingPluginRegistrant.registerWith(p0)

    }


}