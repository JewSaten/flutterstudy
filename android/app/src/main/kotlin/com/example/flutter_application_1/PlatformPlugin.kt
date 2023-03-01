package com.example.flutter_application_1

import io.flutter.embedding.engine.plugins.FlutterPlugin

class PlatformPlugin : FlutterPlugin {

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        binding.platformViewRegistry.registerViewFactory("platform-view",NativeViewFactory())
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
       //
    }

}