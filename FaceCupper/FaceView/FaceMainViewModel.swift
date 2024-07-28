import Foundation

protocol FaceMainViewModelProtocol {
    
}


class FaceMainViewModel: FaceMainViewModelProtocol {
    
    weak var coordinator: FaceMainCoordinatorProtocol?
    
    init(coordinator: FaceMainCoordinator) {
        self.coordinator = coordinator
    }
    
    
}
