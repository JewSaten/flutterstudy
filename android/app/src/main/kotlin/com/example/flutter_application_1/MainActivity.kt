package com.example.flutter_application_1

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.jetbrains.annotations.NotNull

class MainActivity : FlutterActivity() {
    private val CHANNEL = "flutter.dev/channel"

    override fun configureFlutterEngine(@NotNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            // This method is invoked on the main thread.
                call, result ->

            when (call.method) {
                "getBatteryLevel" -> {
                    val batteryLevel = getBatteryLevel()

                    if (batteryLevel != -1) {
                        result.success(batteryLevel)
                    } else {
                        result.error("错误", "电量获取失败", null)
                    }
                }
                "showToast" -> {
                    Toast.makeText(context, call.argument("msg"), Toast.LENGTH_LONG).show()
                    result.success(1)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("platform-view", NativeViewFactory())
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(
                Intent.ACTION_BATTERY_CHANGED))
            batteryLevel =
                intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(
                    BatteryManager.EXTRA_SCALE,
                    -1)
        }

        return batteryLevel
    }

}
