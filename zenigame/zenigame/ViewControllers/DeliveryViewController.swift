//
//  DeliveryViewController.swift
//  zenigame
//
//  Created by 笹野駿 on 2017/04/18.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import UIKit
import PureLayout

class DeliveryViewController: BaseDeliveryViewController {

    var pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

    let pages = ["BaseWebViewController", "CameraViewController"]
    var constraintsAdded = false

    override func viewDidLoad() {
        super.viewDidLoad()

        pageController.delegate = self
        pageController.dataSource = self

        let viewController = CameraViewController.instantiate(storyboard: "Camera")
        pageController.setViewControllers([viewController], direction: .forward, animated: false, completion: nil)

        pageController.didMove(toParentViewController: self)
        view.addSubview(pageController.view)
        view.addSubview(abstractView)
        view.addSubview(menuView)
        view.addSubview(navigationBarView)
        view.setNeedsUpdateConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()

        if !constraintsAdded {
            constraintsAdded = true

            pageController.view.autoPinEdge(toSuperviewEdge: .top, withInset: 64)
            pageController.view.autoPinEdge(toSuperviewEdge: .bottom)
            pageController.view.autoMatch(.width, to: .width, of: view)
            pageController.view.autoAlignAxis(toSuperviewAxis: .vertical)
        }
    }
}

extension DeliveryViewController: UIPageViewControllerDataSource {

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        //        if let identifier = viewController.restorationIdentifier {
        //            if let index = pages.index(of: identifier) {
        //                if index > 0 {
        //                    let storyboard = UIStoryboard(name: "BaseWebView", bundle: nil)
        //                    return storyboard.instantiateViewController(withIdentifier: pages[0])
        //                }
        //            }
        //        }
        //
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        //        if let identifier = viewController.restorationIdentifier {
        //            if let index = pages.index(of: identifier) {
        //                if index < pages.count - 1 {
        //                    let storyboard = UIStoryboard(name: "BaseWebView", bundle: nil)
        //                    return storyboard.instantiateViewController(withIdentifier: pages[0])
        //                }
        //            }
        //        }
        //
        //        return nil

        if(pageViewController.childViewControllers.count < 2) {
            let storyboard = UIStoryboard(name: "BaseWebView", bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: pages[0])
        }

        return nil
    }
}

extension DeliveryViewController: UIPageViewControllerDelegate {

}
