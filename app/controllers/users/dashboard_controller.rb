class Users::DashboardController < ApplicationController
  def show
    @user = User.find(params[:id])
    @fields = @user.field_details
    @formulas = @user.field_details.collect(&:recrutation_formula)
  end

  private

  # RegEx 1: \(([^()]+)\) -> Match elements in parentheses
  # RegEx 2: [^(].+?(#{subject.name}).+?(?=\))
  # RegEx 3: \(.*?(#{subject.name}).*?\)
  # RegEx 4: \((?:(?!#{subject_to_not_include}).)*?\)
  
  def count_points(user, formulas)
    formulas.each do |formula|
      user.matura_subjects.each do |subject|
        if (formula.include? "#{subject.name}_Pp") &&
           !user.matura_results.select {|res| res.matura_subject_id == subject.id && res.level == 'basic'}.nil?
          formula.gsub!("#{subject.name}_Pp", '100'.to_s)
        elsif (formula.include? "#{subject.name}_Pr") && 
              !user.matura_results.select {|res| res.matura_subject_id == subject.id && res.level == 'advanced'}.nil?
          formula.gsub!("#{subject.name}_Pr", '100'.to_s)
        end
      end
    end
    formulas
  end
end
