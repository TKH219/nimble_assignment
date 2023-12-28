//
//  DateView.swift
//  nimble_assignment
//
//  Created by Trần Hà on 28/12/2023.
//

import UIKit
import SkeletonView
import SnapKit

class DateView: UIView {

    private lazy var weekDateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.isSkeletonable = true
        label.skeletonTextLineHeight = .fixed(20)
        label.linesCornerRadius = 8
        label.text = "DateUtils.dateInWeek(Date())?.uppercased()"
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 34)
        label.textColor = .white
        label.text = "today"
        label.isSkeletonable = true
        label.skeletonTextLineHeight = .fixed(20)
        label.linesCornerRadius = 8
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        isSkeletonable = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(weekDateLabel)
        addSubview(dateLabel)
        weekDateLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        dateLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(weekDateLabel.snp.bottom).offset(4)
        }
    }

}
