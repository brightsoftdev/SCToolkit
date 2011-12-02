//
//  NSWorkspace+SCAdditions.h
//  SCToolkit
//
//  Created by Vincent Wang on 11/29/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import <AppKit/AppKit.h>

// inspired by GDKit

/**
 * Macro definition of a string you can pass to openSystemPreference,
 * for universal access.
 */
#define kSCSystemPrefencesAccounts @"Accounts.prefPane"
#define kSCSystemPrefencesAppearance @"Appearance.prefPane"
#define kSCSystemPrefencesBluetooth @"Bluetooth.prefPane"
#define kSCSystemPrefencesDateAndTime @"DateAndTime.prefPane"
#define kSCSystemPrefencesDesktopScreenEffectsPref @"DesktopScreenEffectsPref.prefPane"
#define kSCSystemPrefencesDigiHubDiscs @"DigiHubDiscs.prefPane"
#define kSCSystemPrefencesDisplays @"Displays.prefPane"
#define kSCSystemPrefencesDock @"Dock.prefPane"
#define kSCSystemPrefencesEnergySaver @"EnergySaver.prefPane"
#define kSCSystemPrefencesExpose @"Expose.prefPane"
#define kSCSystemPrefencesFibreChannel @"FibreChannel.prefPane"
#define kSCSystemPrefencesInk @"Ink.prefPane"
#define kSCSystemPrefencesKeyboard @"Keyboard.prefPane"
#define kSCSystemPrefencesLocalization @"Localization.prefPane"
#define kSCSystemPrefencesMobileMe @"MobileMe.prefPane"
#define kSCSystemPrefencesMouse @"Mouse.prefPane"
#define kSCSystemPrefencesNetwork @"Network.prefPane"
#define kSCSystemPrefencesParentalControls @"ParentalControls.prefPane"
#define kSCSystemPrefencesPrintAndFax @"PrintAndFax.prefPane"
#define kSCSystemPrefencesSecurity @"Security.prefPane"
#define kSCSystemPrefencesSharingPref @"SharingPref.prefPane"
#define kSCSystemPrefencesSoftwareUpdate @"SoftwareUpdate.prefPane"
#define kSCSystemPrefencesSound @"Sound.prefPane"
#define kSCSystemPrefencesSpeech @"Speech.prefPane"
#define kSCSystemPrefencesSpotlight @"Spotlight.prefPane"
#define kSCSystemPrefencesStartupDisk @"StartupDisk.prefPane"
#define kSCSystemPrefencesTimeMachine @"TimeMachine.prefPane"
#define kSCSystemPrefencesTrackpad @"Trackpad.prefPane"
#define kSCSystemPrefencesUniversalAccess @"UniversalAccessPref.prefPane"

@interface NSWorkspace (SCAdditions)

+ (NSWorkspace *)sc_threadSafeWorkspace;
- (NSImage *)sc_iconForAppWithBundleIdentifier:(NSString *)bundleID;
- (NSImage *)sc_iconForFile:(NSString *)path size:(NSSize)size;

/**
 * Opens the system preferences panel and opens the specified
 * preference. Pass in an argument like "UniversalAccessPref"
 * this function will append the ".prefpane", and also search
 * in two places for the prefpane: /System/Library/PreferencePanes/,
 * and ~/Library/PreferencePanes/
 */
- (void)sc_openSystemPreference:(NSString *)preferencesFileName;

/**
 * Brings an application to the front. Requires an application
 * info dictionary, which must contain the key "NSApplicationPath"
 */
- (void)sc_bringApplicationToFront:(NSDictionary *)appInfo;

/**
 * Brings the current application to front - uses NSBundle internally.
 */
- (void)sc_bringCurrentApplicationToFront;

/**
 * Brings an application to the front, from an application
 * path.
 */
- (void)sc_bringApplicationToFrontFromPath:(NSString *)appPath;

/**
 * Installs a launch agent/startup item into ~/Library/LaunchAgents, you
 * need to pass it a "plist" file. ex: "MyAppStartup.Agent.plist"
 */
- (void)sc_installStartupLaunchdItem:(NSString *)plistName;

/**
 * Removes a launchd agent/startup item from ~/Library/LaunchAgents, you
 * need to pass it a "plist" file. ex: "MyAppStartup.Agent.plist"
 */
- (void)sc_uninstallStartupLaunchdItem:(NSString *)plistName;
@end
