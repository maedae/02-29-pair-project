MyApp.before "/users*" do 
    @current_user = User.find_by_id(session[:user_id])
    if @current_user == nil
        redirect :"/login"
    end
end

MyApp.get "/home" do
  @current_user = User.find_by_id(session[:user_id])
    if @current_user != nil
       @current_building = @current_user.current_building_info_for_renter_based_on_user_id
        
        if @current_building == nil
          @no_current_building_error = true
        end
          erb :"/users/view_user_dashboard"
    else 
      redirect :"/login"
    end
end

MyApp.get "/users/update/authenticate" do
  @current_user = User.find_by_id(session[:user_id])
  erb :"/users/update_user_authentication"
end 

MyApp.post "/users/update/authenticate/confirmation" do
  @current_user = User.find_by_id(session[:user_id])
    if @current_user.password != params[:authentication]
      @authentication_error = true
      erb :"/users/update_user_authentication"
    else
      redirect :"/users/update"
    end
end 

MyApp.get "/users/update" do
  @current_user = User.find_by_id(session[:user_id])
  erb :"/users/update_user"
end 

MyApp.post "/users/update/confirmation" do
 @current_user = User.find_by_id(session[:user_id])
 @current_user.name = params[:name].downcase.capitalize
 @current_user.email = params[:email]
 @current_user.password = params[:password]
 @error_check = @current_user.create_user_check_valid_action

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

MyApp.get "/users/delete/authenticate" do
  erb :"/users/delete_user_authentication"
end

MyApp.post "/users/delete/authenticate/confirmation" do
  @current_user = User.find_by_id(session[:user_id])
  if @current_user.password != params[:authentication]
    @authentication_error = true
    erb :"/users/delete_user_authentication"
  else
    @current_user.delete
    session[:user_id] = nil
    redirect :"/login"
  end
end