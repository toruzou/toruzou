module ControllerMacros
public 
  def login_user
    controller.stub(:authenticate_user!).and_return true
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in FactoryGirl.create(:user, password: 'hogehoge', password_confirmation: 'hogehoge')
  end
end
