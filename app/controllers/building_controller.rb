MyApp.before "/buildings*" do 
    @current_user = User.find_by_id(session[:user_id])
    if @current_user == nil
        redirect :"/login"
    end
end

MyApp.get "/buildings/create" do
  @building = Building.new
  @current_user = User.find_by_id(session[:user_id])
  erb :"/buildings/create_building"
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
  @creator = User.find_by_id(@building.created_by)
  @editor = @building.get_updated_by_user_info
  @rooms = @building.find_rooms_for_building 
      
  if @rooms == nil
    @no_current_room_error = true
  end
  erb :"/buildings/view_one_building"
end

MyApp.get "/buildings/:building_id/image" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  erb :"/buildings/view_large_building_image"
end

MyApp.post "/buildings/create/confirmation" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.new(:address => params[:address], :apt_no => params[:apt], :city => params[:city], :state => params[:state], :zip_code => params[:zip], :landlord_name => params[:landlord], :building_image => params[:rental_image], :move_in => params[:move_in_date], :move_out => params[:move_out_date], :created_by => @current_user.id, :locked => false)

  if @building.valid?
    @building.save
    
    @renter = Renter.new
    @renter.user_id = @current_user.id
    @renter.building_id = @building.id
    @renter.save
    redirect :"/buildings/#{@building.id}/rooms/create"
  else
    erb :"/buildings/create_building"
  end
end

MyApp.get "/buildings/:building_id/update" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  erb :"/buildings/update_building"
end 

MyApp.post "/buildings/:building_id/update/confirmation" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @building.address = params[:address]
  @building.apt_no = params[:apt]
  @building.city = params[:city]
  @building.state = params[:state]
  @building.zip_code = params[:zip]
  @building.landlord_name = params[:landlord]

  if params[:update_rental_image] != ""
   @building.building_image = params[:update_rental_image]
 end

  @building.move_in = params[:move_in_date]
  @building.move_out = params[:move_out_date]
  @building.updated_by = @current_user.id
  @building.locked = false
  @error_check = @building.create_building_check_valid_action

  if @error_check.empty? == false
    @error = true
    erb :"/buildings/update_building"
  else
    @building.save

    redirect :"/buildings/#{@building.id}."
  end
end

MyApp.get "/buildings/:building_id/delete" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  erb :"/buildings/delete_building"
end 

MyApp.post "/buildings/:building_id/delete/confirmation" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @building.delete_renter(@current_user.id)
  @building.check_if_building_has_other_renters
  redirect :"/home"
end 
