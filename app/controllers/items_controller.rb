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
  @item = Item.new
  erb :"/items/create_item"
end 

MyApp.post "/buildings/:building_id/rooms/:room_id/features/create/confirmation" do
  @current_user = User.find_by_id(session[:user_id])
  @building = Building.find_by_id(params[:building_id])
  @room = Room.find_by_id(params[:room_id])
  @item = Item.new(:title => params[:title], :description => params[:item_description], :condition => params[:condition], :room_id => @room.id, :created_by => @current_user.id, :updated_by => @current_user.id)
  if @item.valid?
    @item.save
    photos = params[:images]
    photos.each do |photo|
      Photo.create(:item_id => @item.id, :image => photo)
    end
    redirect :"/buildings/#{@building.id}/rooms/#{@room.id}/features/#{@item.id}"
  else
    erb :"/items/create_item"
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
  @photos = @item.get_item_photos

  if @photos == nil
    @no_photos = true
  end
  
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
  @item.update(:title => params[:title], :description => params[:description], :condition => params[:condition], :updated_by => @current_user.id)
  @photos = @item.photos


  if @item.valid?
    @item.save
    if !params[:images].nil?
      @photos.delete
      photos = params[:images]
      photos.each do |photo|
        Photo.create(:item_id => @item.id, :image => photo)
      end
   end
    redirect :"/buildings/#{@building.id}/rooms/#{@room.id}/features/#{@item.id}"
  else
    erb :"/items/update_item"
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