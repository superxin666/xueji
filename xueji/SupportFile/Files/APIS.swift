//
//  APIS.swift
//  学记
//
//  Created by lvxin on 2017/8/30.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import Foundation
let base_api = "http://47.52.101.29/app1"
let base_image_api = "http://47.52.101.29"

let upload_api = "/upload/index?"

let UMENGKEY = "5b4c4c468f4a9d0e7b00016c"


//---------------------------------用户
let login_user_api = "/user/login?"
let logout_user_api = "/user/logout?"
let user_data_api = "/main/my?"
let week_report_api = "/report/week_report?"
let learn_week_goal_api = "/learn/week_goal?"
let learn_log_api = "/learn/log?"
let get_sms_code_api = "/user/get_sms_code?"
let sign_up_api = "/user/sign_up?"
let modify_profile_api = "/user/modify_profile?"
let reset_password_api = "/user/reset_password?"
let my_detail_api = "/main/my_detail?"

//---------------------------------首页
let main_index_api = "/main/index?"
//---------------------------------复习
let review_range_api = "/review/range?"
let review_done_api = "/review/done?"
//---------------------------------category

/// 分类列表
let category_list_api = "/category/list?"
/// 添加分类
let category_add_api = "/category/add?"
/// 插入&更新书籍
let category_upd_book_api = "/category/upd_book?"

//---------------------------------book
/// isbn添加
let book_add_book_api = "/book/add?"
/// 自定义添加
let book_add_custom_api = "/book/add_custom?"
/// 详情
let book_detail_api = "/book/detail?"
/// 书籍详情 包括分类等信息
let book_my_detail_api = "/book/my_detail?"
/// 删除书籍
let book_remove_api = "/book/remove?"
