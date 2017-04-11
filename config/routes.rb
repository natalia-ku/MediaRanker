Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'albums', to: 'works#show_albums'#, as: 'albums'
  get 'movies', to: 'works#show_movies'#, as: 'movies'
  get 'books', to: 'works#show_books' #, as: 'books'
  resources :welcome
  resources :users
  resources :votes
  resources :works


end