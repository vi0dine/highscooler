# frozen_string_literal: true

module RecruitmentFormulaCalculator
  class Formula
    def initialize(formula)
      @formula = formula
      @exponents = build_exponents
    end

    attr_accessor :formula, :exponents

    def extract_factors
      factors = []
      @exponents&.each do |e|
        factors << e
      end
      factors
    end

    private

    def build_exponents
      formula&.split('+')&.map do |exponent|
        Exponent.new(exponent)
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
  end

  class Subject
    def initialize(subject_string)
      subject_string.gsub!(/^[(]|[)]$/, '')
      @subject = MaturaSubject.find_by_name(/(.*)_/.match(subject_string)[1].to_s.capitalize!)
      @level = /.*_(..)/.match(subject_string)[1].to_s == 'pp' ? :basic : :advanced
      @multiplier = /.*\*(.*)/.match(subject_string)[1].to_f
    end
  end
end
