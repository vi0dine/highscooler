# frozen_string_literal: true

class Formula
  def initialize(formula)
    @formula = formula
    @exponents = build_exponents
    @basic_results = user.basic_results
    @advanced_results = user.advanced_results

    @top_basic_subject_id = nil
    @top_advanced_subject_id = nil
    @max_exponent_result = nil
  end

  def calculate; end

  private

  def build_exponents
    @formula.split('+').each do |exponent|
      @exponents << Exponent.new(exponent)
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

  def max_result(user)
    subjects.map { |subject| subject.calculate(user) }.max
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

  def user_result(user)
    if level == :basic
      user.find_basic_result_for_subject_name(subject_name)
    elsif level == :advanced
      user.find_advanced_result_for_subject_name(subject_name)
    else
      raise StandardError, 'Wrong subject level'
    end
  end

  def calculate(user)
    user_result(user) * factor
  end
end
