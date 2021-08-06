import UIKit

public final class Responsive {
    private static var instance: Responsive?
    var width: CGFloat!
    var height: CGFloat!
    var inch: CGFloat!
    
    private init() {}
    
    public static func of(_ view: UIView = UIWindow(frame: UIScreen.main.bounds)) -> Responsive {
        instance = Responsive()
        instance!.width = view.frame.width
        instance!.height = view.frame.height
        instance!.inch = CGFloat(sqrt(pow(Double(view.frame.width), 2.0) + pow(Double(view.frame.height), 2.0)))
        return instance!
    }
    
    public func wp(_ percent: CGFloat) -> Responsive {
        width = width * percent / 100
        return self
    }
    
    public func hp(_ percent: CGFloat) -> Responsive {
        height = height * percent / 100
        return self
    }
    
    public func ip(_ percent: CGFloat) -> Responsive {
        inch = inch * percent / 100
        return self
    }
    
    func build() -> Responsive {
        return self
    }
}
