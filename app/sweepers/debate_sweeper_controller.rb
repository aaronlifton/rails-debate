class DebateSweeper < ActionController::Caching::Sweeper
  observe Debate
 
  def after_create(debate)
          expire_cache_for(debate)
  end
 
  def after_update(debate)
          expire_cache_for(debate)
  end
 
  def after_destroy(debate)
          expire_cache_for(debate)
  end
 
  private
  def expire_cache_for(debate)
    expire_page(:controller => 'home', :action => 'index')
    expire_page(:controller => 'debates', :action => 'index')
    expire_action(:controller => 'debates', :action => 'show', :id => debate.id)
    debate.tags.each do |t|
      expire_action(:controller => 'tag', :action => 'show', :id => t.name)
    end
    expire_action(:controller => 'users', :action => 'debates', :id => debate.user.name)
  end
end