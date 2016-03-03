MyApp.before "/items*" do 
    @current_user = User.find_by_id(session[:user_id])
    if @current_user == nil
        redirect :"/login"
    end
end

MyApp.get "/buildings/:building_id/rooms/:room_id/features/create" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.find_by_id(params[:room_id])
  erb :"/items/create_item"
end 

MyApp.post "/buildings/:building_id/rooms/:room_id/features/create/confirmation" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.find_by_id(params[:room_id])
  @item = Item.new
  @item.title = params[:title]
  @item.description = params[:item_description]
  @item.condition = params[:condition_radio]
  @item.room_id = @room.id
  @item.created_by = @current_user.id
  @error_check = @item.create_item_check_valid_action
  

  if @error_check.empty? == false
    @error = true
    erb :"/items/create_item"
  else
    @item.save
    redirect :"/buildings/#{@building.id}/rooms/#{@room.id}/features/create/confirmation/success"
  end
end

MyApp.get "/buildings/:building_id/rooms/:room_id/features/create/confirmation/success" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.find_by_id(params[:room_id])
  @added_item = true
  erb :"items/create_item"
end

MyApp.get "/buildings/:building_id/rooms/:room_id/features/:item_id" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.find_by_id(params[:room_id])
  @item = Item.find_by_id(params[:item_id])
  @creator = @item.get_created_by_user_info_for_item
  @editor = @item.get_updated_by_user_info_for_item
  erb :"/items/view_item"
end 

MyApp.get "/buildings/:building_id/rooms/:room_id/features/:item_id/update" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.find_by_id(params[:room_id])
  @item = Item.find_by_id(params[:item_id])
  erb :"/items/update_item"
end 

MyApp.post "/buildings/:building_id/rooms/:room_id/features/:item_id/update/confirmation" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.find_by_id(params[:room_id])
  @item = Item.find_by_id(params[:item_id])
  @item.title = params[:update_title]
  @item.description = params[:update_item_description]
  @item.condition = params[:update_condition_radio]
  @item.updated_by = @current_user.id
  @error_check = @item.create_item_check_valid_action
  

  if @error_check.empty? == false
    @error = true
    erb :"/items/update_item"
  else
    @item.save
    redirect :"/buildings/#{@building.id}/rooms/#{@room.id}/features/#{@item.id}"
  end
end

MyApp.get "/buildings/:building_id/rooms/:room_id/features/:item_id/delete" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.find_by_id(params[:room_id])
  @item = Item.find_by_id(params[:item_id])
  erb :"items/delete_item"
end

MyApp.post "/buildings/:building_id/rooms/:room_id/features/:item_id/delete/confirmation" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.find_by_id(params[:room_id])
  @item = Item.find_by_id(params[:item_id])
  @item.find_and_delete_item_photos
  @item.delete
  redirect :"/buildings/#{@building.id}/rooms/#{@room.id}"
end