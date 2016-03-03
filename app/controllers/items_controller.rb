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