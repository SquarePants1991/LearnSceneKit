//
// Created by yang wang on 2017/12/13.
// Copyright (c) 2017 yang wang. All rights reserved.
//

import UIKit
import CoreGraphics

class NumberImageGenerator {
    class func createImage(number: Int, foregroundColor: UIColor, backgroundColor: UIColor, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        if let context = UIGraphicsGetCurrentContext() {

            context.setFillColor(backgroundColor.cgColor)
            context.fill(CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
            let numberAttrs: [NSAttributedStringKey: Any?] = [
                .font: UIFont.systemFont(ofSize: 80),
                .foregroundColor: foregroundColor,
            ]
            let numberAttrString = NSAttributedString.init(string: String(number), attributes: numberAttrs)
            let boundRect = numberAttrString.boundingRect(with: size, context: nil)
            let drawOffset: CGPoint = CGPoint.init(x: (size.width - boundRect.size.width) / 2 , y: (size.height - boundRect.size.height
            ) / 2)
            numberAttrString.draw(at: drawOffset)

            if let cgImage = context.makeImage() {
                return UIImage.init(cgImage: cgImage)
            }
        }
        UIGraphicsEndImageContext()
        return nil
    }
}