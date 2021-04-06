//
//  SetNavigationBar.swift
//  GithubAPI
//
//  Created by Оля on 06.04.2021.
//

import UIKit
extension UIViewController {
    func hideNavigationBar(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
