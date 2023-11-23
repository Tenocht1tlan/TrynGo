//
//  TGAIPaintView.swift
//  TrynGo
//
//  Created by 周阳 on 2023/11/24.
//

import SwiftUI

struct TGAIPaintView : View {
    let left = 64.0
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    
    var body: some View {
        VStack {
            Spacer()
            // 照片框 + 尺寸选择按钮
            HStack {
                Spacer().frame(width: left)
                VStack {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: ScreenWidth*0.5, height: ScreenHeight*0.4)
                    } else {
                        Button("Select Photo") {
                            isImagePickerPresented.toggle()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .sheet(isPresented: $isImagePickerPresented) {
                            ImagePicker(image: $selectedImage, sourceType: .photoLibrary)
                        }
                    }
                }
                .background(.white)
                .cornerRadius(32)
                
                Spacer().frame(width: left)
                
                Text("1 : 1")
                    .font(.custom("Helvetica", size: 24))
                    .frame(width: 200, height: 50)
                    .foregroundColor(.black)
                    .background(.white)
                    .cornerRadius(32)
                    .padding()
                Text("2 : 3")
                    .font(.custom("Helvetica", size: 24))
                    .frame(width: 200, height: 50)
                    .foregroundColor(.black)
                    .background(.white)
                    .cornerRadius(32)
                    .padding()
            }
            
            Spacer()
            // 风格卡片 + 场景卡片 + 描述画面 + 生成按钮
            HStack {
                Spacer().frame(width: left)
                
                NavigationLink(
                    destination: RegisterView(),
                    label: {
                        Text("风格卡片")
                            .font(.title)
                            .padding()
                            .frame(width: 200)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                    }
                ).padding()
                
                Spacer().frame(width: left)
                
                NavigationLink(
                    destination: RegisterView(),
                    label: {
                        Text("场景卡片")
                            .font(.title)
                            .padding()
                            .frame(width: 200)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                    }
                ).padding()
                
                Spacer().frame(width: left)
                
                NavigationLink(
                    destination: RegisterView(),
                    label: {
                        Text("生 成")
                            .font(.title)
                            .padding()
                            .frame(width: 160)
                            .background(.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(36)
                    }
                ).padding()
            }
            Spacer()
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

#Preview {
    TGAIPaintView()
}
