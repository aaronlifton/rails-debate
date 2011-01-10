class TagSweeper < ActionController::Caching::Sweeper
  observe ActiveRecord::Base::Tag
 
  def after_create(tag)
          expire_cache_for(tag)
  end
 
  def after_update(tag)
          expire_cache_for(tag)
  end
 
  def after_destroy(tag)
          expire_cache_for(tag)
  end
 
  private
  def expire_cache_for(tag)
    expire_page(:controller => 'tag', :action => 'index')
    expire_action(:controller => 'tag', :action => 'show', :id => tag.name)
    
    debates = Debate.all.select {|d| d.tags.map(&:name).include?(tag.name)}
    if debates.size > 0
      debates.each do |d|
        expire_action(:controller => 'debates', :action => 'show', :id => d.id)
      end
      expire_page(:controller => 'debates', :action => 'index')
    end
  end
end