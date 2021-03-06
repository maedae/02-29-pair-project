MyApp.before "/rooms*" do 
    @current_user = User.find_by_id(session[:user_id])
    if @current_user == nil
        redirect :"/login"
    end
end

MyApp.get "/buildings/:building_id/rooms/create" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.new
  erb :"/rooms/create_room"
end 

MyApp.post "/buildings/:building_id/rooms/create/confirmation" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.new(:title => params[:title], :location => params[:location_radio], :building_id => @building.id, :created_by => @current_user.id, :updated_by => @current_user.id, :room_image => params[:room_image])
  if @room.valid?
    @room.save
    redirect :"/buildings/#{@building.id}/rooms/#{@room.id}/features/create"
  else
    erb :"/rooms/create_room"
  end
end

MyApp.get "/buildings/:building_id/rooms/:room_id" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.find_by_id(params[:room_id])
  @creator = @room.find_created_by_user_info_for_room
  @editor = @room.find_updated_by_user_info_for_room
  @damaged_items = @room.find_damaged_items_for_room
  @good_items = @room.find_good_items_for_room
  if @damaged_items == nil
    @no_damaged_items_error = true
  end

  if @good_items == nil
    @no_undamaged_items_error = true
  end
  erb :"/rooms/view_room"
end 

MyApp.get "/buildings/:building_id/rooms/:room_id/image" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.find_by_id(params[:room_id])
  erb :"/rooms/view_large_room_image"
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
  @room.update(:title => params[:update_title], :room_image => params[:update_room_image], :location => params[:update_location_radio], :building_id => @building.id, :updated_by => @current_user.id)
  if params[:room_image] != nil 
   @room.room_image = params[:room_image]
  end
  if @room.valid?
     @room.save
    redirect :"/buildings/#{@building.id}/rooms/#{@room.id}"
  else
    erb :"/rooms/update_room"
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
  item_ids = @room.find_items_id_array_for_room

  if item_ids != nil
    @room.find_and_delete_item_photos_for_room(item_ids)
    @room.find_and_delete_items_for_room
    @room.delete
    redirect :"/buildings/#{@building.id}"
  else
    @room.delete
    redirect :"/buildings/#{@building.id}"
  end
end 
