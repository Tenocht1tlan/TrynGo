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
                    VStack(alignment: .center, content: {
                        Spacer()
                        Image("home_bg_icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 650, height: 380)
                            .edgesIgnoringSafeArea(.all)
                            .padding()
                        Text("智绘银河")
                            .font(.custom("Helvetica-Bold", size: 66))
                            .frame(width: geometry.size.width * 0.6)
                            .multilineTextAlignment(.center)
                            .kerning(36)
                            .foregroundColor(.white)
                        Spacer().frame(height: 200)
                        Button(action: {
                            isShowingNewPage.toggle()
                        }) {
                            Text("注 册")
                                .font(.headline)
                                .padding()
                                .frame(width: geometry.size.width * 0.35)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }.padding()
                        Button(action: {
                            isShowingNewPage.toggle()
                        }) {
                            Text("登 录")
                                .font(.headline)
                                .padding()
                                .frame(width: geometry.size.width * 0.35)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .background(NavigationLink(destination: BlankPageView(), isActive: $isShowingNewPage, label: {
                        }))
                        .padding()
                        Spacer().frame(height: 156)
                        NavigationLink(destination: Text("隐私协议")) {
                            Text("您使用或继续使用，意味着同意按照《智绘银河隐私政策》收集、使用、储存、分享您的相关信息")
                                .font(.callout)
                                .foregroundColor(.white)
                        }
                        Spacer().frame(height: 48)
                    })
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
        ZStack(alignment: .center, content: {
            Image("home_bg")
                .resizable()
                .aspectRatio(CGSize(width: 3, height: 4), contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                MonthPicker()
                    .cornerRadius(18)
                    .frame(width: 180, height: 240)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .foregroundColor(.brown)
                    )
                TextField("用户名", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(width: 300)
                SecureField("密码", text: $password)
                    .padding()
                    .frame(width: 300)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Spacer()
                Button("确 定") {
                    isRight = password == "swagger"
                }
                .bold()
                .frame(width: 180, height: 72)
                .background(Color(hex: 0xffc700, alpha: 1))
                .cornerRadius(18)
                .foregroundColor(.white)
                Spacer()
            }
        })
        
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
                    .foregroundColor(Color(hex: 0xffc700, alpha: 1))
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

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0,
            opacity: alpha
        )
    }
}
