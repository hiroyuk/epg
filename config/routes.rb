Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  match 'timetable/channels', :via => :get
  match 'timetable/programs', :via => :get
  match 'timetable/reservations', :via => :get

end
