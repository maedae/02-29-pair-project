MyApp.before "/users*" do 
    @current_user = User.find_by_id(session[:user_id])
    if @current_user == nil
        redirect :"/login"
    end
end

MyApp.get "/home" do
  @current_user = User.find_by_id(session[:user_id])
    if @current_user == nil
        redirect :"/login"
    else 
      arr_renters = []
      @renters = Renter.where({"user_id" => @current_user.id})
      @renters.each do |r|
        arr_renters << r.building_id
      end
      @past_buildings = []
      @open_building = []

      arr_renters.each do |r|
        
        building = Building.find_by_id(r)
        if building.locked == true
          @past_buildings << building
        else 
          @open_building << building
        end
      end
      erb :"/users/view_user_dashboard"
    end
end