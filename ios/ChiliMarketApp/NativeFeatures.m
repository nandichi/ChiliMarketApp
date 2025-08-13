//
//  NativeFeatures.m
//  ChiliMarketApp
//
//  React Native bridge for native iOS features
//

#import "NativeFeatures.h"
#import "ChiliMarketApp-Swift.h"

@implementation NativeFeatures

RCT_EXPORT_MODULE();

// Share Sheet
RCT_EXPORT_METHOD(showShareSheet:(NSString *)text url:(NSString *)url resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [NativeFeaturesSwift showShareSheetWithText:text url:url resolver:resolve rejecter:reject];
}

// File Picker
RCT_EXPORT_METHOD(showFilePicker:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [NativeFeaturesSwift showFilePickerWithResolver:resolve rejecter:reject];
}

// Camera/Photos Permission Check
RCT_EXPORT_METHOD(checkCameraPermission:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [NativeFeaturesSwift checkCameraPermissionWithResolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(checkPhotosPermission:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [NativeFeaturesSwift checkPhotosPermissionWithResolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(requestCameraPermission:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [NativeFeaturesSwift requestCameraPermissionWithResolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(requestPhotosPermission:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [NativeFeaturesSwift requestPhotosPermissionWithResolver:resolve rejecter:reject];
}

// Haptics
RCT_EXPORT_METHOD(triggerImpactHaptic:(NSString *)style resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [NativeFeaturesSwift triggerImpactHapticWithStyle:style resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(triggerNotificationHaptic:(NSString *)type resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [NativeFeaturesSwift triggerNotificationHapticWithType:type resolver:resolve rejecter:reject];
}

// In App Review
RCT_EXPORT_METHOD(requestInAppReview:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [NativeFeaturesSwift requestInAppReviewWithResolver:resolve rejecter:reject];
}

// Mail Composer
RCT_EXPORT_METHOD(showMailComposer:(NSString *)subject body:(NSString *)body toRecipients:(NSArray *)toRecipients resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [NativeFeaturesSwift showMailComposerWithSubject:subject body:body toRecipients:toRecipients resolver:resolve rejecter:reject];
}

// Open Settings
RCT_EXPORT_METHOD(openAppSettings:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [NativeFeaturesSwift openAppSettingsWithResolver:resolve rejecter:reject];
}

// In App Browser
RCT_EXPORT_METHOD(openInAppBrowser:(NSString *)url resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [NativeFeaturesSwift openInAppBrowserWithUrl:url resolver:resolve rejecter:reject];
}

// Biometric Authentication
RCT_EXPORT_METHOD(checkBiometricSupport:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [NativeFeaturesSwift checkBiometricSupportWithResolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(authenticateWithBiometric:(NSString *)reason resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [NativeFeaturesSwift authenticateWithBiometricWithReason:reason resolver:resolve rejecter:reject];
}

// System Info
RCT_EXPORT_METHOD(getSystemInfo:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [NativeFeaturesSwift getSystemInfoWithResolver:resolve rejecter:reject];
}

// Keychain Storage
RCT_EXPORT_METHOD(storeBiometricItem:(NSString *)key
                  value:(NSString *)value
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    [NativeFeaturesSwift storeBiometricItemWithKey:key value:value resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(getBiometricItem:(NSString *)key
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    [NativeFeaturesSwift getBiometricItemWithKey:key resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(removeBiometricItem:(NSString *)key
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    [NativeFeaturesSwift removeBiometricItemWithKey:key resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(storeItem:(NSString *)key
                  value:(NSString *)value
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    [NativeFeaturesSwift storeItemWithKey:key value:value resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(getItem:(NSString *)key
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    [NativeFeaturesSwift getItemWithKey:key resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(removeItem:(NSString *)key
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    [NativeFeaturesSwift removeItemWithKey:key resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(clearAll:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    [NativeFeaturesSwift clearAllWithResolver:resolve rejecter:reject];
}

@end

// MARK: - Keychain Module
@interface KeychainModule : NSObject <RCTBridgeModule>
@end

@implementation KeychainModule

RCT_EXPORT_MODULE();

// Biometric Items
RCT_EXPORT_METHOD(storeBiometricItem:(NSString *)key
                  value:(NSString *)value
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    [NativeFeaturesSwift storeBiometricItemWithKey:key value:value resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(getBiometricItem:(NSString *)key
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    [NativeFeaturesSwift getBiometricItemWithKey:key resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(removeBiometricItem:(NSString *)key
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    [NativeFeaturesSwift removeBiometricItemWithKey:key resolver:resolve rejecter:reject];
}

// Regular Items
RCT_EXPORT_METHOD(storeItem:(NSString *)key
                  value:(NSString *)value
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    [NativeFeaturesSwift storeItemWithKey:key value:value resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(getItem:(NSString *)key
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    [NativeFeaturesSwift getItemWithKey:key resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(removeItem:(NSString *)key
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    [NativeFeaturesSwift removeItemWithKey:key resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(clearAll:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    [NativeFeaturesSwift clearAllWithResolver:resolve rejecter:reject];
}

@end
