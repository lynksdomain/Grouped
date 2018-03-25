//
//  GuestMessageTableViewCell.swift
//  wmsy
//
//  Created by C4Q on 3/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class GuestMessageTableViewCell: UITableViewCell {
    
    private var profileImageView = UIImageView()
    private var textContainer = UIView()
    private var messageText = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
        placeholderTesting()
    }
    private func setupViews() {
        setupProfileImageView()
        setupTextContainer()
        setupMessageText()
    }
    private func setupProfileImageView() {
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.top.leading.equalTo(contentView.layoutMarginsGuide)
            make.width.height.equalTo(self.snp.width).multipliedBy(0.1)
        }
    }
    private func setupTextContainer() {
        contentView.addSubview(textContainer)
        textContainer.snp.makeConstraints { (make) in
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
//            make.trailing.equalTo(contentView).offset(-50)
            make.trailing.lessThanOrEqualTo(contentView).offset(-70)
            make.top.equalTo(profileImageView)
            make.bottom.equalTo(contentView.layoutMarginsGuide)
        }
    }
    private func setupMessageText() {
        messageText.numberOfLines = 0
        textContainer.addSubview(messageText)
        messageText.snp.makeConstraints { (make) in
            make.edges.equalTo(textContainer.layoutMarginsGuide)
        }
    }
    private func placeholderTesting() {
        selectionStyle = .none
        messageText.text = "oqiudfboasiudf"
        profileImageView.backgroundColor = .red
        textContainer.backgroundColor = .blue
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}