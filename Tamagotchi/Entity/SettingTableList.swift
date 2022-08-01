//
//  SettingTableList.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/22.
//

import UIKit

struct SettingList {
    var leftImg: String
    var listTitle: String
    var detailLabel: String
}

struct SettingLists {
    var settingLists: [SettingList] = [
        SettingList(leftImg: ImageName.pencil, listTitle: "내 이름 설정하기", detailLabel: ""),
        SettingList(leftImg: ImageName.moon, listTitle: "다마고치 변경하기", detailLabel: ""),
        SettingList(leftImg: ImageName.arrow, listTitle: "데이터 초기화", detailLabel: "")
    ]
}
