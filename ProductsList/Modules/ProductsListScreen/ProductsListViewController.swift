//
//  ProductsListViewController.swift
//  Weather
//
//  Created by Mohammed hassan on 10/21/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.

import UIKit

class ProductsListViewController: UIViewController {

    @IBOutlet weak var listOfProductsTable : UITableView!
    @IBOutlet weak var backGroundImage: AsyncImageView!

    private var viewModel: ProductsListViewModel!
    private let refreshControl = UIRefreshControl()
    private var cellsModel: [ProductCellModel] = [ProductCellModel]()

    // NOTE : Track if there is memory leak. If this is called so it is ok.
    deinit {
        print("deinit \(self)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProductsListViewModel(dbHandler: DBHandler())
        // NOTE : Get notified when there is some changes in the view model and update the UI
        viewModel.changeHandler = { [weak self] in
            self?.listOfProductsTable.reloadData()
        }

        setupView()
        refreshProductsData()
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        listOfProductsTable.backgroundColor = .clear
        self.listOfProductsTable.isOpaque = false;
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func setupView() {
        listOfProductsTable.register(CustomProductCell.self, forCellReuseIdentifier: "CustomProductCell")
        listOfProductsTable.register(UINib(nibName: "CustomProductCell",bundle: nil), forCellReuseIdentifier: "CustomProductCell")

        listOfProductsTable.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshProductsData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)

        self.backGroundImage.alpha = 0.05
    }

    func refreshProductsData() {
        _ = viewModel.getProductsListOffline()
        cellsModel = viewModel.prepareCellModel()
        self.listOfProductsTable.isHidden = false
        self.refreshControl.endRefreshing()
    }

    @objc private func refreshProductsData(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.global(qos: .background).async {
                self.viewModel.getProductsList(completionHandler: {
                    (result, statusCode, errorModel)in
                    if statusCode == 200 {
                        self.refreshControl.endRefreshing()
                    }
                })
            }
        } else {
            self.refreshControl.endRefreshing()
            Utilities.shared.showConnectionError(
                view: self,
                title: R.string.localizable.connectionError(),
                duration: 1.0,
                message: R.string.localizable.makeSureOfConnection(),
                image: R.image.cloudIcon()
            )
        }
    }
}

extension ProductsListViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellsModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = self.listOfProductsTable!.dequeueReusableCell(withIdentifier: "CustomProductCell")! as! CustomProductCell
        (cell as! CustomProductCell).setModel(model: cellsModel[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}

extension ProductsListViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Alert", message: "You tapped the cell", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            print("You canceled")
        }))
        self.present(alert, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
        UIView.animate(withDuration: 4, delay: 0.05 * Double(indexPath.row), usingSpringWithDamping: 0.4, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
        })
        cell.backgroundColor = .clear
    }
}
