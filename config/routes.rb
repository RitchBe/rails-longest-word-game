Rails.application.routes.draw do
  # get 'words_controller/game'
  get 'game' , to: 'words_controller#game'
  # get 'words_controller/score'
  get 'score', to: 'words_controller#score'
  get '/', to: 'words_controller#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
