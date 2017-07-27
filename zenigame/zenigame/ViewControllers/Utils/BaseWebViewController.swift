//
//  BaseWebViewController.swift
//  zenigame
//
//  Created by 笹野　駿 on 2017/04/07.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import PureLayout
import UIKit
import WebKit

class BaseWebViewController: UIViewController {
    //    呼び出し方
    //    以下の記述であればgoogle.comを表示させることができる
    //    let baseWebViewController = BaseWebViewController.instantiate(storyboard: "BaseWebView")
    //    let googleURLString = "https://google.co.jp"
    //    baseWebViewController.receiveURL = URL(string: googleURLString)
    //    present(baseWebViewController, animated: true, completion: nil)

    private lazy var webView = { () -> WKWebView in
        let w = WKWebView()
        self.view.addSubview(w)
        let insets = UIEdgeInsets(top: UIApplication.shared.statusBarFrame.height, left: 0.0, bottom: 0.0, right: 0.0)
        w.autoPinEdgesToSuperviewEdges(with: insets)
        return w
    }()

    //ここでURLを受け取る。
    var receiveURL: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        receiveURL = URL(string: "https://876tvlivepfapi-dev.channel.or.jp/web/servlet/test.top")
        if let url = receiveURL {
            //URLをrequestに変換する。
            let urlRequest = URLRequest(url: url)
            //webViewに表示させる。
            webView.load(urlRequest)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
