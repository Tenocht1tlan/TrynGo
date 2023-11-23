//
//  ContentView.swift
//  TrynGo
//
//  Created by swagger on 2023/11/7.
//

import SwiftUI

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("home_bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Image("home_bg_icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: ScreenWidth * 0.5, height: ScreenHeight * 0.5)
                        .edgesIgnoringSafeArea(.all)
                    
                    Text("智绘银河")
                        .font(.custom("Helvetica-Bold", size: 66))
                        .frame(width: UIScreen.main.bounds.width * 0.5)
                        .multilineTextAlignment(.center)
                        .kerning(36)
                        .foregroundColor(.white)
                        .padding()
                    
                    Spacer().frame(height: ScreenHeight * 0.1)
                    
                    NavigationLink(
                        destination: RegisterView(),
                        label: {
                            Text("注 册")
                                .font(.title)
                                .padding()
                                .frame(width: ScreenWidth * 0.3)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(36)
                        }
                    )
                    
                    NavigationLink(
                        destination: RegisterView(),
                        label: {
                            Text("登 录")
                                .font(.title)
                                .padding()
                                .frame(width: ScreenWidth * 0.3)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(36)
                        }
                    )
                    .padding()
                    
                    Spacer().frame(height: 30)
                    
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
                }
                .padding()
            }
        }
    }
}

struct CustomTabView : View {
    let imageName : String
    let title     : String
    let margin = 64.0
    
    var body: some View {
        NavigationStack {
            HStack {
                Spacer().frame(width: margin)
                NavigationLink(destination: TGAIPaintView()) {
                    VStack {
                        Image("ai_enter_1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                        Text("进入AI绘画")
                            .padding()
                            .foregroundColor(.white)
                            .font(.custom("Helvetica-Bold", size: 32))
                    }
                }
                Spacer().frame(width: margin * 2.5)
                NavigationLink(destination: TGAIPaintView()) {
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
                }
                Spacer().frame(width: margin)
            }
        }
        .frame(height: ScreenHeight)
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
            }
        }
    }
}

struct HomeTabView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        TabView {
            CustomTabView(imageName: "tab_paint_select", title: "AI绘画")
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

#Preview {
    HomeTabView()
}
