//
//  TGAIPaintView.swift
//  TrynGo
//
//  Created by 周阳 on 2023/11/24.
//

import SwiftUI

struct TGAIPaintView : View {
    let bgColor = Color(hex: 0xd0d0d0).opacity(0.2)
    let left = 96.0
    let styleWidth = 150.0
    let sizeRatioTitle = ["选择画布尺寸", "1 : 1",
                          "2 : 3" , "3 : 2",
                          "3 : 4" , "4 : 3",
                          "9 : 16", "16 : 9"]
    let sizeRatioPic   = ["", "ai_border_1_1",
                          "ai_border_2_3", "ai_border_3_2",
                          "ai_border_3_4", "ai_border_4_3",
                          "ai_border_9_16", "ai_border_16_9"]
    let sizeRatio: [CGFloat] = [1.0, 2/3, 3/2, 3/4, 4/3, 9/16, 16/9]
    
    let styleArray = ["ai_style_p1", "ai_style_p2", "ai_style_p3", "ai_style_p4", "ai_style_p5", "ai_style_p6"]
    let sceneArray = ["ai_scene_p1", "ai_scene_p2", "ai_scene_p3", "ai_scene_p4", "ai_scene_p5", "ai_style_p6"]
    @State private var selectedStyleIndex = -1
    @State private var selectedSceneIndex = -1
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var selectedRatioIndex: Int = 1
    
    @State private var showStyleSheet = false  // 风格卡片
    @State private var showScenceSheet = false // 场景卡片
    
    @State private var userInput: String = ""
    @FocusState private var onFocused : Bool
    
    private func calculateW(_ w: CGFloat, _ h: CGFloat) -> CGFloat {
        let ratio = sizeRatio[selectedRatioIndex-1]
        let width = (w - h * ratio) / 2
        return width
    }
    
    var body: some View {
        VStack (alignment: .center, content: {
            Spacer()
            // 照片框 + 尺寸选择按钮
            HStack {
                Spacer().frame(width: left)
                VStack {
                    ZStack {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight:.infinity)
                        } else {
                            Text("点 击 选 择 图 片")
                                .frame(maxWidth: .infinity, maxHeight:.infinity)
                                .font(.largeTitle)
                        }
                        Image(sizeRatioPic[selectedRatioIndex])
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight:.infinity)
                        GeometryReader { geometry in
                            let width = calculateW(geometry.size.width, geometry.size.height)
                            Color(hex: 0x969696).opacity(0.6)
                                .frame(width: width, height: geometry.size.height)
                                .offset(x: 0)
                            Color(hex: 0x969696).opacity(0.6)
                                .frame(width: width, height: geometry.size.height)
                                .offset(x: geometry.size.width-width)
                        }
                    }
                }
                .background(.white)
                .cornerRadius(18)
                .frame(width: ScreenWidth*0.5, height: ScreenWidth*9/32)
                .onTapGesture {
                    isImagePickerPresented.toggle()
                }
                .sheet(isPresented: $isImagePickerPresented, content: {
                    ImagePicker(image: $selectedImage, sourceType: .photoLibrary)
                })
                
                Spacer()
                
                LazyVGrid(columns: [GridItem(.fixed(180)), GridItem(.fixed(180), alignment: .leading)], spacing: 18) {
                    ForEach(sizeRatioTitle.indices, id: \.self) { index in
                        let text = sizeRatioTitle[index]
                        if index == 0 {
                            Text(text)
                                .frame(width: 180, height: 50)
                                .font(.custom("Helvetica", size: 24))
                                .foregroundColor(.white)
                                .cornerRadius(32)
                                .padding()
                        } else {
                            Text(text)
                                .frame(width: 180, height: 50)
                                .font(.custom("Helvetica", size: 24))
                                .foregroundColor(selectedRatioIndex == index ? Color.black : Color.white)
                                .background(selectedRatioIndex == index ? Color.white : bgColor)
                                .cornerRadius(32)
                                .padding()
                                .onTapGesture {
                                    selectedRatioIndex = index
                                }
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            
            Spacer().frame(height: 30)
            // 风格卡片 + 场景卡片 + 描述画面 + 生成按钮
            HStack (alignment: .bottom, content: {
                Spacer().frame(width: left)
                SenceCardView(selectedStyleIndex: $selectedStyleIndex, isShow: $showStyleSheet, styleArray: styleArray, title: "风格卡片", btnImage: "ai_style")
                    .padding()
                SenceCardView(selectedStyleIndex: $selectedSceneIndex, isShow: $showScenceSheet, styleArray: sceneArray, title: "场景卡片", btnImage: "ai_scene")
                    .padding()
                Spacer()
                HStack (alignment: .bottom, content: {
                    TextEditor(text: $userInput)
                        .frame(width: ScreenWidth*0.4, height: ScreenHeight*0.2)
                        .foregroundColor(.white)
                        .padding()
                        .scrollContentBackground(.hidden)
                        .focused($onFocused)
                        .onTapGesture {
                            guard !onFocused else { return }
                            onFocused = false
                        }
                        .background {
                            ZStack (alignment: .topLeading, content: {
                                if !onFocused {
                                    Text("请描述画面......")
                                        .font(.title3)
                                        .foregroundColor(.white)
                                        .padding(EdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 0))
                                }
                                Rectangle()
                                    .foregroundColor(bgColor)
                                    .cornerRadius(12)
                                Image(systemName: "mic.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                    .padding(EdgeInsets(top: ScreenHeight*0.2-10, leading: ScreenWidth*0.4, bottom: 0, trailing: 0))
                            })
                        }
                    Spacer()
                    NavigationLink(
                        destination: AIGeneratingView(),
                        label: {
                            Text("生 成")
                                .font(.title)
                                .frame(width: 100, height: 48)
                                .background(.yellow)
                                .foregroundColor(.black)
                                .cornerRadius(24)
                        }
                    )
                    .padding()
                })
                .padding()
                Spacer().frame(width: left/2)
            })
            Spacer()
        })
        .frame(height: ScreenHeight)
        .background(
            Image("ai_bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        )
        .overlay(content: {
            if showStyleSheet {
                TGSheetGridView(onDismiss: {
                    withAnimation {
                        showStyleSheet = false
                    }
                }, images: styleArray, selectedIndex: $selectedStyleIndex)
                .cornerRadius(24)
                .frame(width: ScreenWidth*0.85, height: ScreenHeight*0.85)
                .transition(.move(edge: .bottom))
            }
            if showScenceSheet {
                TGSheetGridView(onDismiss: {
                    withAnimation {
                        showScenceSheet = false
                    }
                }, images: sceneArray, selectedIndex: $selectedSceneIndex)
                .cornerRadius(24)
                .frame(width: ScreenWidth*0.85, height: ScreenHeight*0.85)
                .transition(.move(edge: .bottom))
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

struct TGSheetGridView: View {
    var onDismiss: () -> Void
    var images: [String]
    @Binding var selectedIndex : Int
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                Image("ai_sheetbg")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .overlay(alignment: .topTrailing, content: {
                        Image("ai_close_small")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .offset(x: -32, y: 32)
                            .onTapGesture {
                                onDismiss()
                            }
                    })
                let w = (geometry.size.width - 80) / 3
                Grid {
                    ForEach(0..<2) { row in
                        GridRow {
                            ForEach(0..<3) { col in
                                let index = row * 3 + col
                                Image(images[index])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: w, height: w)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        selectedIndex = index
                                        onDismiss()
                                    }
                            }
                        }
                    }
                    
                }
            }
        })
    }
}

struct AIGeneratingView : View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Image("ai_bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            Image("ai_generate")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: ScreenWidth*0.75, height: ScreenHeight*0.75)
            Image("ai_generate2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: ScreenWidth*0.4, height: ScreenWidth*0.4)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image("home_back")
        })
    }
}

#Preview {
    TGAIPaintView()
}

struct SenceCardView: View {
    @Binding var selectedStyleIndex : Int
    @Binding var isShow : Bool
    var styleArray : [String]
    var title : String
    var btnImage : String
    let styleWidth = 150.0
    
    var body: some View {
        VStack {
            Button(title) {
                withAnimation {
                    isShow.toggle()
                }
            }
            .font(.title2)
            .background(Image(btnImage))
            .frame(width: styleWidth, height: 45)
            .cornerRadius(16)
            .padding()
            ZStack {
                Rectangle()
                    .frame(width: 150, height: 150)
                    .foregroundColor(bgColor)
                    .cornerRadius(12)
                if selectedStyleIndex != -1 {
                    Image(styleArray[selectedStyleIndex])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .overlay(alignment: .topTrailing) {
                            Image("ai_close_small")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .offset(x: 5, y: -5)
                                .onTapGesture {
                                    selectedStyleIndex = -1
                                }
                        }
                }
            }
        }
        .padding()
    }
}
