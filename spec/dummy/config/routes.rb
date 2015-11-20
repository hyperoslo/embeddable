Rails.application.routes.draw do

  mount Embeddable::Engine => "/embeddable"
end
