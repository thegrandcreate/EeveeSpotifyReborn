import Orion
import UIKit

// MARK: - SPTDataSaverController  [confirmed in binary]
//
// Primary controller that drives all Data Saver logic.
// Correct method names verified against class-dump output:
//   dataSaverIsActive / dataSaverIsConfigured / userDidSetDataSaverActive: / updateDataSaverState
// (The guessed names isDataSaverEnabled / isEnabled do NOT exist on this class.)

class DataSaverControllerHook: ClassHook<NSObject> {
    typealias Group = BasePremiumPatchingGroup
    static let targetName = "SPTDataSaverController"

    func dataSaverIsActive() -> Bool { return false }
    func dataSaverIsConfigured() -> Bool { return false }
    func updateDataSaverState() -> Bool { return false }

    func userDidSetDataSaverActive(_ active: Bool) { /* no-op */ }
    func userDidClearDataSaverSetting() { /* no-op */ }

    func automaticDataSaverEnabled() -> Bool { return false }
    func setAutomaticDataSaverEnabled(_ value: Bool) { /* no-op */ }

    func lowDataModeActive() -> Bool { return false }
    func setLowDataModeActive(_ value: Bool) { /* no-op */ }
}

// MARK: - SPTDataSaverStateControllerImplementation  [confirmed in binary]
//
// State-level controller; consumers read isDataSaverActive / isDataSaverConfigured.

class DataSaverStateControllerHook: ClassHook<NSObject> {
    typealias Group = BasePremiumPatchingGroup
    static let targetName = "SPTDataSaverStateControllerImplementation"

    func isDataSaverActive() -> Bool { return false }
    func isDataSaverConfigured() -> Bool { return false }
    func setDataSaverActive(_ active: Bool) { /* no-op */ }
    func clearDataSaverSetting() { /* no-op */ }
}

// MARK: - AutomaticDataSaverControllerImpl  [confirmed in binary]
//
// Automatic (low-data-mode-based) Data Saver controller.
// shouldEnableDataSaver drives automatic activation.

class AutomaticDataSaverControllerHook: ClassHook<NSObject> {
    typealias Group = BasePremiumPatchingGroup
    static let targetName = "_TtC23DataSaver_AutomaticImpl32AutomaticDataSaverControllerImpl"

    func shouldEnableDataSaver() -> Bool { return false }
    func setShouldEnableDataSaver(_ value: Bool) { /* no-op */ }
    func manualDataSaverConfigured() -> Bool { return false }
    func setManualDataSaverConfigured(_ value: Bool) { /* no-op */ }
}

// MARK: - BetamaxSettingsImplementation  [confirmed in binary]
//
// Video player (Betamax) reads its own isDataSaverEnabled flag separately.

class BetamaxDataSaverHook: ClassHook<NSObject> {
    typealias Group = BasePremiumPatchingGroup
    static let targetName = "_TtC20Betamax_SettingsImpl29BetamaxSettingsImplementation"

    func isDataSaverEnabled() -> Bool { return false }
    func setIsDataSaverEnabled(_ value: Bool) { /* no-op */ }
}

// MARK: - Settings UI: SPTDataSaverSettingsSection  [confirmed in binary]
//
// numberOfRows → 0 removes the Data Saver master toggle from Settings entirely.
// SPTDataSaverSettingsSection is a plain Objective-C class present on all iOS versions
// targeted by this tweak, so BasePremiumPatchingGroup is sufficient.

class DataSaverSettingsSectionHook: ClassHook<NSObject> {
    typealias Group = BasePremiumPatchingGroup
    static let targetName = "SPTDataSaverSettingsSection"

    func numberOfRows() -> NSInteger { return 0 }
}

// MARK: - Settings UI: audio-only sub-sections  [all three confirmed in binary]
//
// These appear under Data Saver → "Audio only" options for podcasts,
// downloads, and streaming.  Returning 0 rows collapses all three.

class DataSaverAudioOnlyPodcastsHook: ClassHook<NSObject> {
    typealias Group = BasePremiumPatchingGroup
    static let targetName = "SPTDataSaverAudioOnlyPodcastsSettingsSection"

    func numberOfRows() -> NSInteger { return 0 }
}

class DataSaverDownloadAudioOnlyHook: ClassHook<NSObject> {
    typealias Group = BasePremiumPatchingGroup
    static let targetName = "SPTDataSaverDownloadAudioOnlySettingsSection"

    func numberOfRows() -> NSInteger { return 0 }
}

class DataSaverStreamAudioOnlyHook: ClassHook<NSObject> {
    typealias Group = BasePremiumPatchingGroup
    static let targetName = "SPTDataSaverStreamAudioOnlySettingsSection"

    func numberOfRows() -> NSInteger { return 0 }
}
