//
//  Filter.swift
//  Filterer
//
//  Created by steven lee on 29/6/16.
//  Copyright © 2016 UofT. All rights reserved.
//

import UIKit

public class Filter{
    var rgbaImage: RGBAImage?
    var width: Int = 0
    var height: Int = 0
    
    public init(image: UIImage){
        rgbaImage=RGBAImage(image: image)!
    }
    
    func changeColor(color: String, contrastValue: Float)
    {
        for y in 0..<height{
            for x in 0..<width{
                let index = y * width + x
                var pix: Pixel = (rgbaImage?.pixels[index])!
                var red: Float = 0
                var green: Float = 0
                var blue: Float = 0
                switch color{
                    case "red": red = Float(pix.red) * contrastValue
                    case "green": green = Float(pix.green) * contrastValue
                    case "blue": blue = Float(pix.blue) * contrastValue
                    case "yellow": red = Float(pix.red) * contrastValue
                                    green = Float(pix.green) * contrastValue
                    case "purple":red = Float(pix.red) * contrastValue
                        blue = Float(pix.blue) * contrastValue
                default: break
                }
                pix.red = UInt8(red)
                pix.green = UInt8(green)
                pix.blue = UInt8(blue)
                rgbaImage?.pixels[index] = pix;

                
                
            }
        }
    }
    
    public func applyFilter(color: String, contrastValue: Float)
    {
        width=(rgbaImage?.width)!
        height=(rgbaImage?.height)!
        changeColor(color, contrastValue: contrastValue)
        
        
    }
    
    public var image: UIImage?{
        return rgbaImage?.toUIImage()
    }
}
