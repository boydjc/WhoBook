// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// this code here connects to the new post button,
// when the user clicks the button, if the create post
// form is not showing, the form will appear from the top with a css animation


let createPostFormShowing = false;
let newPostFormCloseLink = null;

let newPostButton = document.getElementById('newPostButton');
newPostButton.addEventListener('click', () => {

	let newPostFormContainer = document.getElementById('newPostFormContainer');

	if(!createPostFormShowing) {

		if(newPostFormContainer.classList.contains('formHide')) {
			newPostFormContainer.classList.remove('formHide');
		}

		newPostFormContainer.classList.add('formShow');
		createPostFormShowing = true;
		newPostFormCloseLink = document.getElementById("newPostCloseLink");

		newPostFormCloseLink.addEventListener('click', () => {

			if(newPostFormContainer.classList.contains('formShow')) {
				newPostFormContainer.classList.remove('formShow');
			}
			
			newPostFormContainer.classList.add('formHide');
			createPostFormShowing = false;
		});

	} 
});