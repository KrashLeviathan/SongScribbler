//
//  MeasureButton.swift
//  SongScribbler
//
//  Created by Charlie Steenhagen on 4/12/15.
//  Copyright (c) 2015 Krash Leviathan. All rights reserved.
//

import UIKit

@IBDesignable
class MeasureButton: UIButton {
    
    @IBInspectable var fillColor: UIColor = UIColor.clearColor()
    @IBInspectable var strokeColor: UIColor = UIColor.blackColor()
    
    override func drawRect(rect: CGRect) {
        
        //create the path
        var path = UIBezierPath()
        path.lineWidth = 2.0
        path.lineCapStyle = kCGLineCapSquare
        var inset = path.lineWidth/2 + 0.5
        
        //move the initial point of the path
        path.moveToPoint(CGPoint(
            x:inset,
            y:inset))
        //draw the boundary
        path.addLineToPoint(CGPoint(
            x:inset,
            y:bounds.height - inset))
        path.addLineToPoint(CGPoint(
            x:bounds.width - inset,
            y:bounds.height - inset))
        path.addLineToPoint(CGPoint(
            x:bounds.width - inset,
            y:inset))
        path.addLineToPoint(CGPoint(
            x:inset,
            y:inset))
        //draw inner lines
        path.moveToPoint(CGPoint(
            x:inset,
            y:bounds.height/2 + 0.5))
        path.addLineToPoint(CGPoint(
            x:bounds.width - inset,
            y:bounds.height/2 + 0.5))
        
        path.moveToPoint(CGPoint(
            x:inset,
            y:bounds.height/4 + 0.5))
        path.addLineToPoint(CGPoint(
            x:bounds.width - inset,
            y:bounds.height/4 + 0.5))
        
        path.moveToPoint(CGPoint(
            x:inset,
            y:bounds.height*3/4 + 0.5))
        path.addLineToPoint(CGPoint(
            x:bounds.width - inset,
            y:bounds.height*3/4 + 0.5))
        
        //set the stroke and fill colors
        strokeColor.setStroke()
        fillColor.setFill()
        
        //draw the stroke
        path.fill()
        path.stroke()
        
    }
    
}