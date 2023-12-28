//
//  SurveyDetailViewController.swift
//  nimble_assignment
//
//  Created by Trần Hà on 29/12/2023.
//

import Foundation
import Swinject

class SurveyDetailViewController: BaseViewController<SurveyDetailViewModel> {
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"splash_screen_background")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func setupView() {
        self.view.addSubview(backgroundImageView)
        self.backgroundImageView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
    }
}
