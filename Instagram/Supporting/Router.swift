//
//  Router.swift
//  Instagram
//
//  Created by Yersage on 16.01.2022.
//

import UIKit

protocol Router {
   func route(
      to routeID: String,
      from context: UIViewController,
      parameters: Any?
   )
}
