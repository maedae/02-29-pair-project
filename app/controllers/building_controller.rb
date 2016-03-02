MyApp.before "/buildings*" do 
    @current_user = User.find_by_id(session[:user_id])
    if @current_user == nil
        redirect :"/login"
    end
end

MyApp.get "/buildings/history" do 
    @current_user = User.find_by_id(session[:user_id])
    @past_building = @current_user.past_building_info_for_renter_based_on_user_id
  
     if @past_building == nil
        @no_previous_building_error = true
    end
    erb :"/buildings/view_past_buildings"
end

MyApp.get "/buildings/:building_id" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @rooms = @building.find_rooms_for_building 
      
  if @rooms == nil
    @no_current_room_error = true
  end

  erb :"/buildings/view_one_building"
end

MyApp.get "/buildings/create" do
  @current_user = User.find_by_id(session[:user_id])
  erb :"/buildings/create_building"
end 

MyApp.post "/buildings/create/confirmation" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.new
  @building.address = params[:address]
  @building.apt_no = params[:apt]
  @building.city = params[:city]
  @building.state = params[:state]
  @building.zip_code = params[:zip]
  @building.landlord_name = params[:landlord]
  @building.building_image = params[:rental_image]
  @building.move_in = params[:move_in_date]
  @building.move_out = params[:move_out_date]
  @building.created_by = @current_user.id
  @building.locked = false
  @building.save

  @renter = Renter.new
  @renter.user_id = @current_user.id
  @renter.building_id = @building.id
  @renter.save
  
  redirect :"/home"
end

MyApp.get "/buildings/:building_id/update" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  erb :"/buildings/update_building"
end 

