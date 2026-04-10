import Orion
import UIKit

// Spotify streaming quality enum values stored in audioPlayBitrate /
// audioPlayBitrateNonMetered (long long, synthesized by SPTPreferencesImplementation):
//   0 = Low   1 = Normal   2 = High   3 = Very High
private let kHighQuality: Int = 2

// MARK: - SPTPreferencesImplementation  [confirmed in binary]
//
// Full mangled name: _TtC31Preferences_CorePreferencesImpl28SPTPreferencesImplementation
//
// This is the concrete implementation of the SPTPreferences protocol.  It owns
// two synthesized properties that the audio engine reads at playback time:
//
//   audioPlayBitrate          — quality on metered (cellular) connections
//   audioPlayBitrateNonMetered — quality on unmetered (WiFi) connections
//
// Hooking both getters to return kHighQuality (2) and making both setters
// no-ops means the audio engine always plays at High quality regardless of
// what is stored in NSUserDefaults or what the settings UI attempts to write.
//
// Verified against class-dump output (line ~182320 in spotify_class_dump.txt):
//   @property(nonatomic) long long audioPlayBitrate;
//   @property(nonatomic) long long audioPlayBitrateNonMetered;

class SPTPreferencesQualityHook: ClassHook<NSObject> {
    typealias Group = BasePremiumPatchingGroup
    static let targetName = "_TtC31Preferences_CorePreferencesImpl28SPTPreferencesImplementation"

    // ── Streaming quality (metered / cellular) ──────────────────────────────

    func audioPlayBitrate() -> Int {
        return kHighQuality
    }

    func setAudioPlayBitrate(_ value: Int) {
        // Silently discard; quality cannot be lowered below High.
    }

    // ── Streaming quality (unmetered / WiFi) ────────────────────────────────

    func audioPlayBitrateNonMetered() -> Int {
        return kHighQuality
    }

    func setAudioPlayBitrateNonMetered(_ value: Int) {
        // Silently discard.
    }
}
