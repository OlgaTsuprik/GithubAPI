//
//  HeaderView.swift
//  GithubAPI
//
//  Created by Оля on 04.04.2021.
//

import UIKit

class HeaderView: UIView {
    // MARK: Variables
    var textSize: CGFloat = 40
    var stackSpacing: CGFloat = 10
    
    // MARK: GUI Variables
    private lazy var headingLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "GitHub Events"
        label.font = UIFont.boldSystemFont(ofSize: textSize)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var headerCircleImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        let config = UIImage.SymbolConfiguration(pointSize: textSize, weight: .bold)
        image.image = UIImage(systemName: "pencil.tip.crop.circle", withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        return image
    }()
    
    private lazy var headerStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [ headingLabel, headerCircleImage])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = stackSpacing
        return stack
    }()
    
    // MARK: Initialization
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    func setupView() {
        addSubview(headerStackView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerStackView.topAnchor.constraint(equalTo: topAnchor),
            headerStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
