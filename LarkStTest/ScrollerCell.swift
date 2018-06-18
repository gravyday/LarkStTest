//
//  ScrollerCell.swift
//  LarkStTest
//
//  Created by dave on 6/18/18.
//  Copyright © 2018 dave. All rights reserved.
//

import UIKit

let kCellDefaultWidth: CGFloat = 335.0
let kCellDefaultHeight: CGFloat = 470.0
let kDefaultAddressFontSize: CGFloat = 20
let kDefaultDescriptionFontSize: CGFloat = 12
let kDefaultBottomViewSize: CGFloat = 50.0
let kDefaultMemberViewImageSize: CGFloat = 24.0
let kDefaultAddressLeftPadding: CGFloat = 52.0
let kDefaultAddressRightPadding: CGFloat = 17.0
let kDefaultAddressBottomPadding: CGFloat = 21
let kDefaultDescriptionLeftPadding: CGFloat = 67.0
let kDefaultDescriptionRightPadding: CGFloat = 72.0
let kDefaultDescriptionBottomPadding: CGFloat = 9
let kDefaultAddressHeight: CGFloat = 30
let kDefaultDescriptionHeight: CGFloat = 20
let kDefaultMemberLeftPadding: CGFloat = 8.0
let kDefaultMemberBottomPadding: CGFloat = 15.0
let kDefaultCommentLeftPadding:CGFloat = 20
let kDefaultCommentBottomPadding:CGFloat = 4
let kDefaultRectangleSize:CGFloat = 6
let kDefaultCornerRadius:CGFloat = 15

class ScrollerCell:UICollectionViewCell {
    let imageView: UIButton = {
        let iv = UIButton()
        iv.setImage(#imageLiteral(resourceName: "questionmark"), for: .normal)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    let memberView: UIButton = {
        let iv = UIButton()
        iv.setImage(#imageLiteral(resourceName: "questionmark"), for: .normal)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    let commentButton: UIButton = {
        let iv = UIButton()
        iv.setImage(#imageLiteral(resourceName: "iconComment"), for: .normal)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    let rectangleView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "rectangle"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()

   let addressText: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false;
        text.textColor = .gray
        text.text = "(loading)"
        text.textAlignment = .left
        text.isScrollEnabled = false
        text.isEditable = false

        return text;
    }()

    let descriptionText: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false;
        text.textColor = .gray
        text.font = UIFont.systemFont(ofSize: kDefaultDescriptionFontSize)
        text.text = "(loading)"
        text.textAlignment = .left
        text.isScrollEnabled = false
        text.isEditable = false

        return text;
    }()

    @objc func commentAction(sender: UIButton?) {
        print("Comment Pressed")
    }

    @objc func imageAction(sender: UIButton?) {
        print("Image Pressed")
    }

    @objc func memberAction(sender: UIButton?) {
        print("Member Pressed")
    }

    var imageSave = [URL: UIImage]()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath

        let w = frame.width
        let ratio = w/kCellDefaultWidth

        addSubview(imageView)
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.imageRect(forContentRect: frame)
        imageView.contentMode = .scaleAspectFit;
        imageView.contentHorizontalAlignment = .fill;
        imageView.contentVerticalAlignment = .fill;

        imageView.layer.cornerRadius = kDefaultCornerRadius
        imageView.layer.borderWidth = kDefaultCornerRadius
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.layer.masksToBounds = true


        imageView.addTarget(self, action: #selector(imageAction(sender:)), for: .touchUpInside)

        let bottomview = UIView(frame: CGRect(x: 0, y: frame.height-kDefaultBottomViewSize*ratio, width: frame.width, height: kDefaultBottomViewSize*frame.width/kCellDefaultWidth))
        bottomview.backgroundColor = .white
        addSubview(bottomview)
        bottomview.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        bringSubview(toFront: bottomview)

        let rectShape = CAShapeLayer()
        rectShape.bounds = bottomview.frame
        rectShape.position = bottomview.center
        rectShape.path = UIBezierPath(roundedRect: bottomview.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: kDefaultCornerRadius, height: kDefaultCornerRadius)).cgPath

        //Here I'm masking the textView's layer with rectShape layer
        bottomview.layer.mask = rectShape

        addSubview(memberView)
        memberView.leftAnchor.constraint(equalTo: leftAnchor, constant: kDefaultMemberLeftPadding*ratio).isActive = true
        memberView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -kDefaultMemberBottomPadding*ratio).isActive = true
        memberView.widthAnchor.constraint(equalToConstant: kDefaultMemberViewImageSize*ratio).isActive = true
        memberView.heightAnchor.constraint(equalToConstant: kDefaultMemberViewImageSize*ratio).isActive = true

        memberView.layer.cornerRadius = kDefaultMemberViewImageSize*ratio/2
        memberView.layer.borderWidth = 1.0
        memberView.layer.borderColor = UIColor.orange.cgColor
        memberView.layer.masksToBounds = true

        memberView.addTarget(self, action: #selector(memberAction(sender:)), for: .touchUpInside)

        addSubview(commentButton)
        commentButton.leftAnchor.constraint(equalTo: leftAnchor, constant: kDefaultCommentLeftPadding*ratio).isActive = true
        commentButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -kDefaultCommentBottomPadding*ratio).isActive = true
        commentButton.widthAnchor.constraint(equalToConstant: kDefaultMemberViewImageSize*ratio).isActive = true
        commentButton.heightAnchor.constraint(equalToConstant: kDefaultMemberViewImageSize*ratio).isActive = true

        commentButton.addTarget(self, action: #selector(commentAction(sender:)), for: .touchUpInside)

        addSubview(addressText)
        let bottom = 0 - kDefaultAddressBottomPadding*w/kCellDefaultWidth
        let left = kDefaultAddressLeftPadding*ratio
        addressText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottom).isActive = true
        addressText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: left).isActive = true
        addressText.rightAnchor.constraint(equalTo: rightAnchor, constant: kDefaultAddressRightPadding*ratio).isActive = true
        addressText.heightAnchor.constraint(equalToConstant: kDefaultAddressHeight*ratio).isActive = true
        addressText.backgroundColor = .clear
        addressText.font = UIFont.systemFont(ofSize: kDefaultAddressFontSize)

        addSubview(descriptionText)
        descriptionText.leftAnchor.constraint(equalTo: leftAnchor, constant: kDefaultDescriptionLeftPadding*ratio).isActive = true
        descriptionText.rightAnchor.constraint(equalTo: rightAnchor, constant: kDefaultDescriptionRightPadding*ratio).isActive = true
        descriptionText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -kDefaultDescriptionBottomPadding*ratio).isActive = true
        descriptionText.heightAnchor.constraint(equalToConstant: kDefaultDescriptionHeight*ratio).isActive = true
        descriptionText.backgroundColor = .clear

        addSubview(rectangleView)
        rectangleView.rightAnchor.constraint(equalTo: descriptionText.leftAnchor).isActive = true
        rectangleView.heightAnchor.constraint(equalToConstant: kDefaultRectangleSize*ratio).isActive = true
        rectangleView.widthAnchor.constraint(equalToConstant: kDefaultRectangleSize*ratio).isActive = true
        rectangleView.centerYAnchor.constraint(equalTo: descriptionText.centerYAnchor, constant: 5).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func SetData(post: TestPost) {
        let image:UIImage? = imageSave[post.imageURL]

        if (image == nil) {
            downloadImage(url: post.imageURL, profile: false)
        } else {
            self.imageView.setImage(image, for: .normal)
        }

        let pimage:UIImage? = imageSave[post.profileImageURL]

        if (pimage == nil) {
            downloadImage(url: post.profileImageURL, profile: true)
        } else {
            self.memberView.setImage(pimage, for: .normal)
        }

        addressText.text = post.addressText
        descriptionText.text = "$" + String(format:"%.0f", post.price) + " • " + String(format:"%.0f", post.numberBedrooms) + " Bed • " + String(format:"%.0f", post.numberBathrooms) + " Bath"
    }

    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }

    func downloadImage(url: URL, profile: Bool) {
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                if (profile) {
                    let image:UIImage = UIImage(data: data)!
                    self.imageSave[url] = image
                    self.memberView.setImage(image, for: .normal)
                } else {
                    let image:UIImage = UIImage(data: data)!
                    self.imageSave[url] = image
                    self.imageView.setImage(image, for: .normal)
                }
            }
        }
    }

}
