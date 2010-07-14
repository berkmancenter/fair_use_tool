ActionController::Routing::Routes.draw do |map|
  map.namespace('cms') {|cms| cms.content_blocks :user_answers }

  map.namespace('cms') {|cms| cms.content_blocks :surveys }

  map.namespace('cms') {|cms| cms.content_blocks :questions }

  map.namespace('cms') {|cms| cms.content_blocks :cases }

  map.namespace('cms') {|cms| cms.content_blocks :case_answers }

  map.namespace('cms') {|cms| cms.content_blocks :answers }

  
  map.resources :surveys do |survey|
    survey.resources :user_answers
    survey.resources :questions
  end
  map.survey_results '/surveys/:survey_id/results/:session_id', :controller => 'user_answers', :action => 'survey_results'
  map.case_results '/cases/:case_id/surveys/:session_id', :controller => 'user_answers', :action => 'case_results'
  map.new_case_survey 'cases/:case_id/surveys/:survey_id/case_answers/new', :controller => 'case_answers', :action => 'new'
  map.edit_case_survey 'cases/:case_id/surveys/:survey_id/case_answers/edit', :controller => 'case_answers', :action => 'edit'
  map.case_survey 'cases/:case_id/surveys/:survey_id/case_answers/create', :controller => 'case_answers', :action => 'create'
    
  map.routes_for_browser_cms
  map.resources :case_answers
  map.resources :cases

  map.resources :user_answers, :has_one => :survey
  map.resources :case_answers, :has_one => :survey

  map.resources :questions, :has_many => :answers

  map.resources :answers
  
  map.survey_results 'surveys/:user_id/results', :controller => 'user_answers', :action => 'results'
  map.user_promote '/users/promote/:id', :controller => 'users', :action => 'promote'


  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
