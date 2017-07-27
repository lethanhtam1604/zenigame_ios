//
//  MainViewController.swift
//  zenigame
//
//  Created by 笹野駿 on 2017/04/22.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setNavigationBarItem()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.setNavigationBarItem()
    }
    func setNavigationBarItem() {
        self.addLeftBarButtonWithImage(UIImage(named: "humberger")!) // swiftlint:disable:this force_unwrapping
    }

}
