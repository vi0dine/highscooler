class Users::DashboardController < ApplicationController
  def show
    @user = User.find(params[:id])
    @fields = @user.field_details
    @formulas = @user.field_details.collect(&:recrutation_formula)
    @results = calculate_recrutation_points(@user, @formulas)
    authorize! :read, @user
  end

  def create_interest
    interest = Interested.new(interested_params)
    if interest.save
      flash[:notice] = 'Dodano Cię do listy zainteresowanych'
      redirect_to dashboard_path
    else
      render 'show'
    end
  end

  private

  def interested_params
    params.require(:interested).permit(:user_id, :field_detail_id)
  end

  # RegEx 1: \(([^()]+)\) -> Match elements in parentheses
  # RegEx 2: [^(].+?(#{subject.name}).+?(?=\))
  # RegEx 3: \(.*?(#{subject.name}).*?\)
  # RegEx 4: \((?:(?!#{subject_to_not_include}).)*?\)
  
  def count_points(user, formulas)
    # For each formula
    formulas.each do |formula|
      catch :formula_error do 
        basicRes = user.matura_results.select { |user_res| user_res.level == 'basic' }
        advancedRes = user.matura_results.select { |user_res| user_res.level == 'advanced' }
        max_basic_subject_id = nil
        max_advanced_subject_id = nil
        exps = formula.split('+')
        formula.clear
        # and each element
        exps.each do |exp|
          max = -1
          exp.gsub!(/^[\[]|[\]]$/, '')
          # extract subjects
          subjects = exp.split('|')
          # and for each subjects
          subjects.each do |subject|
            subject.gsub!(/^[\(]|[\)]$/, '')
            subject_name = /.*_../.match(subject)[0]
            # puts subject_name.inspect
            # replace its name with users result
            if basicRes.map(&:matura_subject).map { |sub| sub.name+"_Pp" }.include?(subject_name)
              subject.gsub!(subject_name, basicRes.detect { |result| result.matura_subject.name+"_Pp" == subject_name}.result.to_s)
              # assign evaluated value to max
              begin
                if (max < eval(subject))
                  max = eval(subject)
                  max_basic_subject_id = basicRes.detect { |result| result.matura_subject.name+"_Pp" == subject_name}.id
                end
              rescue SyntaxError
                p "Syntax error in formula"
                throw :formula_error
              end
            elsif advancedRes.map(&:matura_subject).map { |sub| sub.name+"_Pr" }.include?(subject_name)
              subject.gsub!(subject_name, advancedRes.detect { |result| result.matura_subject.name+"_Pr" == subject_name}.result.to_s)
              # assign evaluated value to max
              begin
                if (max < eval(subject))
                  max = eval(subject)
                  max_advanced_subject_id = advancedRes.detect { |result| result.matura_subject.name+"_Pr" == subject_name}.id
                end
              rescue SyntaxError
                p "Syntax error in formula"
                throw :formula_error
              end
            else
              # if no user result assign '0'
              subject.gsub!(subject_name, '0')
            end
          end
          # replace first element with max value
          exp.replace(max.to_s)
          # reject max elements from user results to avoid duplicates
          basicRes.reject! { |res| res.id == max_basic_subject_id }
          advancedRes.reject! { |res| res.id == max_advanced_subject_id}
          # replace formula with calculated elements
          formula << exp << "+"
        end
      end
    end
  end

  def calculate_recrutation_points(user, formulas)
    begin
      counted = count_points(user, formulas)
      counted.each do |points|
        points.gsub!(/.*-1.*/, '-')
      end
      your_results = counted
    end
    user.add_recrutation_results(your_results)
  end
end
