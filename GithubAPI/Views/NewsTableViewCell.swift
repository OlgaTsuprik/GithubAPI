//
//  NewsTableViewCell.swift
//  GithubAPI
//
//  Created by Оля on 04.04.2021.
//

import UIKit
import SnapKit

class NewsTableViewCell: UITableViewCell {
    // MARK: Variables
    var imageSize: CGFloat = 70
    var offSet: CGFloat = 10
    var textSize: CGFloat = 20
    var stackSpacing: CGFloat = 10
    
    var newsVM: NewsViewModel? {
        didSet {
            if let newsVM = newsVM {
                newsTypeLabel.text = newsVM.newsType
                authorLoginLabel.text = newsVM.authorLogin
                newsCreatedDataLabel.text = newsVM.newsCreatedData
                NetworkManager.shared.getImage(urlString: newsVM.authorAvatar) { (data) in
                    guard let data = data else { return }
                        DispatchQueue.main.async {
                            self.newsImage.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    var newsImageData: Data? {
        didSet {
            if let data = newsImageData {
                newsImage.image = UIImage(data: data)
            }
        }
    }
    
    // MARK: GUI Variables
    private lazy var newsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private lazy var newsTypeLabel: UILabel = {
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
        
        return label
    }()
    
    private lazy var newsCreatedDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        
        return label
    }()
    
    private lazy var cellStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [newsTypeLabel, authorLoginLabel, newsCreatedDataLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = stackSpacing
        
        return stack
    }()
    
    private lazy var commonCellStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [newsImage, cellStackView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal

        return stack
    }()
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    func setupView() {
        addSubview(newsImage)
        addSubview(cellStackView)
        setupConstraints()
    }
    
    // MARK: Constraints
    func setupConstraints() {
      // image
        self.newsImage.snp.updateConstraints { (make) in

            make.left.equalToSuperview()
            make.height.width.equalTo(imageSize)
            make.centerY.equalToSuperview()
        }
        self.cellStackView.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(offSet)
            make.left.equalTo(self.newsImage.snp.right).offset(offSet)
            make.right.bottom.equalToSuperview().offset(-offSet)
        }
    }
}
