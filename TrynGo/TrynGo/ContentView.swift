//
//  ContentView.swift
//  TrynGo
//
//  Created by 周阳 on 2023/11/7.
//

import SwiftUI

struct ContentView: View {
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
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isRight = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Spacer()
            MonthPicker()
                .cornerRadius(18)
                .frame(width: 240, height: 800)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .foregroundColor(.brown)
                )
            TextField("用户名", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .frame(width: 600)
            SecureField("密码", text: $password)
                .padding()
                .frame(width: 600)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Spacer()
            Button("确定") {
                isRight = password == "swagger"
            }
            .frame(width: 180, height: 72)
            .cornerRadius(18)
            .border(.yellow, width: 2)
            
            Spacer()
        }
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
        })
        .navigationBarTitle("银河起点", displayMode: .automatic)
    }
}

struct MonthPicker: View {
    @State private var selectedMonthIndex = 5
    let months = ["5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
    
    var body: some View {
        VStack {
            Picker(selection: $selectedMonthIndex, label: Text("")) {
                ForEach(0..<months.count) { index in
                    Text(months[index]).tag(index)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 800)
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(Color.yellow)
                    .padding(8)
                    .frame(height: 50)
            )
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
