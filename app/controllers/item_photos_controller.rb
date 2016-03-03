MyApp.before "/buildings*" do 
    @current_user = User.find_by_id(session[:user_id])
    if @current_user == nil
        redirect :"/login"
    end
end

MyApp.get "/buildings/:building_id/rooms/:room_id/features/:item_id/add_photo" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.find_by_id(params[:room_id])
  @item = Item.find_by_id(params[:item_id])
  erb :"/items/add_item_photo"
end 

MyApp.post "/buildings/:building_id/rooms/:room_id/features/:item_id/add_photo/confirmation" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.find_by_id(params[:room_id])
  @item = Item.find_by_id(params[:item_id])

  @photo = Photo.new
  @photo.item_id = @item.id
  @photo.image = params[:item_image]

  if params[:item_image] == nil
    @error = true
    erb :"/items/add_item_photo"
  else
    @photo.save
    redirect :"/buildings/#{@building.id}/rooms/#{@room.id}/features/#{@item.id}/add_photo/confirmation/success"
  end
end 

MyApp.get "/buildings/:building_id/rooms/:room_id/features/:item_id/add_photo/confirmation/success" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.find_by_id(params[:room_id])
  @item = Item.find_by_id(params[:item_id])
  @added_image = true
  erb :"/items/add_item_photo"
end

MyApp.get "/buildings/:building_id/rooms/:room_id/features/:item_id/images/delete" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.find_by_id(params[:room_id])
  @item = Item.find_by_id(params[:item_id])
  @photos = @item.get_item_photos

  if @photos == nil
    @no_photos_error = true
  end
  erb :"/items/delete_item_images"
end

MyApp.get "/buildings/:building_id/rooms/:room_id/features/:item_id/images/:photo_id" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.find_by_id(params[:room_id])
  @item = Item.find_by_id(params[:item_id])
  @photo = Photo.find_by_id(params[:photo_id])
  erb :"/items/view_item_photo"
end

