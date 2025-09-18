package com.chilimarketapp

import android.content.Intent
import android.net.Uri
import com.facebook.react.ReactActivity
import com.facebook.react.ReactActivityDelegate
import com.facebook.react.defaults.DefaultNewArchitectureEntryPoint.fabricEnabled
import com.facebook.react.defaults.DefaultReactActivityDelegate
import com.facebook.react.bridge.Arguments
import com.facebook.react.modules.core.DeviceEventManagerModule

class MainActivity : ReactActivity() {

  /**
   * Returns the name of the main component registered from JavaScript. This is used to schedule
   * rendering of the component.
   */
  override fun getMainComponentName(): String = "ChiliMarketApp"

  /**
   * Returns the instance of the [ReactActivityDelegate]. We use [DefaultReactActivityDelegate]
   * which allows you to enable New Architecture with a single boolean flags [fabricEnabled]
   */
  override fun createReactActivityDelegate(): ReactActivityDelegate =
      DefaultReactActivityDelegate(this, mainComponentName, fabricEnabled)

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
    super.onActivityResult(requestCode, resultCode, data)
    
    // Send activity result to React Native for handling in NativeFeaturesModule
    val params = Arguments.createMap().apply {
      putInt("requestCode", requestCode)
      putInt("resultCode", resultCode)
      if (data != null) {
        putString("dataUri", data.dataString)
        if (data.clipData != null) {
          val uris = Arguments.createArray()
          for (i in 0 until data.clipData!!.itemCount) {
            uris.pushString(data.clipData!!.getItemAt(i).uri.toString())
          }
          putArray("multipleUris", uris)
        }
      }
    }
    
    reactInstanceManager.currentReactContext
      ?.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter::class.java)
      ?.emit("ActivityResult", params)
  }
}
