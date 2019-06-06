//
//  VedioPlayCollectionHeader.swift
//  MiniEye
//
//  Created by 朱慧林 on 2019/5/25.
//  Copyright © 2019 MINIEYE. All rights reserved.
//

import UIKit

class VedioPlayCollectionHeader: UICollectionReusableView {
    
    lazy  var titleLabel:BasicLabel = {
        let label = BasicLabel.initWith(text: "开车八卦")
        label.textAlignment = .left
        label.font = CommonFont.content
        
        return label
    }()
    
    lazy  var detailLabel:BasicLabel = {
        let label = BasicLabel.initWith(text: "开车八卦，想看就进来，热帖更新！")
        label.textAlignment = .left
        label.textColor = CommonColor.grayText
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
    }
    
    func configureSubviews() -> () {
        addSubview(titleLabel)
        addSubview(detailLabel)
        
        titleLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self)?.offset()(homePageCellHorizitalMargin)
            make?.right.equalTo()(self)?.offset()(-homePageCellHorizitalMargin)
            make?.top.equalTo()(self)?.offset()(10)
            make?.height.mas_equalTo()(20)
        }
        
        detailLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self)?.offset()(homePageCellHorizitalMargin)
            make?.right.equalTo()(self)?.offset()(-homePageCellHorizitalMargin)
            make?.top.equalTo()(self.titleLabel.mas_bottom)
            make?.height.mas_equalTo()(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
