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
    @EnvironmentObject var auth: BlogAuth
    @Environment(\.openURL) var openURL
    

    var body: some View {
        ScrollView {
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
                        HStack {
                            Text("Written by: ")
                            Text(article.author)
                        }
                        HStack{
                            Link(destination: URL(string: article.link)!) {
                                Image(systemName: "link.circle.fill")
                                    .font(.largeTitle)
                            }
                        }
                        .padding()
                        
                        HStack {
                            Text("Meal type: ")
                            Text(article.mealType)
                        }
                        
                        Text(article.body).padding()
                            .background(BadgeBackground())
                    }
                }
            }
        }
    }
}

struct ArticleDetail_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetail(article: Article(
            id: "12345",
            title: "Preview",
            date: Date(),
            author: "Author",
            link: "https://www.foodnetwork.com",
            body: "Lorem ipsum dolor sit something something amet",
            mealType: "Dinner"
        ))
    }
}

