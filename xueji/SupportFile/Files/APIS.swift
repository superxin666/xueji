//
//  APIS.swift
//  学记
//
//  Created by lvxin on 2017/8/30.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import Foundation
let base_api = "http://47.52.101.29/app1"
//---------------------------------用户
let login_user_api = "/user/login?"

//---------------------------------category

/// 分类列表
let category_list_api = "/category/list?"
/// 添加分类
let category_add_api = "/category/add?"
/// 插入&更新书籍
let category_upd_book_api = "/category/upd_book?"

//---------------------------------book
/// isbn添加
let book_add_book_api = "/book/add_book?"

/// 自定义添加
let book_add_custom_api = "/book/add_custom?"
/// 详情
let book_detail_api = "/book/detail?"