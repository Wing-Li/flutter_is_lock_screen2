import Flutter
import UIKit

public class SwiftIsLockScreenPlugin: NSObject, FlutterPlugin {
    private var protectedDataUnavailable: Bool

    override public init() {
        protectedDataUnavailable = !UIApplication.shared.isProtectedDataAvailable
        super.init()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(protectedDataWillBecomeUnavailable),
            name: UIApplication.protectedDataWillBecomeUnavailableNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(protectedDataDidBecomeAvailable),
            name: UIApplication.protectedDataDidBecomeAvailableNotification,
            object: nil
        )
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "is_lock_screen", binaryMessenger: registrar.messenger())
        let instance = SwiftIsLockScreenPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch (call.method) {
        case "isLockScreen":
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                result(self.isLikelyLockScreen())
            }
        default:
            return result(FlutterMethodNotImplemented)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func protectedDataWillBecomeUnavailable() {
        protectedDataUnavailable = true
    }

    @objc private func protectedDataDidBecomeAvailable() {
        protectedDataUnavailable = false
    }

    private func isLikelyLockScreen() -> Bool {
        let application = UIApplication.shared
        let brightnessIndicatesScreenOff = application.applicationState != .active && UIScreen.main.brightness <= 0.01

        return protectedDataUnavailable || !application.isProtectedDataAvailable || brightnessIndicatesScreenOff
    }
}
