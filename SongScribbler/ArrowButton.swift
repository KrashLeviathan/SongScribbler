//
//  ArrowButton.swift
//  SongScribbler
//
//  Created by Charlie Steenhagen on 4/12/15.
//  Copyright (c) 2015 Krash Leviathan. All rights reserved.
//

import UIKit

@IBDesignable
class ArrowButton: UIButton {
    
    @IBInspectable var fillColor: UIColor = UIColor.blueColor()
    @IBInspectable var strokeOuterColor: UIColor = UIColor.blackColor()
    @IBInspectable var strokeInnerColor: UIColor = UIColor.darkGrayColor()
    @IBInspectable var isFlipped: Bool = false
    
    override func drawRect(rect: CGRect) {
        
        //create the path
        var trianglePath = UIBezierPath()
        trianglePath.lineWidth = 2.0
        trianglePath.lineCapStyle = kCGLineCapRound
        var inset = trianglePath.lineWidth/2 + 0.5
        
        if !isFlipped {
            //   Forward Arrow
            //move the initial point of the path
            trianglePath.moveToPoint(CGPoint(
                x:inset,
                y:inset))
            //add points to the path
            trianglePath.addLineToPoint(CGPoint(
                x:inset,
                y:bounds.height - inset))
            trianglePath.addLineToPoint(CGPoint(
                x:bounds.width - inset,
                y:bounds.height/2))
            trianglePath.addLineToPoint(CGPoint(
                x:inset,
                y:inset))
        } else {
            //   Backward Arrow
            //move the initial point of the path
            trianglePath.moveToPoint(CGPoint(
                x:bounds.width - inset,
                y:inset))
            //add points to the path
            trianglePath.addLineToPoint(CGPoint(
                x:bounds.width - inset,
                y:bounds.height - inset))
            trianglePath.addLineToPoint(CGPoint(
                x:inset,
                y:bounds.height/2))
            trianglePath.addLineToPoint(CGPoint(
                x:bounds.width - inset,
                y:inset))
        }
        
        //set the stroke and fill colors
        strokeOuterColor.setStroke()
        fillColor.setFill()
        
        //draw the stroke
        trianglePath.fill()
        trianglePath.stroke()
        
        //draw inner stroke
        trianglePath.lineWidth = 1.0
        inset = trianglePath.lineWidth/2 + 10.5
        
        if !isFlipped {
            //   Forward Arrow
            //move the initial point of the path
            trianglePath.moveToPoint(CGPoint(
                x:inset,
                y:inset))
            //add points to the path
            trianglePath.addLineToPoint(CGPoint(
                x:inset,
                y:bounds.height - inset))
            trianglePath.addLineToPoint(CGPoint(
                x:bounds.width - inset,
                y:bounds.height/2 + 0.5))
            trianglePath.addLineToPoint(CGPoint(
                x:inset,
                y:inset))
        } else {
            //   Backward Arrow
            //move the initial point of the path
            trianglePath.moveToPoint(CGPoint(
                x:bounds.width - inset,
                y:inset))
            //add points to the path
            trianglePath.addLineToPoint(CGPoint(
                x:bounds.width - inset,
                y:bounds.height - inset))
            trianglePath.addLineToPoint(CGPoint(
                x:inset,
                y:bounds.height/2 + 0.5))
            trianglePath.addLineToPoint(CGPoint(
                x:bounds.width - inset,
                y:inset))
        }
        
        //draw the stroke
        strokeInnerColor.setStroke()
        trianglePath.stroke()
        
    }
    
}