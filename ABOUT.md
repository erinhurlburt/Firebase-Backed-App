#  ABOUT.md

Production Security Policy:
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow write: if request.auth != null;
      allow read: if true;
    }
  }
}


The Recipe App allows users to share their favorite breakfast, lunch, and dinner recipes with the other members of the blog. They can also view other authors recipes that are posted. For ease, to be connected to where the recipe is from, authors can insert a link to the website of their recipe that is accessible to views of their post. Each article also contains special Author and Meal Type fields that allow the creator of the recipe to take possession of their meal and so specify which meal their recipe is best used for so that the reader can easily scan through different recipe options. After posted, each article has a display its title in the list view for readers to see many meals at once. Upon clicking on an article, the reader can click on the drop down button to view the author's name, the link to the recipe,  instructions, and ingredients. To delete an article, simply click on the red delete button, swipe out of the app to refresh, and enter again to see the updated list of recipes. This app is perfect for all chefs from experienced pros to beginners looking for easy, quick recipes!


AppIcon credit:
https://play.google.com/store/apps/details?id=com.tudorspan.recipekeeper&hl=en_US&gl=US

