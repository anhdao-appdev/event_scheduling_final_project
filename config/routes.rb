Rails.application.routes.draw do

  # HOMEPAGE REDIRECT
  get("/",{:controller => "user_authentication", :action => "sign_in_form"})

  # Routes for the Participant resource:

  # CREATE
  post("/insert_participant", { :controller => "participants", :action => "create" })
          
  # READ
  get("/user_events", { :controller => "participants", :action => "user_events" })
  
  get("/user_events/rsvp/:path_id", { :controller => "participants", :action => "attendance" })

  # UPDATE
  
  post("/modify_participant/:path_id", { :controller => "participants", :action => "update" })
  
  # DELETE
  get("/delete_participant/:path_id", { :controller => "participants", :action => "destroy" })

  #------------------------------

  # Routes for the Event resource:

  # CREATE
  
  get("/new_event", { :controller => "events", :action => "new_event_form"})
  
  post("/insert_event", { :controller => "events", :action => "create" })
          
  # READ

  get("/events", { :controller => "events", :action => "calendar" })

  get("/events/:path_id", { :controller => "events", :action => "detail" })
  
  get("/events/:path_id/modify", { :controller => "events", :action => "edit_form" })

  # UPDATE
  
  post("/modify_event/:path_id", { :controller => "events", :action => "update" })
  
  # DELETE
  get("/delete_event/:path_id", { :controller => "events", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

end
