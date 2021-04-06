class SubdomainConstraint
  def self.matches?(request)
    subdomains = ['www', 'admin', 'help', 'info', 'contact']
    request.subdomain.present? && !subdomains.include?(request.subdomain)
  end
end

Rails.application.routes.draw do
  devise_for :customers, controllers: {
    confirmations: 'customers/confirmations',
    #omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations',
    sessions: 'customers/sessions',
    unlocks: 'customers/unlocks',
    invitations: 'customers/invitations'
  }
  
  constraints SubdomainConstraint do
    resources :users
    # default, username password
    comfy_route :cms_admin, path: "/admin"
    comfy_route :blog, path: "blog"
    comfy_route :blog_admin, path: "admin"
    comfy_route :cms, path: "/"

  end

  root to: 'content#index'
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end