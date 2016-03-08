MyApp.get "/" do
  erb :"/users/user_login"
end

MyApp.get "/login" do

  @date = Date.new

  erb :"/users/user_login"
end

MyApp.post "/login/confirmation" do
  if User.exists?(:email => params[:email]) == false
    @invalid_email = true
    erb :"/users/user_login"
  else
  @current_user = User.find_by_email(params[:email])
    if @current_user.password != params[:password]
      @invalid_password = true
      erb :"/users/user_login"
    else
      session["user_id"] = @current_user.id
      redirect :"/home"
    end
  end
end

MyApp.post "/logout" do
  @current_user = User.find_by_id(session[:user_id])
  if @current_user == nil
     redirect :"/login"
  else
    session[:user_id] = nil
    redirect :"/login"
  end
end

MyApp.get "/create_account" do
  erb :"/users/create_user"
end

MyApp.get "/forgot_password" do
  erb :"/users/forgot_user_password"
end

# handles form data sent from "/users/create"
MyApp.post "/create_account/confirmation" do
  @new_user = User.new
  @new_user.name = params[:name].downcase.capitalize
  @new_user.email = params[:email]
  @new_user.password = params[:password]

  @error_check = @new_user.create_user_check_valid_action

  # checks to see if error array value is empty.
  # If variable is not empty, error flag is set and user is redirect back to create page.
  
  if @error_check.empty? == false
    @error = true
    erb :"/users/create_user"

  # Next, it will check to see if the user email selected already exists. 
  # If it does, error flag is set && user is directed to the create page with a different message.
  elsif User.exists?(:email => params[:email]) == true
    @matching_user_error = true 
    erb :"/users/create_user"

  # If neither of the aformentioned scenarios occur, user if directed to customized home page
  else
    @new_user.save
    session[:user_id] = @new_user.id  
    redirect :"/home"
  end
end

