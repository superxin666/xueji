//
//  ScanViewController.swift
//  xueji
//
//  Created by lvxin on 2017/11/15.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit
import AVFoundation

class ScanViewController: BaseViewController,AVCaptureMetadataOutputObjectsDelegate {
    var  scanSession : AVCaptureSession!
    var scanPane : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scanPane = UIView(frame: CGRect(x: ip6(30), y: ip6(200), width: KSCREEN_WIDTH - ip6(120), height: ip6(300)))
        scanPane.backgroundColor = .red
        scanPane.alpha = 0.3
        self.view.addSubview(scanPane)
        self.creatScan()
    }

    func creatScan() {
        //设置捕捉设备
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
//            if (device?.isFocusModeSupported(AVCaptureExposureModeContinuousAutoExposure))!{
//                do { try input.device.lockForConfiguration() } catch{ }
//                input.device.focusMode = .autoFocus
//                input.device.unlockForConfiguration()
//            }
            //设置扫描区域

            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVCaptureInputPortFormatDescriptionDidChange, object: nil, queue: nil, using: {[weak self] (noti) in
                output.rectOfInterest = (scanPreviewLayer?.metadataOutputRectOfInterest(for: (self?.scanPane.frame)!))!
            })
    
            if !scanSession.isRunning
            {
                scanSession.startRunning()
            }
            
        } catch {
            self.showErro(infoStr: "相机不可用")
            
        }
        
    }
    
    func captureOutput(_ output: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        self.scanSession!.stopRunning()
        //扫完完成
        if metadataObjects.count > 0{
            if let resultObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject{
                XJLog(message: resultObj.stringValue)
            }
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
