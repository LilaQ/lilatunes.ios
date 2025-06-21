//
//  FullWidthSquareImage.swift
//  lilatunes.ios
//
//  Created by Jan Sallads on 19.06.25.
//

import SwiftUICore
import SwiftUI

struct FullWidthSquareAsyncImage: View {
    let url: URL?
    let padding: CGFloat
    
    init(url: URL?, padding: CGFloat = 0) {
        self.url = url
        self.padding = padding
    }

    var body: some View {
        GeometryReader { geometry in
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.width
            )
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 5)
        }
        .padding()
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    FullWidthSquareAsyncImage(url: Song.demo.coverUrl, padding: 20)
}
