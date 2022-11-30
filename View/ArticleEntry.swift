//
//  ArticleEntry.swift
//  Blog
//
//  Created by Erin Hurlburt on 4/3/22.
//

import SwiftUI

struct ArticleEntry: View {
    @EnvironmentObject var articleService: BlogArticle

    @Binding var articles: [Article]
    @Binding var writing: Bool
    

    
    @State var title = ""
    @State var articleBody = ""
    @State var link = ""
    @State var author = ""
    @State var mealType = ""

    func submitArticle() {
        // We take a two-part approach here: this first part sends the article to
        // the database. The `createArticle` function gives us its ID.
        let articleId = articleService.createArticle(article: Article(
            id: UUID().uuidString, // Temporary, only here because Article requires it.
            title: title,
            date: Date(),
            author: author,
            link: link,
            body: articleBody,
            mealType: mealType
            
        ))

        
        articles.append(Article(
            id: articleId,
            title: title,
            date: Date(),
            author: author,
            link: link,
            body: articleBody,
            mealType: mealType
        ))

        writing = false
    }

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Title")) {
                    TextField("", text: $title)
                        //.padding(.bottom, -100)
                }
                
                Section(header: Text("Author")) {
                    TextField("", text: $author)
                }
                
                Section(header: Text("Link")) {
                    TextField("", text: $link)
                }
                
                Section(header: Text("Meal Type (Breakfast, Lunch, Dinner)")) {
                    TextField("", text: $mealType)
                }

                Section(header: Text("Body")) {
                    TextEditor(text: $articleBody)
                        .frame(minHeight: 256, maxHeight: .infinity)
                }
            }
            .navigationTitle("New Article")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        writing = false
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Submit") {
                        submitArticle()
                    }
                    .disabled(title.isEmpty || articleBody.isEmpty)
                }
            }
        }
    
    }
}

struct ArticleEntry_Previews: PreviewProvider {
    @State static var articles: [Article] = []
    @State static var writing = true
    
    static var previews: some View {
        ArticleEntry(articles: $articles, writing: $writing)
            .environmentObject(BlogArticle())
    }
}

