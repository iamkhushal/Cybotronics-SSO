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

extension UIViewController {

    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

}
