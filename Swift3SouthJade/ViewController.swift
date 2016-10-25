//
//  ViewController.swift
//  Swift3SouthJade
//
//  Created by 李 宇亮 on 2016/10/25.
//  Copyright © 2016年 NightWatcher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var bgImageView: UIImageView!
    
    let degreesToRadians = M_PI/180
    
    var updateEnable = false
    var angleBig = 0.0
    var centerPoint = CGPoint(x: 0, y: 0)
    var lastPointAngle: CGFloat = 0
    
    func setRotate(degree: Double) {
        
        //         180 / M_PI * Double(angle)
        let rotate = degree * degreesToRadians
        var transform = bgImageView.transform
        transform = transform.rotated(by: CGFloat(rotate))
        bgImageView.transform = transform
        
    }
    
    func update() {
        
        
        if updateEnable {
            
            
            if fabs(angleBig) > 1 {
                
                setRotate(degree: angleBig)
                angleBig = 0.935 * angleBig
            } else {
                angleBig = 0
            }
        }
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        angleBig = 0.0
        updateEnable = false
        bgImageView.isUserInteractionEnabled = false
        let touch = touches.first///////////////////////////////
        let point = touch?.location(in: view)
        
        let lastPointRadious = sqrt(pow((point?.y)!-centerPoint.y, 2) + pow((point?.x)!-centerPoint.x, 2))
        
        if lastPointRadious == 0 {
            return
        }
        
        lastPointAngle = acos(((point?.x)!-centerPoint.x)/lastPointRadious)
        if (point?.y)! > centerPoint.y {
            lastPointAngle = 2 * CGFloat(M_PI) - lastPointAngle
        }

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        angleBig = 0.0
        updateEnable = false
        bgImageView.isUserInteractionEnabled = false
        let touch = touches.first
        let currentPoint = touch?.location(in: view)
        
        let currentPointRadius = sqrt(pow((currentPoint?.y)! - centerPoint.y, 2) + pow((currentPoint?.x)! - centerPoint.x, 2))
        
        if currentPointRadius == 0 {
            return
        }
        
        var currentPointAngle = acos(((currentPoint?.x)! - centerPoint.x)/currentPointRadius)
        if (currentPoint?.y)! > centerPoint.y {
            currentPointAngle = 2 * CGFloat(M_PI) - currentPointAngle
        }
        
        let angle = lastPointAngle - currentPointAngle
        
        angleBig = 180 / M_PI * Double(angle)
        
        bgImageView.transform = bgImageView.transform.rotated(by: angle)
        
        lastPointAngle = currentPointAngle
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateEnable = true
        bgImageView.isUserInteractionEnabled = true
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTopBarTitleView()
        
        //MARK:add background landscape image
        let backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight-49))
        backgroundImageView.image = UIImage(named: "大背景.png")
        view.addSubview(backgroundImageView)
        
        //MARK: add circle background image
        let circleImageView = UIImageView()
        circleImageView.center = CGPoint(x: screenWidth/2, y: screenHeight/2)
        circleImageView.bounds = CGRect(x: 0, y: 0, width: screenWidth-20, height: screenWidth-20)
        circleImageView.image = UIImage(named: "圆盘.png")
        view.addSubview(circleImageView)
        
        //MARK: draw circle (contain arc and line)
        let circleView = DrawCircleLine()
        circleView.backgroundColor = .clear
        circleView.center = CGPoint(x: screenWidth*0.5, y: screenHeight*0.5)
        circleView.bounds = CGRect(x: 0, y: 0, width: screenWidth-20, height: screenWidth-20)
        //        view.addSubview(circleView)
        UIGraphicsBeginImageContext(circleView.bounds.size)
        circleView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let circleViewconvertToImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        bgImageView = UIImageView()
        bgImageView.center = CGPoint(x: screenWidth/2, y: screenHeight/2)
        bgImageView.bounds = circleView.bounds
        bgImageView.isUserInteractionEnabled = true
        bgImageView.image = circleViewconvertToImage
        
        let nameArray = ["南玉", "品牌", "店铺", "鉴赏", "大师", "活动"]
        
        for(index, titleName) in nameArray.enumerated() {
            let btn = UIButton(type: .custom)
            //            btn.backgroundColor = .redColor()
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            //            let btnX = 0
            //            let btnY = 0
            if screenWidth > 400 {// screen width 414
                let btnW: CGFloat = 80
                let btnH: CGFloat = 170
                btn.frame = CGRect(x: 0, y: 0, width: btnW, height: btnH)
//                btn.imageEdgeInsets = UIEdgeInsets(top: 20, left: 25, bottom: 120, right: 25)
                btn.imageEdgeInsets = UIEdgeInsetsMake(20, 25, 120, 25)
                btn.titleEdgeInsets = UIEdgeInsetsMake(-50, -80, 0, 0)
                
            } else if screenWidth > 350 { // screen widt 375
                let btnW: CGFloat = 60
                let btnH: CGFloat = 170-20
                btn.frame = CGRect(x: 0, y: 0, width: btnW, height: btnH)
                btn.imageEdgeInsets = UIEdgeInsetsMake(10, 15, 110, 15)
                btn.titleEdgeInsets = UIEdgeInsetsMake(-50, -80, 0, 0)
            } else { // screen width 320
                let btnW: CGFloat = 60
                let btnH: CGFloat = 170-50
                btn.frame = CGRect(x: 0, y: 0, width: btnW, height: btnH)
                btn.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 90, 15)
                btn.titleEdgeInsets = UIEdgeInsetsMake(-35, -80, 0, 0)
            }
            
            btn.tag = 100 + index
            btn.addTarget(self, action: #selector(addClick), for: .touchUpInside)
            btn.setTitle(titleName, for: .normal)
            btn.setImage(UIImage(named: titleName), for: .normal)
            btn.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
            
            btn.layer.position = CGPoint(x: (screenWidth - 20)/2, y: (screenWidth - 20)/2);
            let angle = CGFloat(index) * (CGFloat(M_PI) * 2 / 6)
            btn.transform = CGAffineTransform(rotationAngle: angle)
            bgImageView.addSubview(btn)
        }
        view.addSubview(bgImageView)
        
        let runloop = RunLoop.current
        let timer = Timer(timeInterval: 1.0/60, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        timer.fire()
        runloop.add(timer, forMode: .commonModes)
        
        
        let centerX = screenWidth * 0.5
        let centerY = screenHeight * 0.5
        centerPoint = CGPoint(x: centerX, y: centerY)
        
        
        let centerButton = UIButton(type: .custom)
        centerButton.center = centerPoint
        centerButton.bounds = CGRect(x: 0, y: 0, width: screenWidth*90/320, height: screenWidth*90/320)
        
        //        centerButton.backgroundColor = .redColor()
        centerButton.setImage(UIImage(named: "logo"), for: .normal)
        centerButton.addTarget(self, action: #selector(centerButtonClick), for: .touchUpInside)
        
        let centerBgView = UIView()
        centerBgView.center = centerPoint
        centerBgView.bounds = CGRect(x: 0, y: 0, width: centerButton.bounds.size.width+10, height: centerButton.bounds.size.width+10)
        centerBgView.layer.cornerRadius = (centerButton.bounds.size.width+10)/2
        centerBgView.backgroundColor = .white
        view.addSubview(centerBgView)
        
        view.addSubview(centerButton)
        
        
    }
    
    func addClick(sender: UIButton) {
        
    }
    
    
    
    func setupTopBarTitleView() {
        let barTitleView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
        let imageView = UIImageView()
        imageView.frame = barTitleView.frame
        imageView.image = UIImage(named: "标题.png")
        barTitleView.addSubview(imageView)
        navigationItem.titleView = barTitleView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "titleViewBG"), for: .default)
        
    }
    
    func centerButtonClick() {
        UIView.animate(withDuration: 0.5) {
            self.bgImageView.transform = CGAffineTransform(rotationAngle: CGFloat(self.angleBig * M_PI/180))
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

