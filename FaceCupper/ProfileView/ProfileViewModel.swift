import Foundation

protocol ProfileViewModelProtocol {
    
}

class ProfileViewModel: ProfileViewModelProtocol {
    
    weak var coordinator: ProfileCoordinatorProtocol?
    
    init(coordinator: ProfileCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    
}
