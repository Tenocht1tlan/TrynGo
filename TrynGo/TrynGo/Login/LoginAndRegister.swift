//
//  LoginAndRegister.swift
//  TrynGo
//
//  Created by 周阳 on 2023/11/24.
//

import SwiftUI

struct RegisterView: View {
    @State private var isRight = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .center, content: {
            Image("home_bg")
                .resizable()
                .aspectRatio(CGSize(width: 3, height: 4), contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            HStack {
                Spacer()
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
                Spacer()
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
                Spacer()
            }
        })
        .navigationBarTitle("", displayMode: .automatic)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left.circle")
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
