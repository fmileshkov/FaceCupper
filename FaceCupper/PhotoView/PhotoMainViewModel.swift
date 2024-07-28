import Foundation

protocol PhotoMainViewModelProtocol {
    
}

class PhotoMainViewModel: PhotoMainViewModelProtocol {
    
    private weak var coordinator: PhotoMainCoordinatorProtocol?
    
    init(coordinator: PhotoMainCoordinator) {
        self.coordinator = coordinator
    }
}
