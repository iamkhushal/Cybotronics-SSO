import UIKit

extension UIScreen {
    static var screenWidth: CGFloat {
        //If in landscape mode
        if Orientation.isLandscape {
            //If in landscape and the width is less than the height (wrong),
            //return the height instead of the width
            if (screenSize.width < screenSize.height) {
                return screenSize.height
            }
        }
        //Else just return the width
        return screenSize.width
    }

    static var screenHeight: CGFloat {
        //If in landscape mode
        if Orientation.isLandscape {
            //If in landscape and the height is greater than the width (wrong),
            //return the width instead of the height
            if (screenSize.height > screenSize.width) {
                return screenSize.width
            }
        }
        //Else just return the height
        return screenSize.height
    }

    static var screenSize: CGRect {
        return UIScreen.main.bounds
    }
}
