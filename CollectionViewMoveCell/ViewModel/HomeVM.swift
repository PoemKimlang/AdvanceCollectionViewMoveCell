//
//  HomeVM.swift
//  CollectionViewMoveCell
//
//  Created by kimlang on 9/4/23.
//

import Foundation

class HomeVM {
    
    var cells       = [HomeData]()
    
    func initData(){
        cells.append(HomeData(rowType: .HEADER, header: [
            HomeData.Header(amount: "1099,99 $", name: "Poem Kimlang", hideAmount: false, color: "#F7F7F7")
        ]))
        
        cells.append(HomeData(rowType: .ACCOUNT, account: [
            HomeData.Account(title: "Accounts", icon: "E-cash"),
            HomeData.Account(title: "Cards", icon: "card"),
            HomeData.Account(title: "Deposits", icon: "piggy-bank"),
            HomeData.Account(title: "Loans", icon: "file-text-edit"),
            HomeData.Account(title: "Cash-code", icon: "lock"),
            HomeData.Account(title: "Transfers", icon: "transaction"),
            HomeData.Account(title: "To other banks", icon: "tree"),
            HomeData.Account(title: "Top-up", icon: "smartphone"),
            HomeData.Account(title: "Payments", icon: "usd")
        ]))
        
        cells.append(HomeData(rowType: .QUICK_PAYMENT, quick_paymnet: [
            HomeData.QuickPayment(background: "background", title: "Quick Payment", icon: "usd"),
            HomeData.QuickPayment(background: "bg_gray", title: "Quick Transfer", icon: "transaction")
        ]))
    }
}
