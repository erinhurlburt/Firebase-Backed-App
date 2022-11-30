//
//  ArticleDetail.swift
//  Blog
//
//  Created by Erin Hurlburt on 4/3/22.
//

import SwiftUI

struct ArticleDetail: View {
    var article: Article
    @State private var showDetail = false

    var body: some View {
        VStack {
            ArticleMetadata(article: article)
                .padding()
            
            Divider()
            
            HStack(alignment: .center) {
                Text("View Article Contents:")
                    .font(.headline)
                    .padding()
                
                Spacer()
                
                Button {
                    withAnimation {
                        showDetail.toggle()
                    }
                } label: {
                    Label("Graph", systemImage: "chevron.right.circle")
                        .labelStyle(.iconOnly)
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        .scaleEffect(showDetail ? 1.5 : 1)
                        .padding()
                    
                }
            }
            
            if showDetail {
                VStack(alignment: .center) {
                    Text(article.body).padding()
                }
            }

            
            Spacer()
        }
    }
}

struct ArticleDetail_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetail(article: Article(
            id: "12345",
            title: "Preview",
            date: Date(),
            body: "Lorem ipsum dolor sit something something amet",
            isFavorite: true
        ))
    }
}

