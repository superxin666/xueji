//
//  ScanViewController.swift
//  xueji
//
//  Created by lvxin on 2017/11/15.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit
import AVFoundation

class ScanViewController: BaseViewController,AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate {
    var  scanSession : AVCaptureSession!
    var scanPane : UIView!//扫描框
    var alertView : UIAlertView!//
    
    var bottomBackView :UIView!//底部背景栏
    var cancleBtn : UIButton!//取消
    var lightBtn : UIButton!//灯光
    var addBookBtn : UIButton!//手动添加
    

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.creatUI()
        self.creatScan()
    }
    //MARK: UI
    func creatUI(){

        let topView : UIView  = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: ip6(190)))
        topView.backgroundColor = .black
        topView.alpha = 0.5
        self.view.addSubview(topView)
        
        let leftView : UIView  = UIView(frame: CGRect(x: 0, y: topView.frame.maxY, width: ip6(35), height: KSCREEN_HEIGHT - ip6(58) - topView.frame.maxY))
        leftView.backgroundColor = .black
        leftView.alpha = 0.5
        self.view.addSubview(leftView)

        scanPane = UIView(frame: CGRect(x: leftView.frame.maxX, y: topView.frame.maxY, width: KSCREEN_WIDTH - ip6(70), height: ip6(250)))
        scanPane.backgroundColor = .white
        scanPane.alpha = 0.0
        self.view.addSubview(scanPane)
        
        
        let rightView : UIView  = UIView(frame: CGRect(x: scanPane.frame.maxX, y: topView.frame.maxY, width: ip6(35), height: KSCREEN_HEIGHT - ip6(58) - topView.frame.maxY))
        rightView.backgroundColor = .black
        rightView.alpha = 0.5
        self.view.addSubview(rightView)
        
        let bottomView : UIView  = UIView(frame: CGRect(x: leftView.frame.maxX, y: scanPane.frame.maxY, width: KSCREEN_WIDTH - ip6(70), height: KSCREEN_HEIGHT - ip6(58) - scanPane.frame.maxY))
        bottomView.backgroundColor = .black
        bottomView.alpha = 0.5
        bottomView.isUserInteractionEnabled = true
        self.view.addSubview(bottomView)
        
        
        addBookBtn = UIButton.getBtn_titleStyle(title_normal: "手动添加", title_selected: "", fream:  CGRect(x: (bottomView.frame.width - ip6(80))/2, y: ip6(18), width: ip6(80), height: ip6(22)), backgroundColor: .clear, textColor: .white, fontSize: 18, textAlignment: .center, selector: #selector(self.addBook_click), vc: self, tag: 0)
        bottomView.addSubview(addBookBtn)
        
        bottomBackView  = UIView(frame: CGRect(x: 0, y: KSCREEN_HEIGHT - ip6(58), width: KSCREEN_WIDTH, height: ip6(58)))
        bottomBackView.backgroundColor = .black
        bottomBackView.alpha = 0.7
        self.view.addSubview(bottomBackView)
        
        cancleBtn = UIButton.getBtn_titleStyle(title_normal: "取消", title_selected: "", fream: CGRect(x: ip6(15), y: ip6(18), width: ip6(60), height: ip6(22)), backgroundColor: .clear, textColor: .white, fontSize: 18, textAlignment: .left,selector : #selector(self.cancle_click),vc : self,tag: 0)
        bottomBackView.addSubview(cancleBtn)
        
        lightBtn = UIButton(frame: CGRect(x:KSCREEN_WIDTH -  ip6(30), y: ip6(18), width: ip6(15), height: ip6(18)))
        lightBtn.setImage(#imageLiteral(resourceName: "study_flashlight_fill"), for: .normal)
        lightBtn.addTarget(self, action: #selector(self.openLight_click(sender:)), for: .touchUpInside)
        bottomBackView.addSubview(lightBtn)
        
        
    }
    //MARK: 手动添加
    func addBook_click()  {
        XJLog(message: "手动添加")
        let vc : AddBookViewController = AddBookViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: 灯光
    func openLight_click(sender : UIButton) {
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        if device == nil {
            return
        }
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            //打开
            XJLog(message: "打开")
            if device?.torchMode == .on {
                
            } else {
                do {
                    try device?.lockForConfiguration()
                } catch {
                    return
                }
                device?.torchMode = .on
                device?.unlockForConfiguration()
            }
            
        } else {
            //关闭
            XJLog(message: "关闭")
            if device?.torchMode == .off {
                
            } else {
                do {
                    try device?.lockForConfiguration()
                } catch {
                    return
                }
                device?.torchMode = .off
                device?.unlockForConfiguration()
            }
            
        }
    }
    
    //MARK: 退出
    func cancle_click() {
        self.dismissVC()
    }
    func dismissVC() {
        self.dismiss(animated: true, completion: {
            let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            if device?.torchMode == .off {
                
            } else {
                do {
                    try device?.lockForConfiguration()
                } catch {
                    return
                }
                device?.torchMode = .off
                device?.unlockForConfiguration()
            }
        })
    }
     //MARK: 相机权限提醒
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        XJLog(message: "移除")
        self.dismissVC()
    }

    //MARK: 设置捕捉设备
    func creatScan() {
        
       
        if AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo.description) == .restricted || AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo.description) == .denied {
            XJLog(message: "没有权限")
            alertView = UIAlertView(title: nil, message: "设置--通用--学记--打开相机", delegate: self, cancelButtonTitle: "确定")
            alertView.delegate = self
            alertView.show()
            return
        }
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        do {
            //设置设备输入输出
            let input = try AVCaptureDeviceInput(device: device)
            let output = AVCaptureMetadataOutput()
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            
            //设置会话
            scanSession = AVCaptureSession()
            scanSession.canSetSessionPreset(AVCaptureSessionPresetHigh)
            
            if scanSession.canAddInput(input)
            {
                scanSession.addInput(input)
            }
            
            if scanSession.canAddOutput(output)
            {
                scanSession.addOutput(output)
            }
            //设置扫描类型(二维码和条形码)
            output.metadataObjectTypes = [
                AVMetadataObjectTypeQRCode,
                AVMetadataObjectTypeCode39Code,
                AVMetadataObjectTypeCode128Code,
                AVMetadataObjectTypeCode39Mod43Code,
                AVMetadataObjectTypeEAN13Code,
                AVMetadataObjectTypeEAN8Code,
                AVMetadataObjectTypeCode93Code,
            ]
            //预览图层
            let scanPreviewLayer = AVCaptureVideoPreviewLayer(session:scanSession)
            scanPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            scanPreviewLayer?.frame = view.layer.bounds
            
            view.layer.insertSublayer(scanPreviewLayer!, at: 0)

            //自动对焦
            if (device?.isFocusModeSupported(.autoFocus))!{
                do { try input.device.lockForConfiguration() } catch{ }
                input.device.focusMode = .autoFocus
                input.device.unlockForConfiguration()
            }
            let fream = CGRect(x: ip6(35), y: ip6(190), width: KSCREEN_WIDTH - ip6(70), height: ip6(250))
            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVCaptureInputPortFormatDescriptionDidChange, object: nil, queue: nil, using: {[weak self] (noti) in
                output.rectOfInterest = (scanPreviewLayer?.metadataOutputRectOfInterest(for: fream))!
            })
            
            if !scanSession.isRunning{
                scanSession.startRunning()
            }
        } catch {
            self.showErro(infoStr: "相机不可用")
            
        }
        
    }
    
    func captureOutput(_ output: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        self.scanSession!.stopRunning()
        XJLog(message: "扫描完成")
        //扫完完成
        if metadataObjects.count > 0{
            if let resultObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject{
                XJLog(message: resultObj.stringValue)
            }
        } else {
            XJLog(message: "扫描无结果")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
