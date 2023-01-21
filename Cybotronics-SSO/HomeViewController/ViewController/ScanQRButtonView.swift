import UIKit

class ScanQRButtonView: UIView {

    // MARK: - UI Properties

    let darkShadow = CALayer()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = #imageLiteral(resourceName: "scan-QR-code")
        imageView.setDimensions(width: 65, height: 65)
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.text =  "Scan QR Code"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .black
        return titleLabel
    }()

    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.text = "Scan the QR Code displayed on the web application"
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()

    var qrCodeButtonPressed: (() -> Void)?

    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTapGesture()
        self.setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setshadow()

    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.addGestureRecognizer(tap)
    }
    @objc func handleTap() {
        qrCodeButtonPressed?()
    }
    private func setupUI() {

        self.addSubview(imageView)

        imageView.setDimensions(width: 65, height: 65)
        imageView.centerY(inView: self)
        imageView.anchor(leading: self.leadingAnchor, insets: UIEdgeInsets(top: .zero, left: 20, bottom: 0, right: 0))

        self.addSubview(titleLabel)
        titleLabel.anchor(top: imageView.topAnchor, leading: imageView.trailingAnchor, trailing: self.trailingAnchor, insets: UIEdgeInsets(top: .zero, left: 20, bottom: .zero, right: 20))

        self.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: self.bottomAnchor, trailing: titleLabel.trailingAnchor, insets: UIEdgeInsets(top: .zero, left: 0, bottom: 10, right: 20))

    }
    private func setshadow() {

        self.darkShadow.frame = self.bounds

        darkShadow.cornerRadius = 10
        darkShadow.backgroundColor = UIColor.white.cgColor
        darkShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        darkShadow.shadowOffset = CGSize(width: 10, height: 10)
        darkShadow.shadowOpacity = 1
        darkShadow.shadowRadius = 15
        self.layer.insertSublayer(darkShadow, at: 0)


    }
}
