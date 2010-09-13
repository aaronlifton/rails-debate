class SessionsController < Clearance::SessionsController
   def create
    @user = User.authenticate(params[:session][:name],
                              params[:session][:password])
    if @user.nil?
      flash_failure_after_create
      render :template => 'sessions/new', :status => :unauthorized
    else
      sign_in(@user)
      flash_success_after_create
      redirect_back_or(url_after_create)
    end
  end
  
  def flash_failure_after_create
    flash.now[:failure] = "Bad name or password"
  end
end