import UIKit

extension UIView {

    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                leading: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                insets: UIEdgeInsets = .zero) -> (topConstraint: NSLayoutConstraint?, leadingConstraint: NSLayoutConstraint?,
                                                  bottomConstraint: NSLayoutConstraint?, trailingConstraint: NSLayoutConstraint? ) {

        translatesAutoresizingMaskIntoConstraints = false
        var topConstraint: NSLayoutConstraint?
        var leadingConstraint: NSLayoutConstraint?
        var bottomConstraint: NSLayoutConstraint?
        var trailingConstraint: NSLayoutConstraint?

        if let top = top {
            topConstraint = topAnchor.constraint(equalTo: top, constant: insets.top)
        }

        if let leading = leading {
            leadingConstraint = leadingAnchor.constraint(equalTo: leading, constant: insets.left)
        }

        if let bottom = bottom {
            bottomConstraint = bottomAnchor.constraint(equalTo: bottom, constant: -insets.bottom)
        }

        if let trailing = trailing {
            trailingConstraint = trailingAnchor.constraint(equalTo: trailing, constant: -insets.right)
        }

        activateConstarint(constarints: [topConstraint, leadingConstraint, bottomConstraint, trailingConstraint])
        return (topConstraint, leadingConstraint, bottomConstraint, trailingConstraint)
    }

    func center(inView view: UIView, xConstant: CGFloat = 0, yConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: xConstant).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant).isActive = true
    }

    func centerX(inView view: UIView,
                 constant: CGFloat = 0,
                 topAnchor: NSLayoutYAxisAnchor? = nil,
                 paddingTop: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true

        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop).isActive = true
        }
    }

    func centerY(inView view: UIView,
                 constant: CGFloat = 0,
                 leftAnchor: NSLayoutXAxisAnchor? = nil,
                 paddingLeading: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false

        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true

        if let leftAnchor = leftAnchor {
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: paddingLeading).isActive = true
        }
    }

    @discardableResult
    func setDimensions(width: CGFloat? = nil, height: CGFloat? = nil, widthAnchor: NSLayoutDimension? = nil, heightAnchor: NSLayoutDimension? = nil) -> (widthConstraint: NSLayoutConstraint?, heightConstraint: NSLayoutConstraint?) {
        translatesAutoresizingMaskIntoConstraints = false
        var widthConstraint: NSLayoutConstraint?
        var heightConstraint: NSLayoutConstraint?
        if let width = width {
            widthConstraint = self.widthAnchor.constraint(equalToConstant: width)
        }
        if let height = height {
            heightConstraint = self.heightAnchor.constraint(equalToConstant: height)
        }
        if let widthAnchor = widthAnchor {
            widthConstraint = self.widthAnchor.constraint(equalTo: widthAnchor)
        }
        if let heightAnchor = heightAnchor {
            heightConstraint = self.heightAnchor.constraint(equalTo: heightAnchor)
        }
        activateConstarint(constarints: [widthConstraint, heightConstraint])
        return (widthConstraint, heightConstraint)
    }

    func activateConstarint(constarints: [NSLayoutConstraint?]) {
        constarints.forEach { $0?.isActive = true }
    }

    func addConstraintsToFillView(_ view: UIView, insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            insets: insets)
    }

    func clearConstraints() {
         for subview in self.subviews {
             subview.clearConstraints()
         }
         self.removeConstraints(self.constraints)
     }
}

extension UIView {

    func applyGradient(colours: [UIColor], startPoint: CGPoint, endPoint: CGPoint) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}

extension UIView {
    class func loadFromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
