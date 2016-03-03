MyApp.before "/rooms*" do 
    @current_user = User.find_by_id(session[:user_id])
    if @current_user == nil
        redirect :"/login"
    end
end

MyApp.get "/buildings/:building_id/rooms/create" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  erb :"/rooms/create_room"
end 

MyApp.post "/buildings/:building_id/rooms/create/confirmation" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.new
  @room.title = params[:title]
  @room.room_image = params[:room_image]
  @room.location = params[:location_radio]
  @room.building_id = @building.id
  @room.created_by = @current_user.id
  @error_check = @room.create_room_check_valid_action
  

  if @error_check.empty? == false
    @error = true
    erb :"/rooms/create_room"
  else
    @room.save
    redirect :"/buildings/#{@building.id}"
  end
end

MyApp.get "/buildings/:building_id/rooms/:room_id" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.find_by_id(params[:room_id])
  @creator = @room.get_created_by_user_info_for_room
  @editor = @room.get_updated_by_user_info_for_room
  @damaged_items = @room.find_room_items_in_bad_condition
  @undamaged_items = @room.find_room_items_in_good_condition

  if @damaged_items == nil
    @no_damages_error = true
  end

  if @undamaged_items == nil
    @no_undamaged_items_error = true
  end
  erb :"/rooms/view_room"
end 

MyApp.get "/buildings/:building_id/rooms/:room_id/update" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.find_by_id(params[:room_id])
  erb :"/rooms/update_room"
end 

MyApp.post "/buildings/:building_id/rooms/:room_id/update/confirmation" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.find_by_id(params[:room_id])
  @room.title = params[:update_title]
  @room.room_image = params[:update_room_image]
  @room.location = params[:update_location_radio]
  @room.building_id = @building.id
  @room.updated_by = @current_user.id
  @error_check = @room.create_room_check_valid_action
  

  if @error_check.empty? == false
    @error = true
    erb :"/rooms/update_room"
  else
    @room.save
    redirect :"/buildings/#{@building.id}/rooms/#{@room.id}"
  end
end

MyApp.get "/buildings/:building_id/rooms/:room_id/delete" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.find_by_id(params[:room_id])
  erb :"/rooms/delete_room"
end 

MyApp.post "/buildings/:building_id/rooms/:room_id/delete/confirmation" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.find_by_id(params[:room_id])
  @room.find_and_delete_item_photos_for_room
  @room.find_and_delete_items_for_room
  @room.delete
  redirect :"/buildings/#{@building.id}"
end 
