# frozen_string_literal: true

class RecrutationPointsCalculator
  def initialize(user)
    @user = user
    @basic_res = user.matura_results.select(&:basic?)
    @advanced_res = user.matura_results.select(&:advanced?)
    @max_basic_subject_id = nil
    @max_advanced_subject_id = nil
    @max_exponent_result = -1
  end

  def self.call(user)
    new(user).call
  end

  def call
    return false if @user.blank?

    calculate_recrutation_points(@user)
  end

  private

  def find_subject_with_level(level, subject_name)
    if level == 'basic'
      @basic_res.detect { |result| result.basic_subject?(subject_name) }
    elsif level == 'advanced'
      @advanced_res.detect { |result| result.advanced_subject?(subject_name) }
    else
      false
    end
  end

  def update_max_advanced_result(subject, subject_name)
    subject.gsub!(subject_name, find_subject_with_level('advanced', subject_name)&.result.to_s)
    # assign evaluated value to @max_exponent_result
    begin
      if @max_exponent_result < eval(subject)
        @max_exponent_result = eval(subject)
        @max_advanced_subject_id = find_subject_with_level('advanced', subject_name)&.id
      end
    rescue SyntaxError
      p 'Syntax error in formula'
      throw :formula_error
    end
  end

  def update_max_basic_result(subject, subject_name)
    subject.gsub!(subject_name, find_subject_with_level('basic', subject_name)&.result.to_s)
    # assign evaluated value to @max_exponent_result
    begin
      if @max_exponent_result < eval(subject)
        @max_exponent_result = eval(subject)
        @max_basic_subject_id = find_subject_with_level('basic', subject_name)&.id
      end
    rescue SyntaxError
      p 'Syntax error in formula'
      throw :formula_error
    end
  end

  def replace_subject_name(subject)
    subject.gsub!(/^[\(]|[\)]$/, '')
    subject_name = /.*_../.match(subject)[0]
    # replace its name with users result
    if @basic_res.detect { |result| result.basic_subject?(subject_name) }
      update_max_basic_result(subject, subject_name)
    elsif @advanced_res.detect { |result| result.advanced_subject?(subject_name) }
      update_max_advanced_result(subject, subject_name)
    else
      # if no user result assign '0'
      subject.gsub!(subject_name, '0')
    end
  end

  def calculate_exponent(exp, formula)
    @max_exponent_result = -1
    exp.gsub!(/^[\[]|[\]]$/, '')
    # extract subjects
    subjects = exp.split('|')
    # and for each subjects
    subjects.each { |subject| replace_subject_name(subject) }
    # replace first element with @max_exponent_result value
    exp.replace(@max_exponent_result.to_s)
    # reject @max_exponent_result elements from user results to avoid duplicates
    @basic_res.reject! { |res| res.id == @max_basic_subject_id }
    @advanced_res.reject! { |res| res.id == @max_advanced_subject_id }
    # replace formula with calculated elements
    formula << exp << '+'
  end

  def count_points(user)
    # For each formula
    user.formulas.each do |formula|
      catch :formula_error do
        exps = formula.split('+')
        formula.clear
        # and each element
        exps.each { |exp| calculate_exponent(exp, formula) }
      end
    end
  end

  def calculate_recrutation_points(user)
    counted = count_points(user)
    counted.each do |points|
      points.gsub!(/.*-1.*/, '-')
    end
    assign_recrutation_results(user, counted)
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
