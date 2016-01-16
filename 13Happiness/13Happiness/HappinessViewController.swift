//
//  HappinessViewController.swift
//  13Happiness
//
//  Created by zhanghl on 16/1/14.
//  Copyright © 2016年 zhanghl. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController , FaceViewDataSource
{
    private struct Constants{
        static let HappinessGestureScale:CGFloat = 4
    }
    
    @IBAction func changeHappiness(sender: UIPanGestureRecognizer) {
        switch sender.state{
        case .Ended: fallthrough
        case .Changed:
            let translation = sender.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                sender.setTranslation(CGPointZero, inView: faceView)
            }
        default :break;
        }
    }
    
    @IBOutlet weak var faceView: FaceUIView! {
        didSet{
            faceView.dataSouce = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView,action: "scale:"))
//            faceView.addGestureRecognizer(UIPanGestureRecognizer(target: faceView, action: "changeHappiness:"))
        }

    }
    var happiness: Int = 80 {
        didSet{
            happiness = min(max(happiness, 0),100)
            print("happiness = \(happiness)")
            updateUI()
        }
    }
    func updateUI(){
        faceView.setNeedsDisplay()
    }
    
    func smilenessForFaceView(sender: FaceUIView) -> Double? {
        return Double(happiness-50) / 50
    }
}
