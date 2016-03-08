module Errors

  def check_valid_action
    return @error.empty? ? true : false
  end

  def get_error_message
    return @error
    @error = []
  end

end