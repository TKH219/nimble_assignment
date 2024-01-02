//
//  SurveyCollectionViewCell.swift
//  nimble_assignment
//
//  Created by Trần Hà on 28/12/2023.
//

import UIKit
import Kingfisher

protocol ReusableCell {
    static var identifier: String { get }
}

extension ReusableCell where Self: UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

class SurveyCollectionViewCell: UICollectionViewCell, ReusableCell {
    
    var onTakeSurveyTap: (() -> Void)?
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var overlayView: UIView = {
        let view = UIView()
        view.alpha = 0.6
        return view
    }()
    
    lazy var titleLabel: TitleLabel = {
        let label = TitleLabel(titleString: "")
        label.font = .boldSystemFont(ofSize: 28)
        return label
    }()
    
    lazy var descriptionLabel: TitleLabel = {
        let label = TitleLabel(titleString: "")
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.black.cgColor,
            UIColor.black.withAlphaComponent(0.01).cgColor
           
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        return gradientLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(backgroundImage)
        contentView.addSubview(overlayView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(contentView.snp.bottom).inset(150)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        
        contentView.isSkeletonable = true
    }
    
    func bindData(survey: Survey?) {
        if let urlString = survey?.getHighResolutionCoverImageUrl(), let url = URL(string: urlString) {
            backgroundImage.kf.setImage(with: url)
        } else {
            backgroundImage.image = UIImage(named: "login_background")
        }

        guard let survey = survey else {
            return
        }

        titleLabel.text = survey.title
        descriptionLabel.text = survey.description
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        overlayView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
