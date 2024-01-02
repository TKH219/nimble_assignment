//
//  ProfileSideMenuViewController.swift
//  nimble_assignment
//
//  Created by Trần Hà on 28/12/2023.
//

import UIKit
import SideMenu

class ProfileSideMenuViewController: BaseViewController<ProfileSideMenuViewModel> {
    
    var onLogoutSuccess: (() -> Void)?

    lazy var profileButton: RoundedButton = {
        let button = RoundedButton(imageString: "user_profile", borderRadius: 28)
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 34)
        return label
    }()
    
    private lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.5)
        view.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        return view
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white.withAlphaComponent(0.8), for: .normal)
        button.addTarget(self, action: #selector(onLogout), for: .touchUpInside)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func setupView() {
        super.setupView()
        view.backgroundColor = .black
        view.addSubview(nameLabel)
        view.addSubview(profileButton)
        view.addSubview(line)
        view.addSubview(logoutButton)
        
        profileButton.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(45)
            } else {
                make.top.equalToSuperview().offset(45)
            }
            make.right.equalToSuperview().offset(-20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileButton)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(profileButton.snp.left).offset(-20)
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(profileButton.snp.bottom).offset(20)
            make.left.equalTo(nameLabel)
            make.right.equalTo(profileButton)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(20)
            make.left.equalTo(nameLabel)
        }
    }
    
    @objc func onLogout() {
        viewModel.logout()
        guard let onLogoutSuccess = onLogoutSuccess else {return}
        onLogoutSuccess()
    }
}
