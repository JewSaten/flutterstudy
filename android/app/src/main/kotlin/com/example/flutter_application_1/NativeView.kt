package com.example.flutter_application_1

import android.content.Context
import android.view.View
import android.widget.EditText
import io.flutter.plugin.platform.PlatformView

internal class NativeView(context: Context,id: Int, creationParams: Map<String?,Any?>?) : PlatformView{
    private val editText: EditText = EditText(context)

    init {
        editText.id = id
        editText.hint = "测试nativeview"
        editText.setText("native view from android")
    }
    override fun getView(): View?  = editText

    override fun dispose() {

    }

}