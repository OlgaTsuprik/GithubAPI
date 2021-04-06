//
//  ViewController.swift
//  GithubAPI
//
//  Created by Оля on 01.04.2021.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Variables
    var viewModel = NewsListViewModel()
    var modelToSend = NewsListViewModel().newsVM
    
    var headerViewSize: CGFloat = 20
    var offSet: CGFloat = 10
    
    // MARK: GUI Variables
    lazy var headerView: HeaderView = {
        let view = HeaderView(fontSize: headerViewSize)
        
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: viewModel.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideNavigationBar()
        setupView()
        fetchNews()
    }
    
    // MARK: Life cicle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }
    
    // MARK: Methods
    func setupView() {
        view.backgroundColor = .black
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        setupConstraints()
    }
    
    // MARK: Constraints
    func setupConstraints() {
        // Header
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: offSet),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: offSet),
        ])
        // TableView
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: offSet),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func fetchNews() {
        viewModel.getNews { (_) in
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.newsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseID, for: indexPath) as? NewsTableViewCell
        let news = viewModel.newsVM[indexPath.row]
        cell?.newsVM = news
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailedViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        let model = viewModel.newsVM[indexPath.row]
        vc.modelR = model
    }
}
