module UsersHelper
  
  def options_for_education_year
    (1970...2020).to_a.collect {|x| x}
  end
  def profile_error_messages(user)
    errors = ""
    if user.errors.present?
        user.errors.full_messages.each do |msg|    
          errors << "<li>#{msg}</li>"
        end
#      user.errors.messages.keys.each do |model_key|
#        user.send(model_key)
#      end

    end
    errors.html_safe
  end
  def exp_title(exp)
    if exp.title.present? && exp.company_name.present?
      "#{exp.title} at #{exp.company_name}"
    elsif exp.title.present?
      "#{exp.title}"
    elsif exp.company_name.present?
      "#{exp.company_name}"
    end  
  end
  
  def exp_date(exp)
   start_date = exp.start_date.strftime("%B %Y") 
   end_date = exp.is_current ? "Present" : exp.end_date.strftime("%B %Y") 
   "#{start_date}  -  #{end_date}"
  end
  
  def calculate_exp_time(start_date,end_date=nil)
    end_date ||= Date.today
    exp_time = "( "
    months = calculate_month(start_date,end_date)
    year = months/12
    month = months%12

    if year > 0
      exp_time << "#{pluralize(year,"year")} "
    end

    exp_time << pluralize(month,"month")
    exp_time << " )"
  end
  
  def calculate_month(start_date,end_date)
    (end_date.month - start_date.month) + 12 * (end_date.year - start_date.year)
  end
  def project_title
    
  end
  def project_duration(project)
    start_date = project.start_date.strftime("%B %Y") 
    end_date = project.is_ongoing ? "Present" : project.end_date.strftime("%B %Y") 
    company_name = project.company_name.present?  ? "| "+project.company_name : ""
    "#{start_date}  to  #{end_date} #{company_name}"
    
  end
  
end
