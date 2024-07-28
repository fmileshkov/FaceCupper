import UIKit

//MARK: - Conveniece initalizer extension for ViweController
extension UIViewController {
    
    ///   Convenience initializer
    /// - Parameter storyBoardName: Name of the storyboard
    /// - Returns: Storyboard
    static func initFromStoryBoard(_ storyBoardName: String = "Main") -> Self? {
        let storyboard = UIStoryboard(name: storyBoardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self))
        return controller as? Self
    }
    
}
