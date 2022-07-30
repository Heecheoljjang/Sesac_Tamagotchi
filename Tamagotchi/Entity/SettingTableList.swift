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
        SettingList(leftImg: "pencil", listTitle: "내 이름 설정하기", detailLabel: ""),
        SettingList(leftImg: "moon.fill", listTitle: "다마고치 변경하기", detailLabel: ""),
        SettingList(leftImg: "arrow.clockwise", listTitle: "데이터 초기화", detailLabel: "")
    ]
}
