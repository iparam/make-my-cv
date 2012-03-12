module UsersHelper
 def options_for_education_year
    (1970...2020).to_a.collect {|x| x}
  end
end
