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
    basicRes = user.matura_results.select { |user_res| user_res.level == 'basic'}
    advancedRes = user.matura_results.select { |user_res| user_res.level == 'advanced'}
    # For each formula
    formulas.each do |formula|
      exps = formula.split('+')
      formula.clear
      # and each element
      exps.each do |exp|
        max = -1
        exp.gsub!(/^[\[]|[\]]$/, '')
        puts "Exp: #{exp}"
        # extract subjects
        subjects = exp.split('|')
        # and for each subjects
        subjects.each do |subject|
          subject.gsub!(/^[\(]|[\)]$/, '')
          subject_name = subject.match(/.*_../)[0]
          # replace its name with users result
          if basicRes.map(&:matura_subject).map { |subject| subject.name+"_Pp" }.include?(subject_name)
            subject.gsub!(subject_name, basicRes.detect { |result| result.matura_subject.name+"_Pp" == subject_name}.result.to_s)
            # assign evaluated value to max
            if (max < eval(subject))
              max = eval(subject)
            end
          elsif advancedRes.map(&:matura_subject).map { |subject| subject.name+"_Pr" }.include?(subject_name)
            subject.gsub!(subject_name, advancedRes.detect { |result| result.matura_subject.name+"_Pr" == subject_name}.result.to_s)
            # assign evaluated value to max
            if (max < eval(subject))
              max = eval(subject)
            end
          else
            # if no user result assign '0'
            subject.gsub!(subject_name, '0')
          end
        end
        # replace first element with max value
        exp.replace(max.to_s)
        # replace formula with calculated elements
        formula << exp << "+"
      end
    end
  end
end
