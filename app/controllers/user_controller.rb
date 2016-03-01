MyApp.before "/users*" do 
    @current_user = User.find_by_id(session[:user_id])
    if @current_user == nil
        redirect :"/login"
    end
end

MyApp.get "/home" do
  @current_user = User.find_by_id(session[:user_id])
    if @current_user == nil
        redirect :"/login"
    else 
      @rent_info = @current_user.find_user_renter_building_info
      if @rent_info.empty? == true
         @no_renter_info_error = true
      else
          @past_buildings = @current_user.past_building_info_for_renter_based_on_user_id
          @current_building = @current_user.current_building_info_for_renter_based_on_user_id

          if @past_buildings.empty?
            @no_previous_building_error = true
          end

          if @current_buildings.empty?
             @no_current_building_error = true
           end
      end
      erb :"/users/view_user_dashboard"
    end
end

MyApp.get "/users/:id/authenticate" do
  @current_user = User.find_by_id(session[:user_id])
  erb :"/users/user_authentication"
end 

MyApp.post "/users/:id/authenticate/confirmation" do
  @current_user = User.find_by_id(session[:user_id])
    if @current_user.password != params[:authentication]
      @authentication_error = true
      erb :"/users/user_authentication"
    else
      redirect :"/users/#{session[:user_id]}/update"
    end
end 

MyApp.get "/users/:id/update" do
  @current_user = User.find_by_id(session[:user_id])
  erb :"/users/update_user"
end 

MyApp.post "/users/update/confirmation" do
     @current_user = User.find_by_id(session[:user_id])
     @current_user.name = params[:name].downcase.capitalize
     @current_user.email = params[:email]
     @error_check = @current_user.update_user_check_valid_action

      if @error_check.empty? == false
          @error = true
          erb :"/users/update_user"
      elsif User.where({"email" => @current_user.email}).where.not("id" => @current_user.id).length >= 1
          @duplicate_email_error = true
          erb :"/users/update_user"
      else
        @current_user.save
        redirect :"/home"
      end
end