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
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Image("home_bg")
                        .resizable()
                        .aspectRatio(CGSize(width: 3, height: 4), contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
    //                    SecureField("密码", text: $password)
    //                        .padding()
    //                        .textFieldStyle(RoundedBorderTextFieldStyle())
    //                        .padding()
                        Spacer().frame(height: 300)
                        Button(action: {
                            isShowingNewPage.toggle()
                        }) {
                            Text("注册")
                                .font(.headline)
                                .padding()
                                .frame(width: geometry.size.width * 0.4)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        Spacer().frame(height: 36)
                        Button(action: {
                            isShowingNewPage.toggle()
                        }) {
                            Text("登录")
                                .font(.headline)
                                .padding()
                                .frame(width: geometry.size.width * 0.4)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .background(NavigationLink(destination: BlankPageView(), isActive: $isShowingNewPage, label: {
                        }))
                        .padding()
                        Spacer().frame(height: 156)
                        NavigationLink(destination: Text("隐私协议")) {
                            Text("隐私协议隐私协议隐私协议隐私协议隐私协议隐私协议")
                                .font(.callout)
                                .foregroundColor(.white)
                        }
                        Spacer().frame(height: 48)
                    }
                    .padding()
                }
            }
        }
    }
}

struct BlankPageView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Spacer()
            Text("Hello world")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
        })
        .navigationBarTitle("银河起点", displayMode: .automatic)
    }
}

#Preview {
    ContentView()
}
