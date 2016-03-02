MyApp.before "/buildings*" do 
    @current_user = User.find_by_id(session[:user_id])
    if @current_user == nil
        redirect :"/login"
    end
end

MyApp.get "/buildings/history" do 
    @current_user = User.find_by_id(session[:user_id])
    @rent_info = @current_user.find_user_renter_building_info
    if @rent_info.empty? == true
      @no_renter_info_error = true
    else
      @past_buildings = @current_user.past_building_info_for_renter_based_on_user_id
        if @past_buildings.empty?
          @no_previous_building_error = true
        end
    end
    erb :"/buildings/view_past_buildings"
end

MyApp.get "/buildings/create" do
  @current_user = User.find_by_id(session[:user_id])
  erb :"/buildings/create_building"
end 
