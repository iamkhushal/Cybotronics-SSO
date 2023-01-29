import UIKit

class TokenTableViewCell: UITableViewCell {

    // MARK: UI Properties
    private lazy var serviceImageView: UIImageView = {
        let serviceImageView = UIImageView(frame: .zero)
        serviceImageView.setDimensions(width: 45, height: 45)
        serviceImageView.image = UIImage(named: "serviceImagePlaceholder")
        return serviceImageView
    }()

    private lazy var serviceNameLabel: UILabel = {
        let serviceNameLabel = UILabel(frame: .zero)
        serviceNameLabel.font = UIFont.systemFont(ofSize: 19.0, weight: .bold)
        serviceNameLabel.textColor = .accentColor
        serviceNameLabel.setDimensions(height: 25)
        serviceNameLabel.text = "Service Name"
        return serviceNameLabel
    }()
    private lazy var emailLabel: UILabel = {
        let emailLabel = UILabel(frame: .zero)
        emailLabel.font = UIFont.systemFont(ofSize: 18.0)
        emailLabel.setDimensions(height: 20)
        emailLabel.text = "xxx@gmail.com"
        return emailLabel
    }()
    private lazy var otpLabel: UILabel = {
        let otpLabel = UILabel(frame: .zero)
        otpLabel.font = UIFont.systemFont(ofSize: 32.0, weight: .semibold)
        otpLabel.setDimensions(width: 150, height: 35)
        otpLabel.text = random(digits: 6)
        otpLabel.textColor = .accentColor
        return otpLabel
    }()
    private lazy var copyButton: UIButton = {
        let copyButton = UIButton(frame: .zero)
        copyButton.setTitle("", for: .normal)
        copyButton.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        copyButton.setDimensions(width: 25, height: 25)
        copyButton.tintColor = .accentColor
        copyButton.addTarget(self, action: #selector(copyButtonPressed), for: .touchUpInside)
        return copyButton
    }()
    private lazy var deleteButton: UIButton = {
        let deleteButton = UIButton(frame: .zero)
        deleteButton.setTitle("", for: .normal)
        deleteButton.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        deleteButton.setDimensions(width: 35, height: 35)
        deleteButton.tintColor = .accentColor
        return deleteButton
    }()
    private lazy var countDownView: CountdownTimer = {
        let countDownView = CountdownTimer(frame: .zero)
        countDownView.setDimensions(width: 35, height: 35)
        countDownView.lineWidth = 3
        countDownView.lineColor = #colorLiteral(red: 0.1960784314, green: 0.462745098, blue: 0.7490196078, alpha: 1)
        countDownView.trailLineColor = #colorLiteral(red: 0.6196078431, green: 0.7725490196, blue: 0.9921568627, alpha: 1)
        countDownView.labelFont = UIFont.systemFont(ofSize: 14)
        countDownView.backgroundColor = .clear
        countDownView.labelTextColor = .black
        countDownView.delegate = self
        return countDownView
    }()

    // MARK: - Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func setupUI() {
        self.contentView.addSubview(serviceImageView)
        serviceImageView.anchor(top: self.contentView.topAnchor, leading: self.contentView.leadingAnchor, insets: UIEdgeInsets(top: 10, left: 10, bottom: .zero, right: .zero))

        self.contentView.addSubview(serviceNameLabel)
        serviceNameLabel.anchor(top: serviceImageView.topAnchor, leading: serviceImageView.trailingAnchor, insets: UIEdgeInsets(top: 0, left: 15, bottom: .zero, right: .zero))

        self.contentView.addSubview(emailLabel)
        emailLabel.anchor(top: serviceNameLabel.bottomAnchor, leading: serviceNameLabel.leadingAnchor, insets: UIEdgeInsets(top: 2, left: .zero, bottom: .zero, right: .zero))


        self.contentView.addSubview(otpLabel)
        otpLabel.anchor(top: emailLabel.bottomAnchor, leading: emailLabel.leadingAnchor, bottom: self.contentView.bottomAnchor, insets: UIEdgeInsets(top: 10, left: .zero, bottom: 10, right: .zero))
        otpLabel.addCharacterSpacing()

        self.contentView.addSubview(copyButton)
        copyButton.centerY(inView: otpLabel)
        copyButton.anchor(leading: otpLabel.trailingAnchor, insets: UIEdgeInsets(top: .zero, left: 8, bottom: .zero, right: .zero))

        self.contentView.addSubview(deleteButton)
        deleteButton.anchor(top: self.contentView.topAnchor, leading: serviceNameLabel.trailingAnchor, trailing: contentView.trailingAnchor, insets: UIEdgeInsets(top: 10, left: 10, bottom: .zero, right: 10))

        self.contentView.addSubview(countDownView)
        countDownView.centerY(inView: copyButton)
        countDownView.anchor(leading: copyButton.trailingAnchor, insets: UIEdgeInsets(top: .zero, left: 10, bottom: .zero, right: .zero))

    }

    func startTimer() {
        DispatchQueue.main.async {
            self.otpLabel.text = self.random(digits: 6)
            self.otpLabel.addCharacterSpacing()
            self.countDownView.start(beginingValue: 30, interval: 1)
        }

    }


    @objc
    private func copyButtonPressed() {
        UIPasteboard.general.string = otpLabel.text
        UIApplication.topViewController()?.showToast(message: "OTP Copied", font: UIFont.systemFont(ofSize: 15))
    }
    // TODO: -  Remove this
    private func random(digits:Int) -> String {
        var number = String()
        for _ in 1...digits {
           number += "\(Int.random(in: 1...9))"
        }
        return number
    }
}

extension TokenTableViewCell: CountdownTimerDelegate {
    func timerDidEnd() {
        self.startTimer()
    }
}
