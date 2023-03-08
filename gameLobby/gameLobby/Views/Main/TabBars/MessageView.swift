//
//  MessageView.swift
//  gameLobby
//
//  消息通知页面

//  Created by Frederick Mo on 2022/5/19.
//

import SwiftUI

struct MessageView: View {
    var body: some View {
        NavigationView {
            Text("暂无消息")
                .padding()
                .navigationTitle("消息通知")
        }
        .navigationViewStyle(.stack)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
