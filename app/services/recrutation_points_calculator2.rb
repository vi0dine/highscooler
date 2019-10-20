# frozen_string_literal: true

class Formula
  def initialize(formula, user)
    @formula = formula
    @exponents = build_exponents
    @subjects = build_subjects
    @basic_results = user.basic_results
    @advanced_results = user.advanced_results
  end

  def calculate
    exponents.reduce(0) do |result, exponent|
      result + exponent.max_result
    end
  end

  private

  def build_exponents
    @formula.split('+').each do |exponent|
      @exponents << Exponent.new(exponent)
    end
  end

  def calculate_exponents
    @exponents.each do |exponent|
      max = exponent.max_result(basic_results, advanced_results)
      if max[:subject][:level] == :basic
        basic_results.reject! { |res| res == max[:subject] }
      elsif max[:subject][:level] == :advanced
        advanced_results.reject! { |res| res == max[:subject] }
      else
        raise 'Wrong result level'
      end
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

  def max_result(basics, advanceds)
    subjects
      .map { |subject| subject.calculate(basics, advanceds) }
      .max_by { |calculated| calculated[:result] }
  end
end

class Subject
  def initialize(subject)
    @subject = subject.gsub!(/^[\(]|[\)]$/, '')
    @subject_name = /(.*)_/.match(@subject)[1].to_s
    @level = /.*_(..)/.match(@subject)[1].to_s == 'Pp' ? :basic : :advanced
    @factor = /.*\*(.*)/.match(@subject)[1].to_f
  end

  attr_reader :subject_name, :level, :factor

  def calculate(basics, advanceds)
    { subject: find_user_result(basics, advanceds),
      result: user_result(basics, advanceds) * factor }
  end

  private

  def find_user_result(basics, advanceds)
    if level == :basic
      basics.find { |result| result.matura_subject.name == subject_name }
    elsif level == :advanced
      advanceds.find { |result| result.matura_subject.name == subject_name }
    else
      raise StandardError, 'Wrong subject level'
    end
  end

  def user_result(basics, advanceds)
    if find_user_result(basics, advanceds).nil?
      0
    else
      find_user_result(basics, advanceds).result
    end
  end
end
