import UIKit
import AVKit

enum PermissionType {
    case camera

    var description: String {
        switch self {
        case .camera:
            return "Camera"
        }
    }

}

enum PermissionStatus: Int, CustomStringConvertible {
    case authorized, unauthorized, unknown, disabled

    var description: String {
        switch self {
        case .authorized:   return "Authorized"
        case .unauthorized: return "Unauthorized"
        case .unknown:      return "Unknown"
        case .disabled:     return "Disabled"
        }
    }
}

final class CameraPermission: NSObject {

    private weak var viewControllerForAlerts : UIViewController?

    init(viewController: UIViewController?) {
        self.viewControllerForAlerts = viewController
    }

    convenience override init() {
        self.init(viewController: UIApplication.topViewController())
    }




    // MARK: - Request Camera
    func statusCamera() -> PermissionStatus {
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)

        switch status {
        case .authorized:
            return .authorized
        case .restricted, .denied:
            return .unauthorized
        case .notDetermined:
            return .unknown
        @unknown default:
            return .disabled
        }

    }

    func requestCamera(_ permissionGranted: @escaping (Bool) -> Void) {
        let status = statusCamera()
        switch status {
        case .unknown:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { response in
                permissionGranted(response)
            })
        case .unauthorized:
            self.showDeniedAlert(.camera)
        case .disabled:
            self.showDisabledAlert(.camera)
        default:
            permissionGranted(true)
        }

    }




    private func showDeniedAlert(_ permission: PermissionType) {
        let alert = UIAlertController(title: "Permission for \(permission.description) was denied.",
                                      message: "Please enable access to \(permission.description) in the Settings app",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .cancel,
                                      handler: nil))
        alert.addAction(UIAlertAction(title: "Show me",
                                      style: .default,
                                      handler: { action in
            let settingsUrl = URL(string: UIApplication.openSettingsURLString)
            UIApplication.shared.open(settingsUrl!, options: [:], completionHandler: nil)
        }))

        DispatchQueue.main.async {
            self.viewControllerForAlerts?.present(alert,
                                                  animated: true, completion: nil)
        }
    }

    private func showDisabledAlert(_ permission: PermissionType) {
        let alert = UIAlertController(title: "\(permission.description) is currently disabled.",
                                      message: "Please enable access to \(permission.description) in Settings",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .cancel,
                                      handler: nil))
        alert.addAction(UIAlertAction(title: "Show me",
                                      style: .default,
                                      handler: { action in
            let settingsUrl = URL(string: UIApplication.openSettingsURLString)
            UIApplication.shared.open(settingsUrl!, options: [:], completionHandler: nil)
        }))

        DispatchQueue.main.async {
            self.viewControllerForAlerts?.present(alert,
                                                  animated: true, completion: nil)
        }
    }

}
