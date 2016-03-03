require 'test_helper'

class LoginTest < Minitest::Test

  def app
    MyApp
  end

  def setup
    super
    @current_user = User.new
    @current_user.id = 1
    @current_user.name = ""
    @current_user.email = "www.test@email.com"
    @current_user.password = ""
    @current_user.save

    @other_user = User.new
    @other_user.id = 2
    @other_user.name = "bob"
    @other_user.email = ""
    @other_user.password = "password"
    @other_user.save
  end

## LOGIN TESTS - START

  def test_check_create_user_email_is_valid
      assert_equal(true, @current_user.check_create_user_email_is_valid)
      assert_equal(false, @other_user.check_create_user_email_is_valid)
  end

  def test_check_create_user_name_is_valid
      assert_equal(false, @current_user.check_create_user_name_is_valid)
      assert_equal(true, @other_user.check_create_user_name_is_valid)
  end

  def test_check_create_user_password_is_valid
      assert_equal(false, @current_user.check_create_user_password_is_valid)
      assert_equal(true, @other_user.check_create_user_password_is_valid)
  end  

  def test_create_user_check_valid_action
    assert_equal(["Please include your name.", "Please include a password."], @current_user.create_user_check_valid_action)
    assert_equal(["Please include your email."], @other_user.create_user_check_valid_action)
  end

  ## LOGIN TESTS - END

end  