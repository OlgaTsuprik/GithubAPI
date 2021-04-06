//
//  DetailedViewController.swift
//  GithubAPI
//
//  Created by Оля on 05.04.2021.
//

import UIKit

class DetailedViewController: UIViewController {
    // MARK: Variables
    var viewModel = NewsListViewModel()
    var modelR: NewsViewModel?
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var textSize: CGFloat = 22
    var offSet: CGFloat = 15
    
    // MARK: GUI Variables
    private lazy var repositoryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: textSize)
        
        return label
    }()
    
    private lazy var authorLoginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: textSize)
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    // MARK: Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.view.addSubview(self.repositoryNameLabel)
        self.view.addSubview(self.authorLoginLabel)
        self.view.addSubview(self.imageView)
        
        self.setupConstraints()
        showNavigationBar()
        showDetailes()
    }
    
    // MARK: Constraints
    func setupConstraints() {
        self.imageView.snp.updateConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        self.authorLoginLabel.snp.updateConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(offSet)
            make.left.equalToSuperview().offset(offSet)
        }
        self.repositoryNameLabel.snp.updateConstraints { (make) in
            make.top.equalTo(authorLoginLabel.snp.bottom).offset(offSet)
            make.left.equalToSuperview().offset(offSet)
        }
    }
   
    // MARK: Methods
    func showDetailes() {
        repositoryNameLabel.text = modelR?.repositoryName
        authorLoginLabel.text = modelR?.authorLogin
        NetworkManager.shared.getImage(urlString: modelR?.authorAvatar ?? "") { (data) in
            guard let data = data else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
            }
        }
    }
}
