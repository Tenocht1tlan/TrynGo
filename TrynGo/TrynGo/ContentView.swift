//
//  ContentView.swift
//  TrynGo
//
//  Created by swagger on 2023/11/7.
//

import SwiftUI

struct ContentView: View {
    
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
                        
                        NavigationLink(
                            destination: RegisterView(),
                            label: {
                                Text("注 册")
                                    .font(.headline)
                                    .padding()
                                    .frame(width: geometry.size.width * 0.35)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        )
                        .padding()
                        
                        NavigationLink(
                            destination: RegisterView(),
                            label: {
                                Text("登 录")
                                    .font(.headline)
                                    .padding()
                                    .frame(width: geometry.size.width * 0.35)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        )
                        .padding()
                        
                        Spacer().frame(height: 156)
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
                        Spacer().frame(height: 48)
                    })
                    .padding()
                }
            }
        }
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

struct RegisterView: View {
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
                Text("请选择你的年龄")
                    .font(.custom("Helvetica-Bold", size: 56))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                Spacer()
                MonthPicker()
                    .cornerRadius(18)
                    .frame(width:240)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .foregroundColor(Color(hex: 0x584D85))
                    )
                    .padding()
                NavigationLink(
                    destination: HomeTabView(),
                    label: {
                        Text("确 定")
                            .bold()
                            .frame(width: 240, height: 72)
                            .background(Color(hex: 0xffc700, alpha: 1))
                            .cornerRadius(18)
                            .foregroundColor(.white)
                    }
                )
                .padding()
                
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
                    .frame(height: 50)
            )
            
        }
        .padding()
    }
}

struct CustomTabView : View {
    let imageName : String
    let title     : String
    let margin = 64.0
    
    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: margin)
                VStack {
                    Image("ai_enter_1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .onTapGesture {
                            print("Image 1 tapped!")
                        }
                    Text("进入AI绘画")
                        .padding()
                        .foregroundColor(.white)
                        .font(.custom("Helvetica-Bold", size: 32))
                }
                Spacer().frame(width: margin)
                VStack {
                    Image("ai_enter_2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .onTapGesture {
                            print("Image 2 tapped!")
                        }
                    Text("画册")
                        .padding()
                        .foregroundColor(.white)
                        .font(.custom("Helvetica-Bold", size: 32))
                }
                Spacer().frame(width: margin)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("ai_bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        )
        .tabItem {
            VStack {
                Image(imageName)
                Text(title)
                    .foregroundStyle(.white)
                    .padding(.top, 4)
            }
        }
    }
}

struct HomeTabView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        TabView {
            CustomTabView(imageName: "tab_paint_unselect", title: "AI绘画")
            CustomTabView(imageName: "tab_paint_unselect", title: "AI绘画2")
        }
        .padding(.bottom)
        .edgesIgnoringSafeArea(.bottom)
        .accentColor(.white)
        .navigationBarTitle("", displayMode: .automatic)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left.circle")
        })
    }
}

struct PrivacyView: View {
    
    var body: some View {
        VStack {
            Text("隐私")
        }
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
