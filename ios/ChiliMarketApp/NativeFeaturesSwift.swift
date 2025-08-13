//
//  NativeFeaturesSwift.swift
//  ChiliMarketApp
//
//  Swift implementation of native iOS features for App Store compliance
//

import Foundation
import UIKit
import AVFoundation
import Photos
import StoreKit
import MessageUI
import SafariServices
import LocalAuthentication
import Security
import UniformTypeIdentifiers

@objc class NativeFeaturesSwift: NSObject {
    
    // MARK: - Share Sheet
    @objc static func showShareSheet(text: String, url: String, resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        DispatchQueue.main.async {
            guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
                rejecter("NO_ROOT_VC", "No root view controller found", nil)
                return
            }
            
            var items: [Any] = []
            if !text.isEmpty {
                items.append(text)
            }
            if !url.isEmpty, let shareURL = URL(string: url) {
                items.append(shareURL)
            }
            
            if items.isEmpty {
                items.append("Chili Market - De beste marktplaats app!")
            }
            
            let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
            
            // For iPad support
            if let popover = activityViewController.popoverPresentationController {
                popover.sourceView = rootViewController.view
                popover.sourceRect = CGRect(x: rootViewController.view.bounds.midX, y: rootViewController.view.bounds.midY, width: 0, height: 0)
                popover.permittedArrowDirections = []
            }
            
            activityViewController.completionWithItemsHandler = { _, completed, _, error in
                if let error = error {
                    rejecter("SHARE_ERROR", error.localizedDescription, error)
                } else {
                    resolver(["completed": completed])
                }
            }
            
            rootViewController.present(activityViewController, animated: true)
        }
    }
    
    // MARK: - File Picker
    @objc static func showFilePicker(resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        DispatchQueue.main.async {
            guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
                rejecter("NO_ROOT_VC", "No root view controller found", nil)
                return
            }
            
            let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.item], asCopy: true)
            documentPicker.delegate = DocumentPickerDelegate(resolver: resolver, rejecter: rejecter)
            documentPicker.allowsMultipleSelection = false
            
            rootViewController.present(documentPicker, animated: true)
        }
    }
    
    // MARK: - Camera Permission
    @objc static func checkCameraPermission(resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        let statusString: String
        
        switch status {
        case .authorized:
            statusString = "authorized"
        case .denied:
            statusString = "denied"
        case .restricted:
            statusString = "restricted"
        case .notDetermined:
            statusString = "notDetermined"
        @unknown default:
            statusString = "unknown"
        }
        
        resolver(["status": statusString])
    }
    
    @objc static func requestCameraPermission(resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            resolver(["granted": granted])
        }
    }
    
    // MARK: - Photos Permission
    @objc static func checkPhotosPermission(resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        let status = PHPhotoLibrary.authorizationStatus()
        let statusString: String
        
        switch status {
        case .authorized:
            statusString = "authorized"
        case .denied:
            statusString = "denied"
        case .restricted:
            statusString = "restricted"
        case .notDetermined:
            statusString = "notDetermined"
        case .limited:
            statusString = "limited"
        @unknown default:
            statusString = "unknown"
        }
        
        resolver(["status": statusString])
    }
    
    @objc static func requestPhotosPermission(resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        PHPhotoLibrary.requestAuthorization { status in
            let granted = status == .authorized || status == .limited
            resolver(["granted": granted, "status": status.rawValue])
        }
    }
    
    // MARK: - Haptics
    @objc static func triggerImpactHaptic(style: String, resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        DispatchQueue.main.async {
            let feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle
            
            switch style.lowercased() {
            case "light":
                feedbackStyle = .light
            case "medium":
                feedbackStyle = .medium
            case "heavy":
                feedbackStyle = .heavy
            default:
                feedbackStyle = .medium
            }
            
            let impactFeedback = UIImpactFeedbackGenerator(style: feedbackStyle)
            impactFeedback.impactOccurred()
            resolver(["success": true])
        }
    }
    
    @objc static func triggerNotificationHaptic(type: String, resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        DispatchQueue.main.async {
            let feedbackType: UINotificationFeedbackGenerator.FeedbackType
            
            switch type.lowercased() {
            case "success":
                feedbackType = .success
            case "warning":
                feedbackType = .warning
            case "error":
                feedbackType = .error
            default:
                feedbackType = .success
            }
            
            let notificationFeedback = UINotificationFeedbackGenerator()
            notificationFeedback.notificationOccurred(feedbackType)
            resolver(["success": true])
        }
    }
    
    // MARK: - In App Review
    @objc static func requestInAppReview(resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                SKStoreReviewController.requestReview(in: windowScene)
                resolver(["requested": true])
            } else {
                rejecter("NO_SCENE", "No window scene available", nil)
            }
        }
    }
    
    // MARK: - Mail Composer
    @objc static func showMailComposer(subject: String, body: String, toRecipients: [String], resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        DispatchQueue.main.async {
            guard MFMailComposeViewController.canSendMail() else {
                rejecter("MAIL_NOT_AVAILABLE", "Mail composer is not available", nil)
                return
            }
            
            guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
                rejecter("NO_ROOT_VC", "No root view controller found", nil)
                return
            }
            
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = MailComposeDelegate(resolver: resolver, rejecter: rejecter)
            mailComposer.setSubject(subject)
            mailComposer.setMessageBody(body, isHTML: false)
            mailComposer.setToRecipients(toRecipients)
            
            rootViewController.present(mailComposer, animated: true)
        }
    }
    
    // MARK: - Open Settings
    @objc static func openAppSettings(resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        DispatchQueue.main.async {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                rejecter("INVALID_URL", "Settings URL is invalid", nil)
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl) { success in
                    resolver(["opened": success])
                }
            } else {
                rejecter("CANNOT_OPEN", "Cannot open settings", nil)
            }
        }
    }
    
    // MARK: - In App Browser
    @objc static func openInAppBrowser(url: String, resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        DispatchQueue.main.async {
            guard let browserURL = URL(string: url) else {
                rejecter("INVALID_URL", "Invalid URL provided", nil)
                return
            }
            
            guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
                rejecter("NO_ROOT_VC", "No root view controller found", nil)
                return
            }
            
            let safariViewController = SFSafariViewController(url: browserURL)
            safariViewController.delegate = SafariDelegate(resolver: resolver, rejecter: rejecter)
            
            rootViewController.present(safariViewController, animated: true)
        }
    }
    
    // MARK: - Biometric Authentication
    @objc static func checkBiometricSupport(resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        let context = LAContext()
        var error: NSError?
        
        let canEvaluate = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        
        var biometricType = "none"
        if canEvaluate {
            switch context.biometryType {
            case .faceID:
                biometricType = "faceID"
            case .touchID:
                biometricType = "touchID"
            case .none:
                biometricType = "none"
            @unknown default:
                biometricType = "unknown"
            }
        }
        
        resolver([
            "isSupported": canEvaluate,
            "biometricType": biometricType,
            "error": error?.localizedDescription ?? ""
        ])
    }
    
    @objc static func authenticateWithBiometric(reason: String, resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        let context = LAContext()
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
            DispatchQueue.main.async {
                if success {
                    resolver(["success": true])
                } else {
                    let errorCode = (error as? LAError)?.code.rawValue ?? -1
                    resolver([
                        "success": false,
                        "error": error?.localizedDescription ?? "Authentication failed",
                        "errorCode": errorCode
                    ])
                }
            }
        }
    }
    
    // MARK: - System Info
    @objc static func getSystemInfo(resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        let device = UIDevice.current
        let bundle = Bundle.main
        
        let appVersion = bundle.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        let buildNumber = bundle.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
        let bundleIdentifier = bundle.bundleIdentifier ?? "Unknown"
        let appName = bundle.infoDictionary?["CFBundleDisplayName"] as? String ?? 
                     bundle.infoDictionary?["CFBundleName"] as? String ?? "Unknown"
        
        let systemInfo = [
            "appName": appName,
            "appVersion": appVersion,
            "buildNumber": buildNumber,
            "bundleIdentifier": bundleIdentifier,
            "deviceModel": device.model,
            "deviceName": device.name,
            "systemName": device.systemName,
            "systemVersion": device.systemVersion,
            "identifierForVendor": device.identifierForVendor?.uuidString ?? "Unknown"
        ]
        
        resolver(systemInfo)
    }
}

// MARK: - Delegate Classes

class DocumentPickerDelegate: NSObject, UIDocumentPickerDelegate {
    private let resolver: RCTPromiseResolveBlock
    private let rejecter: RCTPromiseRejectBlock
    
    init(resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        self.resolver = resolver
        self.rejecter = rejecter
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else {
            rejecter("NO_FILE", "No file selected", nil)
            return
        }
        
        let fileName = url.lastPathComponent
        let fileSize = try? url.resourceValues(forKeys: [.fileSizeKey]).fileSize ?? 0
        
        resolver([
            "fileName": fileName,
            "fileSize": fileSize ?? 0,
            "filePath": url.path
        ])
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        resolver(["cancelled": true])
    }
}

class MailComposeDelegate: NSObject, MFMailComposeViewControllerDelegate {
    private let resolver: RCTPromiseResolveBlock
    private let rejecter: RCTPromiseRejectBlock
    
    init(resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        self.resolver = resolver
        self.rejecter = rejecter
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
        
        if let error = error {
            rejecter("MAIL_ERROR", error.localizedDescription, error)
            return
        }
        
        let resultString: String
        switch result {
        case .sent:
            resultString = "sent"
        case .saved:
            resultString = "saved"
        case .cancelled:
            resultString = "cancelled"
        case .failed:
            resultString = "failed"
        @unknown default:
            resultString = "unknown"
        }
        
        resolver(["result": resultString])
    }
}

class SafariDelegate: NSObject, SFSafariViewControllerDelegate {
    private let resolver: RCTPromiseResolveBlock
    private let rejecter: RCTPromiseRejectBlock
    
    init(resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        self.resolver = resolver
        self.rejecter = rejecter
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        resolver(["dismissed": true])
    }
}

// MARK: - Keychain Storage Extension
extension NativeFeaturesSwift {
    
    @objc static func storeBiometricItem(key: String, value: String, resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        let serviceIdentifier = Bundle.main.bundleIdentifier ?? "com.chilimarket.app"
        
        // Create access control with biometry requirement
        guard let accessControl = SecAccessControlCreateWithFlags(
            kCFAllocatorDefault,
            kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
            .biometryCurrentSet,
            nil
        ) else {
            rejecter("ACCESS_CONTROL_ERROR", "Failed to create access control", nil)
            return
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceIdentifier,
            kSecAttrAccount as String: key,
            kSecValueData as String: value.data(using: .utf8)!,
            kSecAttrAccessControl as String: accessControl
        ]
        
        // Delete existing item first
        SecItemDelete(query as CFDictionary)
        
        // Add new item
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecSuccess {
            resolver(true)
        } else {
            let errorMessage = SecCopyErrorMessageString(status, nil) as String? ?? "Unknown keychain error"
            rejecter("KEYCHAIN_ERROR", "Failed to store item: \(errorMessage)", nil)
        }
    }
    
    @objc static func getBiometricItem(key: String, resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        let serviceIdentifier = Bundle.main.bundleIdentifier ?? "com.chilimarket.app"
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceIdentifier,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess {
            if let data = result as? Data,
               let string = String(data: data, encoding: .utf8) {
                resolver(string)
            } else {
                resolver(nil)
            }
        } else if status == errSecItemNotFound {
            resolver(nil)
        } else {
            let errorMessage = SecCopyErrorMessageString(status, nil) as String? ?? "Unknown keychain error"
            rejecter("KEYCHAIN_ERROR", "Failed to retrieve item: \(errorMessage)", nil)
        }
    }
    
    @objc static func removeBiometricItem(key: String, resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        let serviceIdentifier = Bundle.main.bundleIdentifier ?? "com.chilimarket.app"
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceIdentifier,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status == errSecSuccess || status == errSecItemNotFound {
            resolver(true)
        } else {
            let errorMessage = SecCopyErrorMessageString(status, nil) as String? ?? "Unknown keychain error"
            rejecter("KEYCHAIN_ERROR", "Failed to remove item: \(errorMessage)", nil)
        }
    }
    
    @objc static func storeItem(key: String, value: String, resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        let serviceIdentifier = Bundle.main.bundleIdentifier ?? "com.chilimarket.app"
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceIdentifier,
            kSecAttrAccount as String: key,
            kSecValueData as String: value.data(using: .utf8)!,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        ]
        
        // Delete existing item first
        SecItemDelete(query as CFDictionary)
        
        // Add new item
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecSuccess {
            resolver(true)
        } else {
            let errorMessage = SecCopyErrorMessageString(status, nil) as String? ?? "Unknown keychain error"
            rejecter("KEYCHAIN_ERROR", "Failed to store item: \(errorMessage)", nil)
        }
    }
    
    @objc static func getItem(key: String, resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        let serviceIdentifier = Bundle.main.bundleIdentifier ?? "com.chilimarket.app"
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceIdentifier,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess {
            if let data = result as? Data,
               let string = String(data: data, encoding: .utf8) {
                resolver(string)
            } else {
                resolver(nil)
            }
        } else if status == errSecItemNotFound {
            resolver(nil)
        } else {
            let errorMessage = SecCopyErrorMessageString(status, nil) as String? ?? "Unknown keychain error"
            rejecter("KEYCHAIN_ERROR", "Failed to retrieve item: \(errorMessage)", nil)
        }
    }
    
    @objc static func removeItem(key: String, resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        let serviceIdentifier = Bundle.main.bundleIdentifier ?? "com.chilimarket.app"
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceIdentifier,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status == errSecSuccess || status == errSecItemNotFound {
            resolver(true)
        } else {
            let errorMessage = SecCopyErrorMessageString(status, nil) as String? ?? "Unknown keychain error"
            rejecter("KEYCHAIN_ERROR", "Failed to remove item: \(errorMessage)", nil)
        }
    }
    
    @objc static func clearAll(resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        let serviceIdentifier = Bundle.main.bundleIdentifier ?? "com.chilimarket.app"
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceIdentifier
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status == errSecSuccess || status == errSecItemNotFound {
            resolver(true)
        } else {
            let errorMessage = SecCopyErrorMessageString(status, nil) as String? ?? "Unknown keychain error"
            rejecter("KEYCHAIN_ERROR", "Failed to clear keychain: \(errorMessage)", nil)
        }
    }
}
