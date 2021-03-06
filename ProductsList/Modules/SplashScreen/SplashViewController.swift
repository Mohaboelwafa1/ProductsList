//
//  SplashViewController.swift
//  Weather
//
//  Created by Mohammed hassan on 10/20/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var launchScreenBGImage: AsyncImageView!
    private var viewModel: SplashViewModel!

    // NOTE : Track if there is memory leak. If this is called so it is ok.
    deinit {
        print("deinit \(self)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SplashViewModel(dbHandler: DBHandler())
        // NOTE : Get notified when there is some changes in the view model and update the UI
        viewModel.changeHandler = { [weak self] in
            self?.goToProductsListScreen()
        }

        if Utilities.shared.isItFirstLaunch() {
            fetchProductsData()
        } else {
            goToProductsListScreen()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func goToProductsListScreen() {
        // NOTE : Hide the loader
        self.dismiss(animated: false, completion: nil)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let productsListViewController = storyBoard.instantiateViewController(withIdentifier: "ProductsListViewController") as! ProductsListViewController
        self.navigationController?.pushViewController(productsListViewController, animated: true)
    }


    func fetchProductsData() {
        if Reachability.isConnectedToNetwork() {
            Utilities.shared.ShowIndicator(title: nil, message:  "Please wait", controller: self)
            DispatchQueue.global(qos: .background).async {
                self.viewModel.getProductsList(completionHandler: {
                    (result, statusCode, errorModel)in
                    if statusCode == 200 {
                        UserDefaults.standard.set(true, forKey: Keys.launchedBefore.rawValue)
                    }
                })
            }
        } else {
            UserDefaults.standard.set(false, forKey: Keys.launchedBefore.rawValue)
            Utilities.shared.showConnectionError(
                view: self,
                title: R.string.localizable.connectionError(),
                duration: 2.0,
                message: R.string.localizable.retryConnect(),
                image: R.image.connectionError()
            )

            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.fetchProductsData()
            }
        }
    }
}
