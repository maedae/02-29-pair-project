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
