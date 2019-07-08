localized do
  resource :account, controller: "account", only: [:show, :update, :delete] do
    get :erase, on: :collection
  end
end
