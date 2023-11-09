//
//  ContentView.swift
//  TrynGo
//
//  Created by 周阳 on 2023/11/7.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isShowingNewPage = false
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    Spacer()
                    
                    Text("TrynGo")
                        .font(.largeTitle)
                        .padding()
                    
                    TextField("用户名", text: $username)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    SecureField("密码", text: $password)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        isShowingNewPage.toggle()
                    }) {
                        Text("登录")
                            .font(.headline)
                            .padding()
                            .frame(width: geometry.size.width * 0.5)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .background(NavigationLink(destination: BlankPageView(), isActive: $isShowingNewPage, label: {
                        
                    }))
                    .padding()
                    
                    NavigationLink(destination: Text("忘记密码页面")) {
                        Text("忘记密码?")
                            .foregroundColor(.blue)
                    }
                    Spacer()
                }
                .padding()
                .navigationTitle("登录")
            }
        }
    }
}

struct BlankPageView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Text("欢迎")
                .font(.largeTitle)
                .padding()
            
            Spacer()
        }
        .background(Color.gray)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            // 返回按钮的操作
            // 设置isShowingNewPage为false，返回到登录页面
            // 例如：isShowingNewPage = false
        }) {
            Text("返回")
                .foregroundColor(.blue)
        })
        .navigationBarTitle("欢迎页面", displayMode: .inline)
    }
}

#Preview {
    ContentView()
}
