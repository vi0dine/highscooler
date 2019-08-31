# frozen_string_literal: true

class RecrutationPointsCalculator
  def initialize(user)
    @user = user
  end

  def self.call(user)
    new(user).call
  end

  def call
    return false if @user.blank?

    calculate_recrutation_points(@user)
  end

  private

  # RegEx 1: \(([^()]+)\) -> Match elements in parentheses
  # RegEx 2: [^(].+?(#{subject.name}).+?(?=\))
  # RegEx 3: \(.*?(#{subject.name}).*?\)
  # RegEx 4: \((?:(?!#{subject_to_not_include}).)*?\)

  def count_points(user)
    # For each formula
    user.formulas.each do |formula|
      catch :formula_error do 
        basic_res = user.matura_results.select(&:basic?)
        advanced_res = user.matura_results.select(&:advanced?)
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
            # replace its name with users result
            if basic_res.detect{ |result| result.basic_subject?(subject_name) }
              subject.gsub!(subject_name, (basic_res.detect{ |result| result.basic_subject?(subject_name) })&.result.to_s)
              # assign evaluated value to max
              begin
                if max < eval(subject)
                  max = eval(subject)
                  max_basic_subject_id = (basic_res.detect{ |result| result.basic_subject?(subject_name) })&.id
                end
              rescue SyntaxError
                p 'Syntax error in formula'
                throw :formula_error
              end
            elsif advanced_res.detect{ |result| result.advanced_subject?(subject_name) }
              subject.gsub!(subject_name, (advanced_res.detect{ |result| result.advanced_subject?(subject_name) })&.result.to_s)
              # assign evaluated value to max
              begin
                if (max < eval(subject))
                  max = eval(subject)
                  max_advanced_subject_id = (advanced_res.detect{ |result| result.advanced_subject?(subject_name) })&.id
                end
              rescue SyntaxError
                p 'Syntax error in formula'
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
          basic_res.reject! { |res| res.id == max_basic_subject_id }
          advanced_res.reject! { |res| res.id == max_advanced_subject_id}
          # replace formula with calculated elements
          formula << exp << "+"
        end
      end
    end
  end

  def calculate_recrutation_points(user)
    begin
      counted = count_points(user)
      counted.each do |points|
        points.gsub!(/.*-1.*/, '-')
      end
      your_results = counted
    end
    assign_recrutation_results(user, your_results)
  end

  def assign_recrutation_results(user, prepared_formulas)
    user.results = []
    prepared_formulas.each do |result|
      begin
        eval(result.chomp('+').to_s)
      rescue SyntaxError
        user.results << '-'
      else
        user.results << eval(result.chomp('+').to_s)
      end
    end
  end
end
