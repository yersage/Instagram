//
//  Coordinator.swift
//  Instagram
//
//  Created by Yersage on 16.04.2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
