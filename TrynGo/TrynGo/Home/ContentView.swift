//
//  ContentView.swift
//  TrynGo
//
//  Created by swagger on 2023/11/7.
//

import SwiftUI

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height
let bgColor = Color(hex: 0xd0d0d0).opacity(0.2)

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

struct PictureAlbTabView : View {
    let margin    = 64.0
    
    var body: some View {
        Grid {
            GridRow {
                Image("ai_enter_2")
                Image("ai_enter_2")
                Image("ai_enter_2")
            }
            .padding()
            GridRow {
                Image("ai_enter_2")
                Image("ai_enter_2")
                Image("ai_enter_2")
            }
            .padding()
        }
        .padding()
        .frame(width: ScreenWidth, height: ScreenHeight)
        .background(
            Image("ai_bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct AIPaintTabView : View {
    let margin    = 64.0
    
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
                NavigationLink(destination: TGAlbumView()) {
                    VStack {
                        Image("ai_enter_2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
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
    }
}

struct HomeTabView: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        ZStack (alignment: .bottom, content: {
            TabView(selection: $selectedIndex, content:  {
                AIPaintTabView().tag(0)
                PictureAlbTabView().tag(1)
            })
            .padding(.bottom)
            .edgesIgnoringSafeArea(.bottom)
            .accentColor(.white)
            .navigationBarTitle("", displayMode: .automatic)
            .navigationBarBackButtonHidden(true)
            CustomTabBar(selectedIndex: $selectedIndex)
                .frame(height: ScreenHeight * 0.1)
        })
    }
}

struct CustomTabBar: View {
    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack {
            Spacer()
            TabBarButton(onName: "tab_paint_select", offName: "tab_paint_unselect", title: "AI绘画", index: 0, selectedIndex:$selectedIndex)
            Spacer()
            TabBarButton(onName: "tab_paint_select", offName: "tab_paint_unselect", title: "知识地图", index: 1, selectedIndex: $selectedIndex)
            Spacer()
        }
        .padding()
        .background(bgColor)
    }
}

struct TabBarButton: View {
    var onName: String
    var offName: String
    var title: String
    var index: Int
    @Binding var selectedIndex: Int

    var body: some View {
        Button(action: {
            selectedIndex = index
        }) {
            VStack {
                Spacer()
                Image(index == selectedIndex ? onName : offName)
                Spacer()
                Text(title)
                    .font(.footnote)
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
