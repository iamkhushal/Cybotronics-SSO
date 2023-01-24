import UIKit
extension UIViewController{
     enum AlertTitleType: String {
        case Error = "Error"
        case Warning = "Warning"
        case Message = "Message"
        case Information = "Information"
        case None = ""
    }
    func showAlertMessage(title: AlertTitleType, message:String, actionTitle: String? = "Ok", handler:((UIAlertAction)->())? = nil) -> Void {

        let alertCtrl = UIAlertController(title: title.rawValue, message: message, preferredStyle: UIAlertController.Style.alert)

        let alertCancel = UIAlertAction(title: actionTitle, style: .cancel, handler: handler)
        alertCtrl.addAction(alertCancel)

        self.present(alertCtrl, animated: true, completion: nil)
    }
}
