class UsersController < Clearance::UsersController
  respond_to :html
  #caches_action :show, :arguments, :sides, :debates
  
  def index
  	@users = User.all.sort_by {|u| (u.points.nil? ? 0 : u.points)}.reverse
  	@users = @users.paginate :page => params[:page]
    respond_with(@users)
  end

  def show
    @user = User.find_by_name(params[:id])
   	@arguments = Argument.paginate :page => params[:page], :order => 'created_at DESC',
   		:conditions => { :user_id => @user.id }
    #@arguments = @user.arguments
    respond_with(@user)
  end
  
  def arguments
    @user = User.find_by_name(params[:id])
   	@arguments = Argument.paginate :page => params[:page], :order => 'created_at DESC',
   		:conditions => { :user_id => @user.id }
    render :action => "show"
  end
  
  def sides	
    @user = User.find_by_name(params[:id])
    @sides = @user.sides
	@sides = @sides.paginate :page => params[:page], :order => 'created_at DESC'

    respond_with(@user)
  end
  
  def debates
    @user = User.find_by_name(params[:id])
    @debates = @user.debates.paginate :page => params[:page], :order => 'created_at DESC'
    respond_with(@user)
  end

  def edit
    @user = User.find_by_name(params[:id])
    if @user == current_user
    	respond_with(@user)
    else
    	redirect_to root_path
    end
  end
  
  def update
    @user = User.find_by_name(params[:id])
    @user.update_attributes(params[:user])
    respond_with(@user)
  end
end
