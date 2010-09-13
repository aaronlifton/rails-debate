module ArgumentsHelper
    def render_thread(parent, options = {})
        options.reverse_merge!(:argument => parent, :show_children => true, :allow_reply => true)
        render :partial => "arguments/argument", :locals => options
    end
    
    def render_threads(parents, options = {})
        options.reverse_merge!(:show_children => true, :allow_reply => true)
        render :partial => "arguments/argument", :collection => parents, :locals => options
    end
end
