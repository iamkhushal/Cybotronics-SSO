import UIKit

class HomeViewController: UIViewController {

    // MARK: - UIProperties
    let screenHeight = UIScreen.screenHeight
    let screenWidth = UIScreen.screenWidth

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "add_user")
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.text = "ADD new Account"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .accentColor
        return titleLabel
    }()

    private lazy var scanQRButtonView: ScanQRButtonView = {
        let scanQRButtonView: ScanQRButtonView =  ScanQRButtonView(frame: .zero)
        scanQRButtonView.setDimensions(width: screenWidth * 0.8, height: screenHeight * 0.15)
        return scanQRButtonView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = .white
        setupUI()

        scanQRButtonView.qrCodeButtonPressed = {
            print("Pressed")
        }
    }

    fileprivate func setupUI() {

        view.addSubview(imageView)
        imageView.anchor(top: view.topAnchor, insets: UIEdgeInsets(top: screenHeight * 0.15, left: .zero, bottom: .zero, right: .zero))
        imageView.setDimensions(width: screenWidth * 0.5, height: screenWidth * 0.5)
        imageView.centerX(inView: view)

        view.addSubview(titleLabel)
        titleLabel.centerX(inView: view)
        titleLabel.anchor(top: imageView.bottomAnchor, insets: UIEdgeInsets(top: 25, left: .zero, bottom: .zero, right: .zero))

        view.addSubview(scanQRButtonView)
        scanQRButtonView.centerX(inView: view)
        scanQRButtonView.anchor(top: titleLabel.bottomAnchor, insets: UIEdgeInsets(top: 25, left: .zero, bottom: .zero, right: .zero))

    }

}
