Rails.application.routes.draw do
  resources :fuel_to_vehicles
  resources :fuel_loads
  resources :fuel_truks
  root 'main#welcome'
  get 'main/welcome'

  resources :people_clothes, only: [:index, :show,:new, :create, :edit, :update]
  post 'disable_people_clothe', to: 'people_clothes#disable', as: 'disable_people_clothe'
  resources :clothes, only: [:index, :new, :create, :edit, :update]
  post 'disable_clothe', to: 'clothes#disable', as: 'disable_clothe'
  resources :clothing_packages
  post 'disable_clothing_package', to: 'clothing_packages#disable', as: 'disable_clothing_package'
  resources :insurances
  resources :vehicle_insurances do 
    get 'show_files', on: :collection
  end
  post 'disable_insurance', to: 'insurances#disable', as: 'disable_insurance'

  resources :vehicles, except: [:destroy] do 
    get 'show_images', on: :member
    get 'get_images', on: :member
    get 'show_vehicle_history', on: :member
    get 'modal_enable_vehicle', on: :member
    get 'inactive', on: :collection
    post :delete_image_attachment, on: :collection
  end
  post 'disable_vehicle', to: 'vehicles#disable', as: 'disable_vehicle'

  # get 'vehicles/:id/show_vehicle_history', to: 'vehicles#show_vehicle_history', as: 'show_vehicle_history'
  # get 'vehicles/:id/modal_enable_vehicle', to: 'vehicles#modal_enable_vehicle', as: 'modal_enable_vehicle'
  post 'vehicles/enable_vehicle', to: 'vehicles#enable_vehicle', as: 'enable_vehicle'
  resources :vehicle_locations
  resources :vehicle_models
  resources :vehicle_brands
  resources :vehicle_types
  

  namespace :authentication, path: '', as: '' do
    resources :users, only: [:index,:new, :create, :edit, :update]
      post 'disable_user', to: 'users#disable', as: 'disable_user'
    resources :sessions, only: [:create]
    get 'login', to: 'sessions#new', as: 'login'
    get 'logout', to: 'sessions#destroy', as: 'logout'
  end
  
  get 'person_dato_disponible', to: 'people#dato_disponible', as: 'person_dato_disponible'
  get '/people/:id/upload_person_file/:file', to: 'people#upload_person_file', as: 'upload_person_file'
  resources :people, except: [:destroy]
  post 'disable_person', to: 'people#disable', as: 'disable_person'
  get 'inactive_people', to: 'people#inactives', as: 'inactive_people'
  get 'people/:id/show_person_history', to: 'people#show_person_history', as: 'show_person_history'
  get 'people/:id/modal_enable_person', to: 'people#modal_enable_person', as: 'modal_enable_person'
  post 'people/enable_person', to: 'people#enable_person', as: 'enable_person'
  resources :companies, except: [:destroy, :show]
  post 'disable_company', to: 'companies#disable', as: 'disable_company'
  resources :profiles, except: [:destroy, :show]
  post 'disable_profile', to: 'profiles#disable', as: 'disable_profile'
  resources :documents
  post 'disable_document', to: 'documents#disable', as: 'disable_document'
  resources :document_categories
  resources :expiration_types
  
  get 'documents_profiles/:id/modal_disable', to: 'documents_profiles#modal_disable', as: 'modal_disable_document_profile'
  resources :documents_profiles, except: [:destroy, :show]
  post 'disable_document_profile', to: 'documents_profiles#disable', as: 'disable_document_profile'
  
  resources :people_profiles, except: [:destroy, :show]
  resources :vehicles_profiles, except: [:destroy, :show] 

  resources :assignments_profiles, except: [:index, :destroy]
  post 'disable_assignment_profile', to: 'assignments_profiles#disable', as: 'disable_assignment_profile'
  post 'reactive_profile_assignment_profile', to: 'assignments_profiles#reactive_profile', as: 'reactive_profile_assignment_profile'

  resources :assignments_documents, except: [:index, :destroy]
  get 'assignments_documents/:id/modal_disable', to: 'assignments_documents#modal_disable', as: 'modal_disable_assignments_documents'
  post 'disable_assignments_documents', to: 'assignments_documents#disable', as: 'disable_assignments_documents'

  get 'status_documentation/people'
  get 'status_documentation/vehicles'

  resources :document_renovations do 
    get 'show_files'
  end
  post 'disable_document_renovation', to: 'document_renovations#disable', as: 'disable_document_renovation'

  resources :reasons_to_disables, except: [:destroy, :show]
  post 'disable_reason', to: 'reasons_to_disables#disable', as: 'disable_reason'

  resources :reports, only: [:index] do
    get 'people', on: :collection
    get 'matriz', on: :collection
  end
end
