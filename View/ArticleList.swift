//
//  ArticleList.swift
//  Blog
//
//  Created by Erin Hurlburt on 4/3/22.
//

import SwiftUI

struct ArticleList: View {
    //objects of the service group
    @EnvironmentObject var auth: BlogAuth
    @EnvironmentObject var articleService: BlogArticle

    @Binding var requestLogin: Bool

    @State var articles: [Article]
    @State var error: Error?
    @State var fetching = false
    @State var writing = false
    @State var title: String = ""
    //@State var isFavorite: Bool
    
    @State private var showFavoritesOnly = false
    
    var filteredRecipes: [Article] {
        articles.filter { articles in
            (!showFavoritesOnly || articles.isFavorite)
        }
    }
    
    private func deleteItem(at indexSet: IndexSet) {
        articles.remove(atOffsets: indexSet)
    }

    var body: some View {
        NavigationView {
            List {
                if fetching {
                    ProgressView()
                } else if error != nil {
                    Text("Something went wrong…we wish we can say more 🤷🏽")
                } else if articles.count == 0 {
                    VStack {
                        Spacer()
                        Text("There are no articles.")
                        Spacer()
                    }
                } else {
                    
                    Toggle(isOn: $showFavoritesOnly) {
                        Text("Favorites only")
                    }
                    
                    
                    ForEach(articles) { article in
                        NavigationLink {
                            ArticleDetail(article: article)
                                .padding(.top, -150)
                        } label: {
                            ArticleMetadata(article: article)
                        }
                    }
                }
            }
            .navigationTitle("Recipe Blog!")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    if auth.user != nil {
                        Button("New Article") {
                            writing = true
                        }
                    }
                }

                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if auth.user != nil {
                        Button("Sign Out") {
                            do {
                                try auth.signOut()
                            } catch {
                                // No error handling in the sample, but of course there should be
                                // in a production app.
                            }
                        }
                    } else {
                        Button("Sign In") {
                            requestLogin = true
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $writing) {
            ArticleEntry(articles: $articles, writing: $writing)
        }
        .task {
            fetching = true

            do {
                articles = try await articleService.fetchArticles()
                fetching = false
            } catch {
                self.error = error
                fetching = false
            }
        }
    }
}

struct ArticleList_Previews: PreviewProvider {
    @State static var requestLogin = false

    static var previews: some View {
//        ArticleList(requestLogin: $requestLogin, articles: [])
//            .environmentObject(BlogAuth())

        ArticleList(requestLogin: $requestLogin, articles: [
            Article(
                id: "12345",
                title: "Preview",
                date: Date(),
                body: "Lorem ipsum dolor sit something something amet",
                isFavorite: true
            ),

            Article(
                id: "67890",
                title: "Some time ago",
                date: Date(timeIntervalSinceNow: TimeInterval(-604800)),
                body: "Duis diam ipsum, efficitur sit amet something somesit amet",
                isFavorite: false
            )
        ])
            .environmentObject(BlogAuth())
            .environmentObject(BlogArticle())
    }
}
