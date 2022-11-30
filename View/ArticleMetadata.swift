//
//  ArticleMetadata.swift
//  Blog
//
//  Created by Erin Hurlburt on 4/3/22.
//

import SwiftUI

struct ArticleMetadata: View {
    var article: Article
    

    var body: some View {
        HStack() {
            Text(article.title)
                .font(.headline)
            

            Spacer()

            VStack(alignment: .trailing) {
                Text(article.date, style: .date)
                    .font(.caption)

                Text(article.date, style: .time)
                    .font(.caption)
            }
        }
    }
}

struct ArticleMetadata_Previews: PreviewProvider {
    static var previews: some View {
        ArticleMetadata(article: Article(
            id: "12345",
            title: "Preview",
            date: Date(),
            author: "Author",
            link: "https://www.foodnetwork.com",
            body: "Lorem ipsum dolor sit something something amet",
            mealType: "Lunch"
        ))
    }
}
