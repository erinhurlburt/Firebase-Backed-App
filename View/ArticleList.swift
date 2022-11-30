//
//  ArticleList.swift
//  Blog
//
//  Created by Erin Hurlburt on 4/3/22.
//

import SwiftUI

struct meal {
    let label: String
    let type: String
}

struct ArticleList: View {
    //objects of the service group
    @EnvironmentObject var auth: BlogAuth
    @EnvironmentObject var articleService: BlogArticle
    @ObservedObject private var viewModel = BlogArticle()
    
    @State private var isEditing = true
    @State private var searchText = ""

    @Binding var requestLogin: Bool

    @State var articles: [Article]
    //@State var article: Article
    @State var error: Error?
    @State var fetching = false
    @State var writing = false
    @State var mealType = "Lunch"
    //@State var title: String = ""
    //@State var author: String = ""
    
    

    var body: some View {
        NavigationView {
            VStack {
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
 
                    List {
                        ForEach(articles) { article in
                            NavigationLink {
                                ArticleDetail(article: article)
                                //.padding(.top, -150)
 
                            } label: {
                                ArticleMetadata(article: article)
                                
                                Button("Delete", action: {
                                    self.viewModel.deleteData(documentID: article.id)
                                })
                                .buttonStyle(PlainButtonStyle())
                                .foregroundColor(.red)
                            }
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
                author: "Example",
                link: "https://www.foodnetwork.com",
                body: "Lorem ipsum dolor sit something something amet",
                mealType: "Dinner"
            ),

            Article(
                id: "67890",
                title: "Some time ago",
                date: Date(timeIntervalSinceNow: TimeInterval(-604800)),
                author: "Author",
                link: "https://www.foodnetwork.com",
                body: "Duis diam ipsum, efficitur sit amet something somesit amet",
                mealType: "Breakfast"
            )
        ])
        .environmentObject(BlogAuth())
        .environmentObject(BlogArticle())
    }
}
