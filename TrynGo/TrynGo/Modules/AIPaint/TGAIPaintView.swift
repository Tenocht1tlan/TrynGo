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
    let texts = ["选择画布尺寸", "1 : 1",
                 "2 : 3" , "3 : 2",
                 "3 : 4" , "4 : 4",
                 "9 : 16", "16 : 9"]
    let styleArray = ["ai_style_p1", "ai_style_p2", "ai_style_p3", "ai_style_p4", "ai_style_p5", "ai_style_p6"]
    let sceneArray = ["ai_scene_p1", "ai_scene_p2", "ai_scene_p3", "ai_scene_p4", "ai_scene_p5", "ai_style_p6"]
    @State private var selectedStyleIndex = -1
    @State private var selectedSceneIndex = -1
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var isSelectedIndex: Int = 1
    
    @State private var showStyleSheet = false  // 风格卡片
    @State private var showScenceSheet = false // 场景卡片
    
    @State private var userInput: String = ""
    @FocusState private var onFocused : Bool
    
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
                            Image("ai_pic_border")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight:.infinity)
                        }
                        else {
                            Text("点 击 选 择 图 片")
                                .frame(maxWidth: .infinity, maxHeight:.infinity)
                                .font(.largeTitle)
                        }
                    }
                }
                .background(.white)
                .cornerRadius(24)
                .frame(width: ScreenWidth*0.5, height: ScreenHeight*0.4)
                .onTapGesture {
                    isImagePickerPresented.toggle()
                }
                .sheet(isPresented: $isImagePickerPresented, content: {
                    ImagePicker(image: $selectedImage, sourceType: .photoLibrary)
                })
                
                Spacer()
                
                LazyVGrid(columns: [GridItem(.fixed(180)), GridItem(.fixed(180), alignment: .leading)], spacing: 18) {
                    ForEach(texts.indices, id: \.self) { index in
                        let text = texts[index]
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
                                .foregroundColor(isSelectedIndex == index ? Color.black : Color.white)
                                .background(isSelectedIndex == index ? Color.white : bgColor)
                                .cornerRadius(32)
                                .padding()
                                .onTapGesture {
                                    isSelectedIndex = index
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
                VStack {
                    Button("风格卡片") {
                        showStyleSheet = true
                    }
                    .font(.title2)
                    .background(Image("ai_style"))
                    .frame(width: styleWidth, height: 45)
                    .cornerRadius(16)
                    .padding()
                    .sheet(isPresented: $showStyleSheet, content: {
                        TGSheetGridView(images: styleArray, selectedIndex:$selectedStyleIndex)
                    })
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
                        }
                    }
                }
                .padding()
                VStack {
                    Button("场景卡片") {
                        showScenceSheet = true
                    }
                    .font(.title2)
                    .background(Image("ai_scene"))
                    .frame(width: styleWidth, height: 45)
                    .cornerRadius(16)
                    .padding()
                    .sheet(isPresented: $showScenceSheet, content: {
                        TGSheetGridView(images: sceneArray, selectedIndex:$selectedSceneIndex)
                    })
                    ZStack {
                        Rectangle()
                            .frame(width: 150, height: 150)
                            .foregroundColor(bgColor)
                            .cornerRadius(12)
                        if selectedSceneIndex != -1 {
                            Image(sceneArray[selectedSceneIndex])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                        }
                    }
                }
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
    @Environment(\.dismiss) var dismiss
    
    var images: [String]
    @Binding var selectedIndex :Int
    
    var body: some View {
        ZStack {
            Image("ai_sheetbg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
//                Image("ai_close_small")
//                    .resizable()
//                    .frame(width: 36, height: 36)
//                    .aspectRatio(contentMode: .fill)
//                    .onTapGesture {
//                    dismiss()
//                }
                
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(images.indices, id: \.self) { index in
                    Image(images[index])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: ScreenWidth*0.15, height: ScreenWidth*0.15)
                        .cornerRadius(10)
                        .onTapGesture {
                            selectedIndex = index
                            dismiss()
                        }
                }
            }
            .frame(width: ScreenWidth*0.5, height: ScreenHeight)
        }
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
    AIGeneratingView()
}
