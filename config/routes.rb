Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
    root "elements#index"
    resources :elements do
      resources :element_sales
    end
    resources :bill do
      resources :bill_elements
    end
end
