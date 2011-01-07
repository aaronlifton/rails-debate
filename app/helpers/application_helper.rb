module ApplicationHelper
  def title(subtitle=false)
    default = "DebateZone"
    if subtitle
        [default, subtitle].join(' - ')
    else
        default
    end
  end
  
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + button_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, [new_object], :child_index => "new_#{association}") do |builder|
        render(association.to_s.singularize + "_fields", :f => builder)
    end
    button_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
  
  def selected(sort,reverse,sort1,reverse1)
	if sort==sort1 || sort.nil? && sort1=="date"
		return "selected"
	else
		return nil
	end
  end
  
  def uberform(options={})
    { :nested => nil }.merge(options)
    unless options[:nested].nil?
        ordered_nested = ActiveSupport::OrderedHash.new
        if options[:nested].is_a?(Array)
            options[:nested].each do |nested_model|
                ordered_nested[nested_model] = options[:model].class.reflect_on_association(nested_model).klass
            end
        else
            ordered_nested[options[:nested]] = options[:model].class.reflect_on_association(options[:nested]).klass
        end
    end
    render :partial => "shared/form", :locals => { :model => options[:model], :fields => options[:model].class.fields, :nested => ordered_nested }
  end
end