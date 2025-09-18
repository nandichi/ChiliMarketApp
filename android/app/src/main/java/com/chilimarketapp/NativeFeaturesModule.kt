package com.chilimarketapp

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.hardware.biometrics.BiometricManager
import android.hardware.biometrics.BiometricPrompt
import android.net.Uri
import android.os.Build
import android.os.VibrationEffect
import android.os.Vibrator
import android.provider.Settings
import androidx.biometric.BiometricPrompt as AndroidXBiometricPrompt
import androidx.biometric.BiometricManager as AndroidXBiometricManager
import androidx.core.content.ContextCompat
import androidx.fragment.app.FragmentActivity
import com.facebook.react.bridge.*
import com.facebook.react.modules.core.DeviceEventManagerModule
import com.facebook.react.bridge.ActivityEventListener
import java.util.concurrent.Executor
import android.content.pm.ApplicationInfo
import android.os.Bundle
import android.provider.DocumentsContract
import android.security.keystore.KeyGenParameterSpec
import android.security.keystore.KeyProperties
import android.util.Base64 
import java.security.KeyStore
import javax.crypto.Cipher
import javax.crypto.KeyGenerator
import javax.crypto.SecretKey
import javax.crypto.spec.IvParameterSpec
import android.content.SharedPreferences
import androidx.security.crypto.EncryptedSharedPreferences
import androidx.security.crypto.MasterKey
import android.Manifest
import androidx.core.app.ActivityCompat
import android.webkit.WebView
import android.webkit.WebViewClient
import android.app.AlertDialog
import android.widget.LinearLayout
import android.content.ComponentName
import android.content.pm.ResolveInfo
import java.io.File
import android.provider.MediaStore
import android.database.Cursor
import androidx.activity.result.PickVisualMediaRequest
import androidx.activity.result.contract.ActivityResultContracts

class NativeFeaturesModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {
    
    init {
        // Listen for activity results from MainActivity
        reactContext.addActivityEventListener(object : ActivityEventListener {
            override fun onActivityResult(activity: Activity, requestCode: Int, resultCode: Int, data: Intent?) {
                handleActivityResult(requestCode, resultCode, data)
            }
            
            override fun onNewIntent(intent: Intent) {}
        })
    }
    
    companion object {
        private const val MODULE_NAME = "NativeFeatures"
        private const val KEYSTORE_ALIAS = "ChiliMarketKeystore"
        private const val SHARED_PREFS_NAME = "chili_market_secure_prefs"
        private const val REQUEST_CODE_BIOMETRIC = 1001
        private const val REQUEST_CODE_FILE_PICKER = 1002
        private const val REQUEST_CODE_CAMERA_PERMISSION = 1003
        private const val REQUEST_CODE_PHOTO_PICKER = 1005
    }
    
    private var currentBiometricPromise: Promise? = null
    private var currentFilePickerPromise: Promise? = null
    private var currentPhotoPickerPromise: Promise? = null
    
    override fun getName(): String = MODULE_NAME
    
    // MARK: - System Info
    @ReactMethod
    fun getSystemInfo(promise: Promise) {
        try {
            val context = reactApplicationContext
            val packageManager = context.packageManager
            val packageInfo = packageManager.getPackageInfo(context.packageName, 0)
            val applicationInfo = packageManager.getApplicationInfo(context.packageName, PackageManager.GET_META_DATA)
            
            val systemInfo = Arguments.createMap().apply {
                putString("appName", applicationInfo.loadLabel(packageManager).toString())
                putString("appVersion", packageInfo.versionName)
                putString("buildNumber", packageInfo.versionCode.toString())
                putString("bundleId", context.packageName)
                putString("systemVersion", Build.VERSION.RELEASE)
                putString("deviceModel", "${Build.MANUFACTURER} ${Build.MODEL}")
                putString("platform", "android")
                putInt("apiLevel", Build.VERSION.SDK_INT)
            }
            
            promise.resolve(systemInfo)
        } catch (e: Exception) {
            promise.reject("SYSTEM_INFO_ERROR", "Failed to get system info: ${e.message}", e)
        }
    }
    
    // MARK: - Biometric Authentication
    @ReactMethod
    fun checkBiometricSupport(promise: Promise) {
        try {
            val context = reactApplicationContext
            val biometricManager = AndroidXBiometricManager.from(context)
            
            val result = Arguments.createMap()
            
            when (biometricManager.canAuthenticate(AndroidXBiometricManager.Authenticators.BIOMETRIC_WEAK)) {
                AndroidXBiometricManager.BIOMETRIC_SUCCESS -> {
                    result.putBoolean("isSupported", true)
                    result.putString("biometricType", "biometric")
                    result.putString("status", "available")
                }
                AndroidXBiometricManager.BIOMETRIC_ERROR_NO_HARDWARE -> {
                    result.putBoolean("isSupported", false)
                    result.putString("status", "noHardware")
                }
                AndroidXBiometricManager.BIOMETRIC_ERROR_HW_UNAVAILABLE -> {
                    result.putBoolean("isSupported", false)
                    result.putString("status", "unavailable")
                }
                AndroidXBiometricManager.BIOMETRIC_ERROR_NONE_ENROLLED -> {
                    result.putBoolean("isSupported", false)
                    result.putString("status", "notEnrolled")
                }
                else -> {
                    result.putBoolean("isSupported", false)
                    result.putString("status", "unknown")
                }
            }
            
            promise.resolve(result)
        } catch (e: Exception) {
            promise.reject("BIOMETRIC_CHECK_ERROR", "Failed to check biometric support: ${e.message}", e)
        }
    }
    
    @ReactMethod
    fun authenticateWithBiometric(reason: String, promise: Promise) {
        try {
            val activity = currentActivity as? FragmentActivity
            if (activity == null) {
                promise.reject("NO_ACTIVITY", "No current activity found", null)
                return
            }
            
            val biometricManager = AndroidXBiometricManager.from(activity)
            if (biometricManager.canAuthenticate(AndroidXBiometricManager.Authenticators.BIOMETRIC_WEAK) != AndroidXBiometricManager.BIOMETRIC_SUCCESS) {
                promise.reject("BIOMETRIC_NOT_AVAILABLE", "Biometric authentication not available", null)
                return
            }
            
            currentBiometricPromise = promise
            
            val executor = ContextCompat.getMainExecutor(activity)
            val biometricPrompt = AndroidXBiometricPrompt(activity, executor, object : AndroidXBiometricPrompt.AuthenticationCallback() {
                override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
                    super.onAuthenticationError(errorCode, errString)
                    currentBiometricPromise?.reject("BIOMETRIC_ERROR", errString.toString(), null)
                    currentBiometricPromise = null
                }
                
                override fun onAuthenticationSucceeded(result: AndroidXBiometricPrompt.AuthenticationResult) {
                    super.onAuthenticationSucceeded(result)
                    val resultMap = Arguments.createMap().apply {
                        putBoolean("success", true)
                        putString("message", "Authentication successful")
                    }
                    currentBiometricPromise?.resolve(resultMap)
                    currentBiometricPromise = null
                }
                
                override fun onAuthenticationFailed() {
                    super.onAuthenticationFailed()
                    currentBiometricPromise?.reject("BIOMETRIC_FAILED", "Authentication failed", null)
                    currentBiometricPromise = null
                }
            })
            
            val promptInfo = AndroidXBiometricPrompt.PromptInfo.Builder()
                .setTitle("Biometrische authenticatie")
                .setSubtitle(reason)
                .setNegativeButtonText("Annuleren")
                .build()
            
            biometricPrompt.authenticate(promptInfo)
            
        } catch (e: Exception) {
            promise.reject("BIOMETRIC_AUTH_ERROR", "Failed to authenticate: ${e.message}", e)
        }
    }
    
    // MARK: - Haptic Feedback
    @ReactMethod
    fun triggerImpactHaptic(intensity: String, promise: Promise) {
        try {
            val context = reactApplicationContext
            val vibrator = context.getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
            
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                val effect = when (intensity) {
                    "light" -> VibrationEffect.createOneShot(50, VibrationEffect.DEFAULT_AMPLITUDE)
                    "medium" -> VibrationEffect.createOneShot(100, VibrationEffect.DEFAULT_AMPLITUDE)
                    "heavy" -> VibrationEffect.createOneShot(150, VibrationEffect.DEFAULT_AMPLITUDE)
                    else -> VibrationEffect.createOneShot(100, VibrationEffect.DEFAULT_AMPLITUDE)
                }
                vibrator.vibrate(effect)
            } else {
                val duration = when (intensity) {
                    "light" -> 50L
                    "medium" -> 100L
                    "heavy" -> 150L
                    else -> 100L
                }
                @Suppress("DEPRECATION")
                vibrator.vibrate(duration)
            }
            
            promise.resolve(true)
        } catch (e: Exception) {
            promise.reject("HAPTIC_ERROR", "Failed to trigger haptic: ${e.message}", e)
        }
    }
    
    @ReactMethod
    fun triggerNotificationHaptic(type: String, promise: Promise) {
        try {
            val context = reactApplicationContext
            val vibrator = context.getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
            
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                val pattern = when (type) {
                    "success" -> longArrayOf(0, 100, 50, 100)
                    "warning" -> longArrayOf(0, 200, 100, 200)
                    "error" -> longArrayOf(0, 300, 100, 300, 100, 300)
                    else -> longArrayOf(0, 100)
                }
                val effect = VibrationEffect.createWaveform(pattern, -1)
                vibrator.vibrate(effect)
            } else {
                val duration = when (type) {
                    "success" -> 200L
                    "warning" -> 300L
                    "error" -> 400L
                    else -> 100L
                }
                @Suppress("DEPRECATION")
                vibrator.vibrate(duration)
            }
            
            promise.resolve(true)
        } catch (e: Exception) {
            promise.reject("HAPTIC_ERROR", "Failed to trigger haptic: ${e.message}", e)
        }
    }
    
    // MARK: - Share Functionality
    @ReactMethod
    fun showShareSheet(text: String, url: String, promise: Promise) {
        try {
            val activity = currentActivity
            if (activity == null) {
                promise.reject("NO_ACTIVITY", "No current activity found", null)
                return
            }
            
            val shareIntent = Intent().apply {
                action = Intent.ACTION_SEND
                type = "text/plain"
                
                if (text.isNotEmpty() && url.isNotEmpty()) {
                    putExtra(Intent.EXTRA_TEXT, "$text\n\n$url")
                } else if (text.isNotEmpty()) {
                    putExtra(Intent.EXTRA_TEXT, text)
                } else if (url.isNotEmpty()) {
                    putExtra(Intent.EXTRA_TEXT, url)
                } else {
                    putExtra(Intent.EXTRA_TEXT, "Chili Market - De beste marktplaats app!")
                }
            }
            
            val chooser = Intent.createChooser(shareIntent, "Delen via...")
            activity.startActivity(chooser)
            
            promise.resolve(Arguments.createMap().apply {
                putBoolean("completed", true)
            })
            
        } catch (e: Exception) {
            promise.reject("SHARE_ERROR", "Failed to show share sheet: ${e.message}", e)
        }
    }
    
    // MARK: - App Settings
    @ReactMethod
    fun openAppSettings(promise: Promise) {
        try {
            val activity = currentActivity
            if (activity == null) {
                promise.reject("NO_ACTIVITY", "No current activity found", null)
                return
            }
            
            val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS).apply {
                data = Uri.fromParts("package", reactApplicationContext.packageName, null)
            }
            activity.startActivity(intent)
            
            promise.resolve(Arguments.createMap().apply {
                putBoolean("opened", true)
            })
            
        } catch (e: Exception) {
            promise.reject("SETTINGS_ERROR", "Failed to open settings: ${e.message}", e)
        }
    }
    
    // MARK: - In-App Browser
    @ReactMethod
    fun openInAppBrowser(url: String, promise: Promise) {
        try {
            val activity = currentActivity
            if (activity == null) {
                promise.reject("NO_ACTIVITY", "No current activity found", null)
                return
            }
            
            val dialog = AlertDialog.Builder(activity)
            val webView = WebView(activity)
            
            webView.settings.apply {
                javaScriptEnabled = true
                domStorageEnabled = true
                loadWithOverviewMode = true
                useWideViewPort = true
            }
            
            webView.webViewClient = object : WebViewClient() {
                override fun shouldOverrideUrlLoading(view: WebView, url: String): Boolean {
                    view.loadUrl(url)
                    return true
                }
            }
            
            webView.loadUrl(url)
            
            val layout = LinearLayout(activity).apply {
                orientation = LinearLayout.VERTICAL
                addView(webView, LinearLayout.LayoutParams(
                    LinearLayout.LayoutParams.MATCH_PARENT,
                    LinearLayout.LayoutParams.MATCH_PARENT
                ))
            }
            
            dialog.setView(layout)
                .setTitle("Browser")
                .setNegativeButton("Sluiten") { dialog, _ ->
                    dialog.dismiss()
                }
                .setOnDismissListener {
                    promise.resolve(Arguments.createMap().apply {
                        putBoolean("completed", true)
                    })
                }
                .show()
            
        } catch (e: Exception) {
            promise.reject("BROWSER_ERROR", "Failed to open browser: ${e.message}", e)
        }
    }
    
    // MARK: - File Picker
    @ReactMethod
    fun showFilePicker(promise: Promise) {
        try {
            val activity = currentActivity
            if (activity == null) {
                promise.reject("NO_ACTIVITY", "No current activity found", null)
                return
            }
            
            currentFilePickerPromise = promise
            
            val intent = Intent(Intent.ACTION_GET_CONTENT).apply {
                type = "*/*"
                addCategory(Intent.CATEGORY_OPENABLE)
            }
            
            if (intent.resolveActivity(activity.packageManager) != null) {
                activity.startActivityForResult(
                    Intent.createChooser(intent, "Selecteer een bestand"),
                    REQUEST_CODE_FILE_PICKER
                )
            } else {
                promise.reject("NO_FILE_PICKER", "No file picker app available", null)
            }
            
        } catch (e: Exception) {
            promise.reject("FILE_PICKER_ERROR", "Failed to show file picker: ${e.message}", e)
        }
    }
    
    // MARK: - Permission Management
    @ReactMethod
    fun checkCameraPermission(promise: Promise) {
        try {
            val context = reactApplicationContext
            val permission = Manifest.permission.CAMERA
            val status = ContextCompat.checkSelfPermission(context, permission)
            
            val result = Arguments.createMap().apply {
                putString("status", when (status) {
                    PackageManager.PERMISSION_GRANTED -> "granted"
                    PackageManager.PERMISSION_DENIED -> "denied"
                    else -> "notDetermined"
                })
                putBoolean("granted", status == PackageManager.PERMISSION_GRANTED)
            }
            
            promise.resolve(result)
        } catch (e: Exception) {
            promise.reject("PERMISSION_ERROR", "Failed to check camera permission: ${e.message}", e)
        }
    }
    
    @ReactMethod
    fun requestCameraPermission(promise: Promise) {
        try {
            val activity = currentActivity
            if (activity == null) {
                promise.reject("NO_ACTIVITY", "No current activity found", null)
                return
            }
            
            val permission = Manifest.permission.CAMERA
            ActivityCompat.requestPermissions(
                activity,
                arrayOf(permission),
                REQUEST_CODE_CAMERA_PERMISSION
            )
            
            // Note: Result will be handled in onRequestPermissionsResult
            promise.resolve(Arguments.createMap().apply {
                putBoolean("requested", true)
            })
            
        } catch (e: Exception) {
            promise.reject("PERMISSION_ERROR", "Failed to request camera permission: ${e.message}", e)
        }
    }
    
    @ReactMethod
    fun checkPhotoPickerAvailability(promise: Promise) {
        try {
            val result = Arguments.createMap().apply {
                // Android Photo Picker is available from Android 11 (API 30) and above
                putBoolean("isAvailable", Build.VERSION.SDK_INT >= Build.VERSION_CODES.R)
                putBoolean("requiresPermission", false) // Photo Picker doesn't require permissions
                putString("status", if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) "available" else "legacy")
            }
            
            promise.resolve(result)
        } catch (e: Exception) {
            promise.reject("AVAILABILITY_ERROR", "Failed to check photo picker availability: ${e.message}", e)
        }
    }
    
    @ReactMethod
    fun openPhotoPicker(maxSelection: Int, mediaType: String, promise: Promise) {
        try {
            val activity = currentActivity
            if (activity == null) {
                promise.reject("NO_ACTIVITY", "No current activity found", null)
                return
            }
            
            currentPhotoPickerPromise = promise
            
            // Use Android Photo Picker for Android 11+ (API 30+)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                val mimeType = when (mediaType.lowercase()) {
                    "images" -> "image/*"
                    "videos" -> "video/*"
                    "both", "all" -> "*/*"
                    else -> "image/*"
                }
                
                val intent = Intent(Intent.ACTION_PICK).apply {
                    type = mimeType
                    if (maxSelection > 1 && Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
                        putExtra(Intent.EXTRA_ALLOW_MULTIPLE, true)
                    }
                }
                
                if (intent.resolveActivity(activity.packageManager) != null) {
                    activity.startActivityForResult(intent, REQUEST_CODE_PHOTO_PICKER)
                } else {
                    promise.reject("NO_PHOTO_PICKER", "Photo picker not available", null)
                }
            } else {
                // Fallback for older Android versions using traditional file picker
                val intent = Intent(Intent.ACTION_GET_CONTENT).apply {
                    type = when (mediaType.lowercase()) {
                        "images" -> "image/*"
                        "videos" -> "video/*"
                        "both", "all" -> "*/*"
                        else -> "image/*"
                    }
                    addCategory(Intent.CATEGORY_OPENABLE)
                    if (maxSelection > 1) {
                        putExtra(Intent.EXTRA_ALLOW_MULTIPLE, true)
                    }
                }
                
                if (intent.resolveActivity(activity.packageManager) != null) {
                    activity.startActivityForResult(
                        Intent.createChooser(intent, "Selecteer bestanden"),
                        REQUEST_CODE_PHOTO_PICKER
                    )
                } else {
                    promise.reject("NO_FILE_PICKER", "File picker not available", null)
                }
            }
            
        } catch (e: Exception) {
            promise.reject("PHOTO_PICKER_ERROR", "Failed to open photo picker: ${e.message}", e)
        }
    }
    
    // MARK: - Mail Composer
    @ReactMethod
    fun showMailComposer(subject: String, body: String, recipients: ReadableArray, promise: Promise) {
        try {
            val activity = currentActivity
            if (activity == null) {
                promise.reject("NO_ACTIVITY", "No current activity found", null)
                return
            }
            
            val recipientsList = mutableListOf<String>()
            for (i in 0 until recipients.size()) {
                recipients.getString(i)?.let { recipientsList.add(it) }
            }
            
            val intent = Intent(Intent.ACTION_SENDTO).apply {
                data = Uri.parse("mailto:")
                putExtra(Intent.EXTRA_EMAIL, recipientsList.toTypedArray())
                putExtra(Intent.EXTRA_SUBJECT, subject)
                putExtra(Intent.EXTRA_TEXT, body)
            }
            
            if (intent.resolveActivity(activity.packageManager) != null) {
                activity.startActivity(Intent.createChooser(intent, "E-mail verzenden"))
                promise.resolve(Arguments.createMap().apply {
                    putBoolean("completed", true)
                })
            } else {
                promise.reject("NO_EMAIL_APP", "No email app available", null)
            }
            
        } catch (e: Exception) {
            promise.reject("EMAIL_ERROR", "Failed to show mail composer: ${e.message}", e)
        }
    }
    
    // MARK: - In-App Review (Google Play)
    @ReactMethod
    fun requestInAppReview(promise: Promise) {
        try {
            val activity = currentActivity
            if (activity == null) {
                promise.reject("NO_ACTIVITY", "No current activity found", null)
                return
            }
            
            // For Google Play Store
            val intent = Intent(Intent.ACTION_VIEW).apply {
                data = Uri.parse("market://details?id=${reactApplicationContext.packageName}")
                addFlags(Intent.FLAG_ACTIVITY_NO_HISTORY or Intent.FLAG_ACTIVITY_NEW_DOCUMENT or Intent.FLAG_ACTIVITY_MULTIPLE_TASK)
            }
            
            try {
                activity.startActivity(intent)
            } catch (e: Exception) {
                // Fallback to web browser
                val webIntent = Intent(Intent.ACTION_VIEW).apply {
                    data = Uri.parse("https://play.google.com/store/apps/details?id=${reactApplicationContext.packageName}")
                }
                activity.startActivity(webIntent)
            }
            
            promise.resolve(Arguments.createMap().apply {
                putBoolean("completed", true)
            })
            
        } catch (e: Exception) {
            promise.reject("REVIEW_ERROR", "Failed to request review: ${e.message}", e)
        }
    }
    
    // MARK: - Secure Storage (Android Keystore)
    @ReactMethod
    fun storeBiometricItem(key: String, value: String, promise: Promise) {
        try {
            val encryptedPrefs = getEncryptedSharedPreferences()
            encryptedPrefs.edit().putString("biometric_$key", value).apply()
            promise.resolve(true)
        } catch (e: Exception) {
            promise.reject("KEYSTORE_ERROR", "Failed to store biometric item: ${e.message}", e)
        }
    }
    
    @ReactMethod
    fun getBiometricItem(key: String, promise: Promise) {
        try {
            val encryptedPrefs = getEncryptedSharedPreferences()
            val value = encryptedPrefs.getString("biometric_$key", null)
            promise.resolve(value)
        } catch (e: Exception) {
            promise.reject("KEYSTORE_ERROR", "Failed to get biometric item: ${e.message}", e)
        }
    }
    
    @ReactMethod
    fun removeBiometricItem(key: String, promise: Promise) {
        try {
            val encryptedPrefs = getEncryptedSharedPreferences()
            encryptedPrefs.edit().remove("biometric_$key").apply()
            promise.resolve(true)
        } catch (e: Exception) {
            promise.reject("KEYSTORE_ERROR", "Failed to remove biometric item: ${e.message}", e)
        }
    }
    
    @ReactMethod
    fun storeItem(key: String, value: String, promise: Promise) {
        try {
            val encryptedPrefs = getEncryptedSharedPreferences()
            encryptedPrefs.edit().putString(key, value).apply()
            promise.resolve(true)
        } catch (e: Exception) {
            promise.reject("KEYSTORE_ERROR", "Failed to store item: ${e.message}", e)
        }
    }
    
    @ReactMethod
    fun getItem(key: String, promise: Promise) {
        try {
            val encryptedPrefs = getEncryptedSharedPreferences()
            val value = encryptedPrefs.getString(key, null)
            promise.resolve(value)
        } catch (e: Exception) {
            promise.reject("KEYSTORE_ERROR", "Failed to get item: ${e.message}", e)
        }
    }
    
    @ReactMethod
    fun removeItem(key: String, promise: Promise) {
        try {
            val encryptedPrefs = getEncryptedSharedPreferences()
            encryptedPrefs.edit().remove(key).apply()
            promise.resolve(true)
        } catch (e: Exception) {
            promise.reject("KEYSTORE_ERROR", "Failed to remove item: ${e.message}", e)
        }
    }
    
    @ReactMethod
    fun clearAll(promise: Promise) {
        try {
            val encryptedPrefs = getEncryptedSharedPreferences()
            encryptedPrefs.edit().clear().apply()
            promise.resolve(true)
        } catch (e: Exception) {
            promise.reject("KEYSTORE_ERROR", "Failed to clear all items: ${e.message}", e)
        }
    }
    
    // Helper method for encrypted shared preferences
    private fun getEncryptedSharedPreferences(): SharedPreferences {
        val masterKey = MasterKey.Builder(reactApplicationContext)
            .setKeyScheme(MasterKey.KeyScheme.AES256_GCM)
            .build()
        
        return EncryptedSharedPreferences.create(
            reactApplicationContext,
            SHARED_PREFS_NAME,
            masterKey,
            EncryptedSharedPreferences.PrefKeyEncryptionScheme.AES256_SIV,
            EncryptedSharedPreferences.PrefValueEncryptionScheme.AES256_GCM
        )
    }
    
    // Handle activity results from MainActivity
    private fun handleActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        when (requestCode) {
            REQUEST_CODE_PHOTO_PICKER -> {
                handlePhotoPickerResult(resultCode, data)
            }
            REQUEST_CODE_FILE_PICKER -> {
                handleFilePickerResult(resultCode, data)
            }
        }
    }
    
    private fun handlePhotoPickerResult(resultCode: Int, data: Intent?) {
        val promise = currentPhotoPickerPromise
        currentPhotoPickerPromise = null
        
        if (promise == null) {
            return
        }
        
        if (resultCode == Activity.RESULT_OK && data != null) {
            try {
                val result = Arguments.createMap()
                val selectedFiles = Arguments.createArray()
                
                if (data.clipData != null) {
                    // Multiple selection
                    val clipData = data.clipData!!
                    for (i in 0 until clipData.itemCount) {
                        val uri = clipData.getItemAt(i).uri
                        val fileInfo = getFileInfoFromUri(uri)
                        selectedFiles.pushMap(fileInfo)
                    }
                } else if (data.data != null) {
                    // Single selection
                    val uri = data.data!!
                    val fileInfo = getFileInfoFromUri(uri)
                    selectedFiles.pushMap(fileInfo)
                }
                
                result.putArray("files", selectedFiles)
                result.putBoolean("cancelled", false)
                promise.resolve(result)
                
            } catch (e: Exception) {
                promise.reject("PHOTO_PICKER_ERROR", "Failed to process selected files: ${e.message}", e)
            }
        } else {
            // User cancelled or error occurred
            val result = Arguments.createMap().apply {
                putBoolean("cancelled", true)
                putArray("files", Arguments.createArray())
            }
            promise.resolve(result)
        }
    }
    
    private fun handleFilePickerResult(resultCode: Int, data: Intent?) {
        val promise = currentFilePickerPromise
        currentFilePickerPromise = null
        
        if (promise == null) {
            return
        }
        
        if (resultCode == Activity.RESULT_OK && data != null) {
            try {
                val uri = data.data
                if (uri != null) {
                    val fileInfo = getFileInfoFromUri(uri)
                    promise.resolve(fileInfo)
                } else {
                    promise.reject("NO_FILE_SELECTED", "No file was selected", null)
                }
            } catch (e: Exception) {
                promise.reject("FILE_PICKER_ERROR", "Failed to process selected file: ${e.message}", e)
            }
        } else {
            promise.reject("FILE_PICKER_CANCELLED", "File picker was cancelled", null)
        }
    }
    
    private fun getFileInfoFromUri(uri: Uri): WritableMap {
        val context = reactApplicationContext
        val fileInfo = Arguments.createMap()
        
        fileInfo.putString("uri", uri.toString())
        
        try {
            val cursor = context.contentResolver.query(uri, null, null, null, null)
            cursor?.use {
                if (it.moveToFirst()) {
                    val nameIndex = it.getColumnIndex(android.provider.OpenableColumns.DISPLAY_NAME)
                    val sizeIndex = it.getColumnIndex(android.provider.OpenableColumns.SIZE)
                    
                    if (nameIndex != -1) {
                        val name = it.getString(nameIndex)
                        fileInfo.putString("name", name ?: "unknown")
                        
                        // Extract file extension
                        val extension = name?.substringAfterLast('.', "") ?: ""
                        fileInfo.putString("type", extension)
                    }
                    
                    if (sizeIndex != -1) {
                        val size = it.getLong(sizeIndex)
                        fileInfo.putDouble("size", size.toDouble())
                    }
                }
            }
            
            // Get MIME type
            val mimeType = context.contentResolver.getType(uri)
            fileInfo.putString("mimeType", mimeType ?: "unknown")
            
        } catch (e: Exception) {
            // Fallback values
            fileInfo.putString("name", "unknown")
            fileInfo.putString("type", "unknown")
            fileInfo.putDouble("size", 0.0)
            fileInfo.putString("mimeType", "unknown")
        }
        
        return fileInfo
    }
}
