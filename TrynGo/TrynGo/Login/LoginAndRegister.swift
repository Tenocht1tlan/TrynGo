//
//  LoginAndRegister.swift
//  TrynGo
//
//  Created by 周阳 on 2023/11/24.
//

import SwiftUI

struct RegisterView: View {
    @State private var isRight = false
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var conformPw: String = ""
    @FocusState private var isUnFocused : Bool
    @FocusState private var isPwFocused : Bool
    @FocusState private var isPwCFocused : Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .center, content: {
                Image("ai_bg")
                    .resizable()
                    .aspectRatio(CGSize(width: 3, height: 4), contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer().frame(height: 30)
                    Image("home_bg_icon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: ScreenWidth * 0.35, height: ScreenHeight * 0.35)
                    Text("欢迎加入我们！")
                        .font(.custom("Helvetica-Bold", size: 48))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding()
                    
                    Spacer().frame(height: 30)
                    TextField("用户名", text: $username)
                        .padding()
                        .textFieldStyle(.plain)
                        .padding([.leading, .trailing])
                        .frame(width: ScreenWidth*0.35)
                        .focused($isUnFocused)
                        .foregroundColor(.white)
                        .background {
                            ZStack(alignment: .leading, content: {
                                bgColor
                                if !isUnFocused && username.isEmpty {
                                    Text("请输入账号")
                                        .font(.title3)
                                        .foregroundColor(.white)
                                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                                }
                            })
                        }
                        .cornerRadius(28)
                    Spacer().frame(height: 30)
                    SecureField("密码", text: $password)
                        .padding()
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .padding([.leading, .trailing])
                        .frame(width: ScreenWidth*0.35)
                        .focused($isPwFocused)
                        .background {
                            ZStack(alignment: .leading, content: {
                                bgColor
                                if !isPwFocused && password.isEmpty {
                                    Text("请输入密码")
                                        .font(.title3)
                                        .foregroundColor(.white)
                                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                                }
                            })
                        }
                        .cornerRadius(28)
                    Spacer().frame(height: 30)
                    SecureField("确认密码", text: $conformPw)
                        .padding()
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .padding([.leading, .trailing])
                        .frame(width: ScreenWidth*0.35)
                        .focused($isPwCFocused)
                        .background {
                            ZStack(alignment: .leading, content: {
                                bgColor
                                if !isPwCFocused && conformPw.isEmpty {
                                    Text("请确认密码")
                                        .font(.title3)
                                        .foregroundColor(.white)
                                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                                }
                            })
                        }
                        .cornerRadius(28)
                    Spacer().frame(height: 30)
                    NavigationLink(
                        destination: RegisterAgeView(),
                        label: {
                            Text("注 册")
                                .font(.title)
                                .padding()
                                .frame(width: ScreenWidth * 0.3)
                                .background(Color(hex: 0xFFE26B))
                                .foregroundColor(.black)
                                .cornerRadius(36)
                        }
                    )
                    .padding()
                    
                    Text("其他登录方式")
                        .foregroundStyle(.white)
                        .font(.title3)
                    Spacer().frame(height: ScreenHeight*0.25)
                }
            })
            .navigationBarTitle("", displayMode: .automatic)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image("home_back")
            })
        }
    }
}

struct RegisterAgeView: View {
    @State private var isRight = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .center, content: {
            Image("ai_bg")
                .resizable()
                .aspectRatio(CGSize(width: 3, height: 4), contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            HStack {
                VStack {
                    Spacer()
                    Image("home_bg_icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: ScreenWidth * 0.3, height: ScreenHeight * 0.3)
                        .edgesIgnoringSafeArea(.all)
                    
                    Text("请选择你的年龄")
                        .font(.custom("Helvetica-Bold", size: 48))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    Spacer()
                }
                .frame(width: ScreenWidth/2)
                ZStack {
                    Color(hex: 0x584db5).opacity(0.4)
                    VStack {
                        Spacer()
                        MonthPicker()
                            .cornerRadius(18)
                            .frame(width:240)
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .foregroundColor(Color(hex: 0x584D85))
                            )
                            .padding()
                        Spacer().frame(height: 50)
                        NavigationLink(
                            destination: HomeTabView(),
                            label: {
                                Text("确 定")
                                    .bold()
                                    .font(.title)
                                    .frame(width: 240, height: 72)
                                    .background(Color(hex: 0xffc700, alpha: 1))
                                    .cornerRadius(24)
                                    .foregroundColor(.white)
                            }
                        )
                        Spacer()
                    }
                }
            }
        })
        .navigationBarTitle("", displayMode: .automatic)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image("home_back")
        })
    }
}

struct PrivacySheetView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("隐私政策")
                .padding()
            HStack {
                Text("您使用或继续使用，意味着同意按照")
                    .font(.callout)
                    .foregroundColor(.white)
                
                Link("《智绘银河隐私政策》", destination: URL(string: "https://www.baidu.com")!)
                    .font(.callout)
                    .foregroundColor(.blue)
                
                Text("收集、使用、储存、分享您的相关信息")
                    .font(.callout)
                    .foregroundColor(.white)
            }
            HStack {
                Button("同意并且进入") {
                    isPresented = false
                }
                .padding()
                
                Button("拒绝并退出") {
                    isPresented = false
                }
                .padding()
                .foregroundColor(.red)
            }
        }
        .background(Color(hex: 0x61597D))
        .cornerRadius(100)
        .padding()
    }
}

struct PrivacyView: View {
    
    var body: some View {
        VStack {
            Text("隐私")
        }
    }
}

struct MonthPicker: View {
    @State private var selectedMonthIndex = 5
    let months = ["5", "6", "7", "8", "9", "10", "11", "12",
                  "13", "14", "15", "16", "17", "18", "19", "20"]
    
    var body: some View {
        VStack {
            Picker(selection: $selectedMonthIndex, label: Text("年龄")) {
                ForEach(0..<months.count) { index in
                    Text(months[index]).tag(index)
                        .foregroundColor(.white)
                        .bold()
                }
            }
            .pickerStyle(.wheel)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color(hex: 0xffc700, alpha: 1))
                    .padding(1)
                    .frame(height: 40)
            )
            
        }
        .padding()
    }
}

#Preview(body: {
    RegisterView()
})
