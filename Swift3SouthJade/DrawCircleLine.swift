//
//  DrawCircleLine.swift
//  SwiftSouthJade
//
//  Created by 李 宇亮 on 16/10/19.
//  Copyright © 2016年 NightWatcher. All rights reserved.
//

import UIKit


class DrawCircleLine: UIView {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    
        drawArcAndLine()
    
    }
    
    func drawArcAndLine() {
        
        let pointX = frame.width/2
        let pointY = frame.height/2
        let bigRadious = pointX - pointX*2/12.8
        let smallRadious = pointX - pointX*2/3.5
        let degreesToRadians = CGFloat(M_PI)/180
        
        for i in 0..<6 {
            //MARK: draw big arc line
            let contextBig = UIGraphicsGetCurrentContext()!
            contextBig.saveGState()
            contextBig.addArc(center: CGPoint(x: pointX, y: pointY),
                              radius: bigRadious,
                          startAngle: (2+CGFloat(i)*60)*degreesToRadians,
                            endAngle: (58+CGFloat(i)*60)*degreesToRadians,
                           clockwise: false)
            contextBig.setStrokeColor(UIColor.lightGray.cgColor)
            contextBig.setLineWidth(1)
            contextBig.drawPath(using: .stroke)
            contextBig.restoreGState()
            
            //MARK: draw small arc line
            let contextSmall = UIGraphicsGetCurrentContext()!
            contextSmall.saveGState()
            contextSmall.addArc(center: CGPoint(x: pointX, y: pointY),
                                radius: smallRadious,
                            startAngle: (2+CGFloat(i)*60)*degreesToRadians,
                              endAngle: (58+CGFloat(i)*60)*degreesToRadians,
                             clockwise: false)
            contextSmall.setStrokeColor(UIColor.lightGray.cgColor)
            contextSmall.setLineWidth(1)
            contextSmall.drawPath(using: .stroke)
            contextSmall.restoreGState()
            
            let contextLine1 = UIGraphicsGetCurrentContext()!
            contextLine1.saveGState()
            let x11 = pointX + smallRadious * cos((2 + CGFloat(i) * 60) * degreesToRadians)
            let y11 = pointY + smallRadious * sin((2 + CGFloat(i) * 60) * degreesToRadians)
            contextLine1.move(to: CGPoint(x: x11, y: y11))
            let x12 = pointX + bigRadious * cos((2 + CGFloat(i) * 60) * degreesToRadians)
            let y12 = pointY + bigRadious * sin((2 + CGFloat(i) * 60) * degreesToRadians)
            contextLine1.addLine(to: CGPoint(x: x12, y: y12))
            contextLine1.setStrokeColor(UIColor.lightGray.cgColor)
            contextLine1.setLineWidth(1)
            contextLine1.drawPath(using: .stroke)
            contextLine1.restoreGState()

            let contextLine2 = UIGraphicsGetCurrentContext()!
            contextLine2.saveGState()
            let x21 = pointX + smallRadious * cos((58 + CGFloat(i) * 60) * degreesToRadians)
            let y21 = pointY + smallRadious * sin((58 + CGFloat(i) * 60) * degreesToRadians)
            contextLine2.move(to: CGPoint(x: x21, y: y21))
            let x22 = pointX + bigRadious * cos((58 + CGFloat(i) * 60) * degreesToRadians)
            let y22 = pointY + bigRadious * sin((58 + CGFloat(i) * 60) * degreesToRadians)
            contextLine2.addLine(to: CGPoint(x: x22, y: y22))
            contextLine2.setStrokeColor(UIColor.lightGray.cgColor)
            contextLine2.setLineWidth(1)
            contextLine2.drawPath(using: .stroke)
            contextLine2.restoreGState()

        }
    }
}
