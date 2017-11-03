//
//  String+fun.swift
//  学记
//
//  Created by lvxin on 2017/10/30.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit


extension String {
    
    /// 测文字的高度
    ///
    /// - parameter width: 宽度限制
    /// - parameter font:  字体
    ///
    /// - returns: 高度
    func xj_heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.height
    }
    
    
    func xj_widthWithConstrainedWidth(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width:  CGFloat.greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.width
    }
    
    
    //    由字符串获取label高度
    func xj_getLabHeight(font:UIFont,LabelWidth:CGFloat) -> CGFloat {
        let statusLabelText: NSString = self as NSString
        let size = CGSize(width:LabelWidth,height: 900)
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context: nil).size
        return strSize.height
    }
    
    //    由字符串获取label宽度
    func xj_getLabWidth(labelStr:String,font:UIFont,LabelHeight:CGFloat) -> CGFloat {
        let statusLabelText: NSString = labelStr as NSString
        let size = CGSize(width:900,height: LabelHeight)
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context: nil).size
        return strSize.width
    }
    
    // MARK: 公共部分
    /// 获取版本号
    ///
    /// - returns: 版本号
    func xj_getAppVersion() -> String  {
        let infoDict = Bundle.main.infoDictionary
        if let info = infoDict {
            let appVersion = info["CFBundleShortVersionString"] as! String!
            return ("ios" + appVersion!)
        } else {
            return ""
        }
    }
    
    
//    func getToken_RSA() -> String {
////        let token:String!  = LoginModelMapper.getToken()
//        //        KFBLog(message: "token   "+token)
//        //        let token_rsa = RSA.encryptString(token, publicKey: pubkey)
//        return token
//        //        return "eyJ0b2tlbiI6IjE0Zjk0ODU4MjI0YzQwMGZmMjQyNzY2MmY1ZjI0MTNjIiwic2VjcmV0IjoiN2FlMTcxY2NiM2M4NjIyN2E1ZGZkOGNiMTEzZDA0MmUifQ=="
//    }
    
    /// 判断是否为空字符串
    ///
    /// - parameter str: 字符串
    ///
    /// - returns: 是否
    
    static func xj_isStr(str : String) -> Bool {
        if str.characters.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    
    /// 判断是否是手机号
    ///
    /// - parameter phoneNum: 手机号
    ///
    /// - returns: 是或者不是
    static func xj_isMobileNumber(phoneNum : String) -> Bool {
        let predicateStr = "^((13[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$"
        let currObject = phoneNum
        let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
        return predicate.evaluate(with: currObject)
    }
    
    
    
    /// 时间格式转换
    ///
    /// - Parameters:
    ///   - dateStr: 时间字符串
    ///   - style: 样式选择
    /// - Returns: 转换后的时间字符串
    static func xj_getDate_style1(dateStr : String,style:Int) -> String {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        let date = dfmatter.date(from: dateStr)
        var  styleSty = ""
        switch style {
        case 0:
            styleSty = "MM.dd HH:mm"
        case 1:
            styleSty = "HH:mm"
        case 2:
            styleSty = "HH:mm"
        default:
            styleSty = "yyyy.MM.dd HH:mm"
        }
        
        let dfmatter2 = DateFormatter()
        dfmatter2.dateFormat = styleSty
        return dfmatter2.string(from: date!)
    }
    
}

