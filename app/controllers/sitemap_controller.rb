class SitemapController < ApplicationController
  layout nil
  
  def index
    headers['Content-Type'] = 'application/xml'
    latest = Debate.last
    if stale?(:etag => latest, :last_modified => latest.updated_at.utc)
      respond_to do |format|
        format.xml { @debates = Debate.find(:all, :limit => 49999) }
      end
    end
  end
end