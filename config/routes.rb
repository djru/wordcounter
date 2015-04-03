Rails.application.routes.draw do
  root "wordcounter#index"
  post "/count", to: "wordcounter#count"
  get "/manual", to: "wordcounter#manual", as: :manual_entry
  post "count_manual", to: "wordcounter#count_manual"
end
