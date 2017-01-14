module UsersControllerHelper
  def sign_in_helper user
    @user = user
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in @user
  end
end