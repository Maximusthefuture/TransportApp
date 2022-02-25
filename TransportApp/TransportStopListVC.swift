//
//  ViewController.swift
//  TransportApp
//
//  Created by Maximus on 24.02.2022.
//

import UIKit

class TransportStopListVC: UIViewController {
    
    fileprivate var loadingIndicator: UIActivityIndicatorView?
    fileprivate let tableView = UITableView()
    fileprivate var vm: TransportStopsViewModelProtocol?
 
    
    init(viewModel: TransportStopsViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.vm = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Остановки"
        initTableView()
        initLoadingIndicator()
        getVMObservers()
    }

    fileprivate func getVMObservers() {
        vm?.getTransportStopsList()
        vm?.reload = {
            DispatchQueue.main.async {
                self.stopLoadingIndicator()
                self.tableView.reloadData()
            }
        }
    }
    
    fileprivate func initLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView(style: .large)
        view.addSubview(loadingIndicator!)
        loadingIndicator?.centerInSuperview()
        loadingIndicator?.startAnimating()
        tableView.isHidden = true
    }
    
    fileprivate func stopLoadingIndicator() {
        loadingIndicator?.stopAnimating()
        tableView.isHidden = false
    }
    
    fileprivate func initTableView() {
        let safeArea = view.safeAreaLayoutGuide
        view.addSubview(tableView)
        tableView.anchor(top:safeArea.topAnchor, leading: view.leadingAnchor, bottom: safeArea.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension TransportStopListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text  = vm?.busStopItem(at: indexPath.row).name
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm?.busStopsCount ?? 0
    }
}

extension TransportStopListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let oneMoreVC = TransportStopDetailVC(initialHeight: 300)
        let diContainer = DependencyContainer.shared()
        let transportStopId = vm?.busStopItem(at: indexPath.row).id
        print("id", transportStopId)
        let vc = diContainer.makeDetailMapViewController(transportStopId: transportStopId ?? "00000000")
        self.navigationController?.pushViewController(vc, animated: true)
//        present(oneMoreVC, animated: true)
        
    }
}

