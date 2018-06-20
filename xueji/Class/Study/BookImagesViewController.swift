//
//  BookImagesViewController.swift
//  xueji
//
//  Created by lvxin on 2017/11/23.
//  Copyright © 2017年 lvxin. All rights reserved.
//  书的封皮

import UIKit

class BookImagesViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var colletionView : UICollectionView!//图片浏览
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigation_title_fontsize(name: "系统封面", fontsize: 20)
        self.navigationBar_rightBtn_title(title: "确定")
        self.navigationBar_leftBtn_title(title: "取消")
        self.creatUI()
    }
    // MARK: - UI
    func creatUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = ip6(23)
        layout.minimumLineSpacing = ip6(23)
        //        layout.sectionInset = UIEdgeInsetsMake(0, ip6(10), 0, ip6(10))
        colletionView = UICollectionView(frame: CGRect(x: ip6(20), y: ip6(10), width: KSCREEN_WIDTH - ip6(40), height: KSCREEN_HEIGHT - ip6(10)), collectionViewLayout: layout)
        colletionView.register(HeadBookCollectionViewCell.self, forCellWithReuseIdentifier: "HeadBookCollectionViewCell_id")
        colletionView.backgroundColor = .clear
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.showsVerticalScrollIndicator = false
        colletionView.contentSize = CGSize(width: itemWidth, height: KSCREEN_HEIGHT - LNAVIGATION_HEIGHT - ip6(10))
        self.view.addSubview(colletionView)
    }
    
    // MARK: - UICollectionViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        if indexPath.row < imageArr.count {
        let cell :HeadBookCollectionViewCell  = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadBookCollectionViewCell_id", for: indexPath) as! HeadBookCollectionViewCell
        //            var nameStr : String = ""
        //            var picStr :String = ""
        
        //            cell.setUI(image: imageArr[indexPath.row], name: "")
        return cell
        //        } else {
        //            return UIView() as! UICollectionViewCell
        //        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
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
