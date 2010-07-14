module ApplicationHelper
  # No longer currently employed, but can be in the CMS if you want to go through
  # the pain of getting ajax nested forms working on the renders for models.
  def remove_child_link(name, f)
    f.hidden_field(:_delete) + link_to(name, "javascript:void(0);", :class => "remove_child")
  end
  
  # No longer currently employed, but can be in the CMS if you want to go through
  # the pain of getting ajax nested forms working on the renders for models.
  def add_child_link(name, association)
    link_to(name, "javascript:void(0);", :class => "add_child", :"data-association" => association)
  end
  
  # No longer currently employed, but can be in the CMS if you want to go through
  # the pain of getting ajax nested forms working on the renders for models.
  def new_child_fields_template(form_builder, association, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(association).klass.new
    options[:partial] ||= association.to_s.singularize
    options[:form_builder_local] ||= :f
    
    content_tag(:div, :id => "#{association}_fields_template", :style => "display: none") do
      form_builder.fields_for(association, options[:object], :child_index => "new_#{association}") do |f|
        render(:partial => options[:partial], :locals => {options[:form_builder_local] => f})
      end
    end
  end
  
  # Given a set of results (either UserAnswer or CaseAnswer array)
  # calculate a hash of totals that ends up looking like this:
  # {
  # result.id => {"red" => 0, "green" => 1},
  # result.id => {"red" => "1/2", "green" => "1/2"},
  # result.id => {"red" => 0, "green" => 1},
  # result.id => {"red" => 1, "green" => 0},
  # }
  def red_green_totals(results)
    rg_totals = {}
    results.each do |r|
      rg = {"red" => 0, "green" => 0}
      rg_totals["#{r.id}"] = rg
      if r.answer.value < 0
        rg_totals["#{r.id}"]["red"] = 1
      elsif r.answer.value == 0
        rg_totals["#{r.id}"]["red"] = "1/2"
        rg_totals["#{r.id}"]["green"] = "1/2"
      elsif r.answer.value > 0
        rg_totals["#{r.id}"]["green"] = 1
      end
    end
    return rg_totals
  end
  
  # Given a set of results (either UserAnswer or CaseAnswer array)
  # calculate the final value of these rulings to determine score, but only return 
  # if this case had to be tie_broken with any tie_breaker questions.
  def judgement(results)
    if !results.empty?
      judgement = results.collect{|r| r.answer.value }.compact.sum
      if judgement == 0
        tie_broken_judgement = 0
        results.each do |r|
          if r.answer.tiebreaker?
            tie_broken_judgement += r.answer.value*2
          else
            tie_broken_judgement += r.answer.value
          end
        end
        return true
      else return false
      end
    else
      return "No Case Judgement Entered"
    end
  end
  
  # If the user doesn't have an actual session_id, cookies
  # are likely disabled. Instead, just fake it. Build a temp session_id 
  # random hash, then pass this into the answers instead, and pass through
  # the UserAnswer controller as if it were the session_id instead.
  def resolve_session(session)
    cookies_disabled = false
    if session.nil?
      session = {}
      session[:session_id] = Digest::MD5.hexdigest(Time.now.to_s+rand(10000).to_s)
      cookies_disabled = !cookies_disabled
    elsif session[:session_id].nil?
      session[:session_id] = Digest::MD5.hexdigest(Time.now.to_s+rand(10000).to_s)
      cookies_disabled = !cookies_disabled
    end
    return session[:session_id], cookies_disabled
  end
  
end