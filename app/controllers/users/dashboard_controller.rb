class Users::DashboardController < ApplicationController
  def show
    @user = User.find(params[:id])
    @fields = @user.field_details
    @formulas = @user.field_details.collect(&:recrutation_formula)
    count_points(@user, @formulas)
  end

  private

  # RegEx 1: \(([^()]+)\) -> Match elements in parentheses
  # RegEx 2: [^(].+?(#{subject.name}).+?(?=\))
  # RegEx 3: \(.*?(#{subject.name}).*?\)
  # RegEx 4: \((?:(?!#{subject_to_not_include}).)*?\)
  
  def count_points(user, formulas)
    formulas.each do |formula|
      exps = formula.split('+')
      exps.each do |exp|
        exp.gsub!(/^[\[]|[\]]$/, '')
        puts "Exp: #{exp}"
        subjects = exp.split('|')
        subjects.each do |subject|
          subject.gsub!(/^[\(]|[\)]$/, '')
          subject_name = subject.match(/.*_../)[0]
          puts "Subject name: #{subject_name}"
          if (user.matura_subjects.select { |user_sub| "#{user_sub.name}_Pr" == subject_name })
            puts "Podmiana #{subject_name} na wynik."
            exp.gsub!(subject_name, '45')
          else
            puts "Usuwanie #{subject_name}."
            exp.gsub!(subject, '')
          end
        end
      end
    end
  end
end
