//
//  TestPost.swift
//
//  Created by Garrett Clyde on 6/1/18.
//  Copyright © 2018 Lark St. All rights reserved.
//

import Foundation
import UIKit

struct TestPost {
    let testPostId: UUID
    let imageURL: URL
    let profileImageURL: URL
    let addressText: String
    let isRental: Bool
    let numberBedrooms: Double
    let numberBathrooms: Double
    let price: Double
    let city: String
    
    init?(_ imageUrlString: String, _ profileImageUrlString: String, addressText: String, isRental: Bool, numberBedrooms: Double, numberBathrooms: Double, price: Double, city: String) {
        guard let imageURL = URL(string: imageUrlString),
            let profileImageURL = URL(string: profileImageUrlString)
            else { return nil }
        
        self.testPostId = UUID()
        self.imageURL = imageURL
        self.profileImageURL = profileImageURL
        self.addressText = addressText
        self.isRental = isRental
        self.numberBedrooms = numberBedrooms
        self.numberBathrooms = numberBathrooms
        self.price = price
        self.city = city
    }
}

extension TestPost {
    /**
     Simulates a feed data source
     */
    static func getTestFeed() -> [TestPost] {
        return [
            TestPost("https://ui-test.larkst.io/NelsonAve-Outside.png",
                     "https://ui-test.larkst.io/Monica.png",
                     addressText: "56040 Nelson Ave",
                     isRental: false,
                     numberBedrooms: 2,
                     numberBathrooms: 2,
                     price: 674000,
                     city: "Yucca Valley"),
            TestPost("https://ui-test.larkst.io/NelsonAve-Inside.png",
                     "https://ui-test.larkst.io/Monica.png",
                     addressText: "56040 Nelson Ave",
                     isRental: false,
                     numberBedrooms: 2,
                     numberBathrooms: 2,
                     price: 674000,
                     city: "Yucca Valley"),
            TestPost("https://ui-test.larkst.io/StHeilers.png",
                     "https://ui-test.larkst.io/JinYang.png",
                     addressText: "71C St Heliers Bay Rd",
                     isRental: true,
                     numberBedrooms: 5,
                     numberBathrooms: 3.5,
                     price: 4500,
                     city: "Auckland"),
            TestPost("https://ui-test.larkst.io/SwallowDrive.png",
                     "https://ui-test.larkst.io/Monica.png",
                     addressText: "9233 Swallow Drive",
                     isRental: false,
                     numberBedrooms: 5,
                     numberBathrooms: 8,
                     price: 11550000,
                     city: "Los Angeles"),
            TestPost("https://ui-test.larkst.io/BlackDiamondWay.png",
                     "https://ui-test.larkst.io/Monica.png",
                     addressText: "5120 Black Diamond Way",
                     isRental: true,
                     numberBedrooms: 8,
                     numberBathrooms: 3,
                     price: 6200,
                     city: "Tahoe")
            ].flatMap { $0 }
        
    }//END func getTestFeed()
}
