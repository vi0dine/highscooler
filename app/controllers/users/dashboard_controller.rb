class Users::DashboardController < ApplicationController
  def show
    @user = User.find(params[:id])
    @fields = []
    @formulas = []
    @user.field_of_studies.each do |fos|
      fos.field_details.each do |fd|
        @fields << fd
        @formulas << fd.recrutation_formula
      end
    @formulas << count_points(@user, @formulas)
    end
  end

  private

  # RegEx 1: \(([^()]+)\) -> Match elements in parentheses
  # RegEx 2: [^(].+?(#{subject.name}).+?(?=\))

  def count_points(user, formulas)
    formulas.each do |formula|
      user.matura_subjects.each do |subject|
        if (formula.include? "#{subject.name}_Pp") && 
           !user.matura_results.select {|res| res.matura_subject_id == subject.id && res.level == 'basic'}.nil?
          formula.gsub!(/[^(].*?(#{subject.name}).*?(?=\))/, "100".to_s)
        elsif (formula.include? "#{subject.name}_Pr") && 
              !user.matura_results.select {|res| res.matura_subject_id == subject.id && res.level == 'advanced'}.nil?
          formula.gsub!(/[^(].*?(#{subject.name}).*?(?=\))/, "100".to_s)
        end
      end
    end
    formulas
  end
end
