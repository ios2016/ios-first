//
//  FaceUIView.swift
//  13Happiness
//
//  Created by zhanghl on 16/1/14.
//  Copyright © 2016年 zhanghl. All rights reserved.
//

import UIKit

protocol FaceViewDataSource : class {
    func smilenessForFaceView(sender: FaceUIView) -> Double?
}

@IBDesignable
class FaceUIView: UIView {
    
    weak var dataSouce : FaceViewDataSource?
    
    
    @IBInspectable
    var lineWidth :CGFloat = 3{
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var scale :CGFloat=0.90 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var color :UIColor = UIColor.blueColor(){
        didSet{
            setNeedsDisplay()
        }
    }
    
    var faceCenter:CGPoint{
        return convertPoint(center,fromView: superview)
    }
    
    var faceRadius:CGFloat{
        return min(bounds.size.height,bounds.size.width)/2 * scale
    }
    
    func scale(gesture: UIPinchGestureRecognizer ){
        if gesture.state == .Changed{
            scale *= gesture.scale
            gesture.scale = 1
        }
    }
    
    private struct Scaling{
        static let FaceRadiusToEyeRadiusRatio:CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio:CGFloat = 3
        static let FaceRadiusToEyeSeparationRatio:CGFloat = 1.5
        static let FaceRadiusToMouthWidthRatio:CGFloat = 1
        static let FaceRadiusToMouthHeighRatio:CGFloat = 3
        static let FaceRadiusToMouthOffsetRatio:CGFloat = 3

    }

    private enum Eye{
        case Left,Right
    }
    
    private func bezierPathToEye(whichEye:Eye) -> UIBezierPath{
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        let eyeHorizontalSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparationRatio
        
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticalOffset
        switch whichEye{
        case .Left: eyeCenter.x -= eyeHorizontalSeparation / 2
        case .Right: eyeCenter.x += eyeHorizontalSeparation / 2
        }
        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: CGFloat(0), endAngle: CGFloat(2*M_PI), clockwise: true)
        path.lineWidth = lineWidth
        return path
    }
    
    private func bezierPathForSmile(fractionOfMaxSmile:Double) -> UIBezierPath
    {
        let mouthWidth = faceRadius / Scaling.FaceRadiusToMouthWidthRatio
        let mouthHeigh = faceRadius / Scaling.FaceRadiusToMouthHeighRatio
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToMouthOffsetRatio
        
        let smileHeght = CGFloat(max(min(fractionOfMaxSmile, 1), -1)) * mouthHeigh
        
        let start  = CGPoint(x: faceCenter.x - mouthWidth / 2,y: faceCenter.y + mouthVerticalOffset)
        let end = CGPoint(x: start.x + mouthWidth,y:start.y)
        
        let cp1 = CGPoint(x: start.x + mouthWidth / 3,y:start.y + smileHeght)
        let cp2 = CGPoint(x:end.x - mouthWidth / 3,y:cp1.y)
        
        let path = UIBezierPath()
        
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        
        path.lineWidth = lineWidth
        
        return path
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.*/
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise:true)
        facePath.lineWidth = lineWidth
        color.set()
        facePath.stroke()
        
        bezierPathToEye(.Right).stroke()
        bezierPathToEye(.Left).stroke()
        
        
        
      //let result2 = dataSouce?.smilenessForFaceView(self) ?? 0.0
        
        let smiliness = dataSouce?.smilenessForFaceView(self) ?? 0.0
        bezierPathForSmile(smiliness).stroke()
        
    }


}
