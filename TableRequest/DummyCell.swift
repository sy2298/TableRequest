//
//  DummyCell.swift
//  TableRequest
//
//  Created by 이서영 on 2021/06/24.
//

import UIKit
import SnapKit
class DummyCell: UITableViewCell{
    static let identifier = "DummyCell"
    var dummyView : UIView = {
        let view = UIView()
        return view
    }()
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight:.medium)
        return label
    }()
    var phoneLabel : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 2
        label.frame.size.height=100
        label.font = .systemFont(ofSize: 16, weight:.light)
        return label
    }()
//    var dateLabel : UILabel = {
//        let label = UILabel()
//        label.textColor = .gray
//
//        label.font = .systemFont(ofSize: 13, weight:.light)
//        return label
//    }()
//    var priceLabel : UILabel = {
//        let label = UILabel()
//        label.textColor = .gray
//        label.numberOfLines = 2
//        label.textAlignment = .right
//        label.font = .systemFont(ofSize: 14, weight:.bold)
//        return label
//    }()
    var thumbImage: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style,reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(dummyView)
        self.dummyView.addSubview(self.nameLabel)
        self.dummyView.addSubview(self.phoneLabel)
        self.dummyView.addSubview(self.thumbImage)
//        self.movieView.addSubview(self.movieImageView)
//        self.movieView.addSubview(self.titleLabel)
//        self.movieView.addSubview(self.dateLabel)
//        self.movieView.addSubview(self.priceLabel)
//        self.movieView.addSubview(self.descriptionLabel)
       dummyView.snp.makeConstraints({ (make) in
            make.top.equalTo(10)
            make.left.equalTo(10)
            make.right.equalTo(100)
        })
        thumbImage.snp.makeConstraints({ (make) in
            //make.top.leading.equalTo(dummyView.snp.top).offset(10)
            make.width.height.equalTo(90)
        })
       nameLabel.snp.makeConstraints({(make)in
           make.top.equalTo(dummyView.snp.top).offset(10)
           make.leading.equalTo(thumbImage.snp.trailing).offset(10)
           
        })
        phoneLabel.snp.makeConstraints({(make)in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalTo(thumbImage.snp.trailing).offset(10)
           
        })
    }
        required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

