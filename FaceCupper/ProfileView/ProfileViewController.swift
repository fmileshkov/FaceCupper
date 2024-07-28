import UIKit

class ProfileViewController: UIViewController {
    
    var viewModel: ProfileViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
    }

}
