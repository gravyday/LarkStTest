//
//  ViewController.swift
//  LarkStTest
//
//  Created by dave on 6/17/18.
//  Copyright © 2018 dave. All rights reserved.
//

import UIKit

let kCellIdentifier:String = "theCellID"
let kCellInitialWidth:CGFloat = 336
let kCellInitialHeight:CGFloat = 470
let kCellInitialPadding:CGFloat = 20
let kCellInitialVerticalSpacing: CGFloat = 17

let kCellTopSpace:CGFloat = 96
let kHeaderSafeTopMargin:CGFloat = 20

let kHeaderInitialHeight:CGFloat = 50
let kHeaderInitialWidth:CGFloat = 375
let kHeaderImageTopSpace: CGFloat = 6
let kHeaderLeftImageLeadingSpace: CGFloat = 12
let kHeaderRightImageTrailingSpace: CGFloat = 16
let kHeaderRightImageSize: CGFloat = 32

let kHeaderLeftImageHeight: CGFloat = 32
let kHeaderLeftImageWidth: CGFloat = 34

let kHeaderInitialText:String = "Explore"
let kHeaderInitialFontSize:CGFloat = 25
let kHeaderInitialTextTopSpace:CGFloat = 5
let kHeaderInitialTextHeight:CGFloat = 21
let kHeaderInitialTextWidth:CGFloat = 84

struct imageDataStruct {
    let image:UIImage
//    var testdata:TestPost?
}

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var headerView: HeaderView!
    var collectionView: UICollectionView!

    var testposts : [TestPost] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        view.backgroundColor = .white

        SetupHeader()
        SetupScroller()

        testposts = TestPost.getTestFeed()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testposts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ScrollerCell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier, for: indexPath) as! ScrollerCell

        cell.SetData(post: testposts[indexPath.row])

        cell.backgroundColor = .clear

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = view.frame.width - kCellInitialPadding*2
        let h = kCellInitialHeight*w/kCellInitialWidth
        return CGSize(width: w, height: h)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return kCellInitialVerticalSpacing
    }

    @objc func leftButtonAction(sender: UIButton?) {
        print("Left Header Button Pressed")
    }

    @objc func rightButtonAction(sender: UIButton?) {
        print("Right Header Button Pressed")
    }

    private func SetupScroller() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: kCellTopSpace - kHeaderSafeTopMargin, left: 0, bottom: kCellTopSpace, right: 0)

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ScrollerCell.self, forCellWithReuseIdentifier: kCellIdentifier)
        collectionView.backgroundColor = .white
        self.view.addSubview(collectionView)
        self.view.sendSubview(toBack: collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: kHeaderSafeTopMargin).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true

        collectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
    }

    private func SetupHeader() {
        let w = view.frame.width
        let ratio = w/kHeaderInitialWidth

        headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: w, height: kHeaderInitialHeight*ratio))

        view.addSubview(headerView)

        headerView.heightAnchor.constraint(equalToConstant: kHeaderInitialHeight*ratio).isActive = true
        headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true

        headerView.backgroundColor = .white
        headerView.layer.shadowColor = UIColor.white.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0, height: 10.0)
        headerView.layer.shadowRadius = 5.0
        headerView.layer.shadowOpacity = 1.0
        headerView.layer.masksToBounds = false

        // gradient from white to clear on the header background
//        let gradient = CAGradientLayer()
//        gradient.frame = headerView.bounds
//        gradient.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]
//        gradient.locations = [0.5,0.7]
//        headerView.layer.insertSublayer(gradient, at: 0)

        // add text object
        let textObject = UITextView()
        textObject.text = kHeaderInitialText
        textObject.font = UIFont.systemFont(ofSize: kHeaderInitialFontSize, weight: UIFont.Weight(0.15))
        textObject.textAlignment = .center
        textObject.textColor = .black
        textObject.isScrollEnabled = false
        textObject.backgroundColor = .clear

        headerView.addSubview(textObject)

        // text object constraints
        textObject.translatesAutoresizingMaskIntoConstraints = false
        textObject.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        textObject.topAnchor.constraint(equalTo: headerView.topAnchor, constant: kHeaderInitialTextTopSpace*ratio).isActive = true
        textObject.heightAnchor.constraint(equalToConstant: kHeaderInitialTextHeight*ratio)
        textObject.widthAnchor.constraint(equalToConstant: kHeaderInitialTextWidth*ratio)

        // add left image object
        let leftImageObject = UIButton()
        leftImageObject.setImage( #imageLiteral(resourceName: "iconNavigationCreatePost"), for: .normal)
        leftImageObject.contentMode = .scaleAspectFit
        leftImageObject.addTarget(self, action: #selector(leftButtonAction(sender:)), for: .touchUpInside)

        headerView.addSubview(leftImageObject)

        // leftImageObject constraints
        leftImageObject.translatesAutoresizingMaskIntoConstraints = false
        leftImageObject.leftAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.leftAnchor, constant: kHeaderLeftImageLeadingSpace*ratio).isActive = true
        leftImageObject.centerYAnchor.constraint(equalTo: textObject.centerYAnchor).isActive = true

        // add right image object
        let rightImageObject = UIButton()
        rightImageObject.setImage( #imageLiteral(resourceName: "avatarUserpicJinYang"),for: .normal)
        rightImageObject.contentMode = .scaleAspectFit
        rightImageObject.addTarget(self, action: #selector(rightButtonAction(sender:)), for: .touchUpInside)

        rightImageObject.layer.cornerRadius = kHeaderRightImageSize*ratio/2
        rightImageObject.layer.masksToBounds = true

        headerView.addSubview(rightImageObject)

        // leftImageObject constraints
        rightImageObject.translatesAutoresizingMaskIntoConstraints = false
        rightImageObject.rightAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.rightAnchor, constant: -kHeaderRightImageTrailingSpace).isActive = true
        rightImageObject.centerYAnchor.constraint(equalTo: textObject.centerYAnchor).isActive = true
        rightImageObject.widthAnchor.constraint(equalToConstant: kHeaderRightImageSize*ratio).isActive = true
        rightImageObject.heightAnchor.constraint(equalToConstant: kHeaderRightImageSize*ratio).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

