//
//  DrawView.swift
//  iOSDocuments
//
//  Created by Charlie Steenhagen on 4/11/15.
//  Copyright (c) 2015 Krash Leviathan. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    var lines: [Line] = []
    var currentMeasureIndex: Int = 0 {
        didSet {
            // Save all prior lines in the lines array to the previous measure
            var barCount = barLocations.count
            var measureLength = 0
            if (barCount > 1) {
                measureLength = barLocations[barCount-1] - barLocations[barCount-2]
            } else {
                measureLength = barLocations[0]
            }
            //            for line in lines {
            //                line.start.x += CGFloat(scrollOffset)
            //                line.end.x += CGFloat(scrollOffset)
            //            }
            var newMeasure = Measure(lines: lines, length: measureLength)
            measures.append(newMeasure)
            
            // Clear the lines array
            lines = []
        }
    }
    
    var measures: [Measure] = []
    
    var lastPoint: CGPoint!
    var drawColor = UIColor.blackColor()
    var rightMostPoint = CGFloat(0.0)
    var scrollOffset: Float = 0
    var barLocations: [Int] = []
    
    var leftCutoff: Float {
        get {
            return scrollOffset - 30
        }
    }
    var rightCutoff: Float {
        get {
            return scrollOffset + Float(self.frame.width) + 30
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Touch Actions
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        lastPoint = touches.anyObject()?.locationInView(self)
        lastPoint.x += CGFloat(scrollOffset)
        rightMostPoint = max(lastPoint.x, rightMostPoint)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var newPoint = touches.anyObject()?.locationInView(self)
        newPoint?.x += CGFloat(scrollOffset)
        lines.append(Line(start: lastPoint, end: newPoint!))
        lastPoint = newPoint
        rightMostPoint = max(lastPoint.x, rightMostPoint)
        
        self.setNeedsDisplay()
    }
    
    func scroll(speed: Int) {
        scrollOffset += Float(speed)
        setNeedsDisplay()
    }
    
    
    // MARK: - Drawing Operations
    
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        
        CGContextBeginPath(context)
        CGContextSetLineCap(context, kCGLineCapRound)
        CGContextSetStrokeColorWithColor(context, drawColor.CGColor)
        CGContextSetLineWidth(context, 5)
        self.drawStaff(context: context)
        self.drawBars(context: context, distancesFromLeftSide: barLocations)
        for line in lines {
            CGContextMoveToPoint(context, (line.start.x - CGFloat(scrollOffset)), line.start.y)
            CGContextAddLineToPoint(context, (line.end.x - CGFloat(scrollOffset)), line.end.y)
        }
        
        // Adjust the number '7' in the following line to have it draw more or less past measures
        let measuresToDraw = min(measures.count, 7)
        let startIndex = measures.count - measuresToDraw
        if (measuresToDraw != 0) {
            for m in startIndex...measures.count-1 {
                for line in measures[m].lines {
                    CGContextMoveToPoint(context, (line.start.x - CGFloat(scrollOffset)), line.start.y)
                    CGContextAddLineToPoint(context, (line.end.x - CGFloat(scrollOffset)), line.end.y)
                }
            }
        }
        CGContextStrokePath(context)
    }
    
    func drawStaff(context _context: CGContext) {
        for i in 0...4 {
            var distance: CGFloat = (self.frame.height / CGFloat(2.0)) + (CGFloat(35*(i-2)))
            CGContextMoveToPoint(_context, 0, distance)
            CGContextAddLineToPoint(_context, self.frame.width, distance)
        }
    }
    
    func drawBars(context _context: CGContext, distancesFromLeftSide: [Int]) {
        var topY: CGFloat = (self.frame.height / CGFloat(2.0)) - (CGFloat(70.0))
        var bottomY: CGFloat = (self.frame.height / CGFloat(2.0)) + (CGFloat(70.0))
        // Draw the initial bar
        CGContextMoveToPoint(_context, CGFloat(2.5 - scrollOffset), topY)
        CGContextAddLineToPoint(_context, CGFloat(2.5 - scrollOffset), bottomY)
        
        // Draw the rest of the bars
        for barPosition in distancesFromLeftSide {
            CGContextMoveToPoint(_context, CGFloat(barPosition) - CGFloat(scrollOffset), topY)
            CGContextAddLineToPoint(_context, CGFloat(barPosition) - CGFloat(scrollOffset), bottomY)
        }
    }
    
}
