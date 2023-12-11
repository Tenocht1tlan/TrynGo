//
//  TGAlbumView.swift
//  TrynGo
//
//  Created by 周阳 on 2023/12/12.
//

import SwiftUI

struct TGAlbumView : View {
    let styleArray = ["ai_style_p1", "ai_style_p2", "ai_style_p3", "ai_style_p4", "ai_style_p5", "ai_style_p6"]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Image("ai_bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Spacer()
                let w = (ScreenWidth - 150) / 3
                LazyVGrid(columns: [GridItem(.fixed(w)), GridItem(.fixed(w)), GridItem(.fixed(w))], spacing: 0, content: {
                    ForEach(styleArray.indices, id: \.self) { col in
                        Image(styleArray[col])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: w, height: w)
                            .onTapGesture {
                                
                            }
                    }
                })
                Spacer()
            }
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
    TGAlbumView()
}
