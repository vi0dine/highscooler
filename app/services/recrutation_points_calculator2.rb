# frozen_string_literal: true

class Formula
  def initialize(formula, user)
    @formula = formula
    @exponents = build_exponents
    @basic_results = user.basic_results
    @advanced_results = user.advanced_results
  end

  attr_accessor :formula, :exponents, :basic_results, :advanced_results

  def calculate
    exponents.reduce(0) do |result, exponent|
      max = exponent.max_result(basic_results, advanced_results)
      filter_results(max)
      result + max
    end
  end

  private

  def build_exponents
    formula.split('+').each do |exponent|
      exponents << Exponent.new(exponent)
    end
  end

  def filter_results(max)
    if max[:subject][:level] == :basic
      basic_results.reject! { |res| res == max[:subject] }
    elsif max[:subject][:level] == :advanced
      advanced_results.reject! { |res| res == max[:subject] }
    else
      raise 'Wrong result level'
    end
  end
end

class Exponent
  def initialize(exponent)
    @exponent = exponent.gsub!(/^[\[]|[\]]$/, '')
    @subjects = build_subjects
  end

  attr_reader :subjects, :exponent

  def build_subjects
    exponent.split('|').map do |subject|
      Subject.new(subject)
    end
  end

  def max_result(basic_results, advanced_results)
    subjects
      .map { |subject| subject.calculate(basic_results, advanced_results) }
      .max_by { |calculated| calculated[:result] }
  end
end

class Subject
  def initialize(subject)
    @subject = subject.gsub!(/^[(]|[)]$/, '')
    @subject_name = /(.*)_/.match(@subject)[1].to_s
    @level = /.*_(..)/.match(@subject)[1].to_s == 'Pp' ? :basic : :advanced
    @factor = /.*\*(.*)/.match(@subject)[1].to_f
  end

  attr_reader :subject_name, :level, :factor

  def calculate(basic_results, advanced_results)
    { subject: find_user_result(basic_results, advanced_results),
      result: user_result(basic_results, advanced_results) * factor }
  end

  private

  def find_user_result(basic_results, advanced_results)
    if level == :basic
      basic_results.find { |result| result.matura_subject.name == subject_name }
    elsif level == :advanced
      advanced_results.find { |result| result.matura_subject.name == subject_name }
    else
      raise StandardError, 'Wrong subject level'
    end
  end

  def user_result(basic_results, advanced_results)
    if find_user_result(basic_results, advanced_results).nil?
      0
    else
      find_user_result(basic_results, advanced_results).result
    end
  end
end
