class SideSweeper < ActionController::Caching::Sweeper
  observe Side
 
  def after_create(side)
          expire_cache_for(side)
  end
 
  def after_update(side)
          expire_cache_for(side)
  end
 
  def after_destroy(side)
          expire_cache_for(side)
  end
 
  private
  def expire_cache_for(side)
    expire_action(:controller => 'debates', :action => 'show', :id => side.debate.id)
    sides.users.each do |u|
      expire_action(:controller => 'users', :action => 'sides', :id => u.name)
    end
  end
end