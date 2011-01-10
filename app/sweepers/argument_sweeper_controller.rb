class ArgumentSweeper < ActionController::Caching::Sweeper
  observe Argument
 
  def after_create(argument)
          expire_cache_for(argument)
  end
 
  def after_update(argument)
          expire_cache_for(argument)
  end
 
  def after_destroy(argument)
          expire_cache_for(argument)
  end
 
  private
  def expire_cache_for(argument)
    unless argument.user_id.nil?
      expire_action(:controller => 'users', :action => 'show', :id => argument.user.name)
      expire_action(:controller => 'users', :action => 'arguments', :id => argument.user.name)
    end
    expire_action(:controller => 'debates', :action => 'show', :id => argument.debate.id)
  end
end