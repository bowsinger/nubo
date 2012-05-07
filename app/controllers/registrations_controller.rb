class RegistrationsController < Devise::RegistrationsController
  layout 'noajax'
  def new 
    redirect_to '/'
  end
  
  def create 
    redirect_to '/'
  end

  # GET /resource/sign_out
  def destroy
    super
  end

end
