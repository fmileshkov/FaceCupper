//
//  TabBarViewModel.swift
//  FaceCupper
//
//  Created by Admin on 6.05.24.
//

import Foundation

import Foundation

//MARK: - TabBarViewModelProtocl
protocol TabBarViewModelProtocol {
    func tabBarItemPressed(tabBar: String)
}

class TabBarViewModel: TabBarViewModelProtocol {
    
    //MARK: - Properties
    weak var coordinator: TabBarCoordinatorProtocol?
    
    //MARK: - Initializer
    init(coordinator: TabBarCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func tabBarItemPressed(tabBar: String) {
        coordinator?.tabBarItemClicked(itemName: tabBar)
    }
    
}
