class UsersController < Clearance::UsersController
  respond_to :html
  
  def index
    respond_with(@users = User.all)
  end

  def show
    @user = User.find_by_name(params[:id])
    @arguments = @user.arguments
    respond_with(@user)
  end
  
  def arguments
    @user = User.find_by_name(params[:id])
    @arguments = @user.arguments
    render :action => "show"
  end
  
  def sides
    @user = User.find_by_name(params[:id])
    @sides = @user.sides
    respond_with(@user)
  end
  
  def debates
    @user = User.find_by_name(params[:id])
    @debates = @user.debates
    respond_with(@user)
  end

  def edit
    @user = User.find_by_name(params[:id])
    respond_with(@user)
  end
  
  def update
    @user = User.find_by_name(params[:id])
    @user.update_attributes(params[:user])
    respond_with(@user)
  end
end
