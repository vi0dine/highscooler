# frozen_string_literal: true

module RecruitmentFormulaCalculator
  class Formula
    def initialize(formula, remove_duplicates=true)
      @user = nil
      @formula = formula.gsub!(/\n/, '').gsub!(/ /, '')
      @exponents = build_exponents
      @remove_duplicates = remove_duplicates
    end

    attr_accessor :formula, :exponents, :user

    def calculate(user)
      @exponents.permutation.to_a.collect do |exponents_permutation|
        @user = user.amoeba_dup
        exponents_permutation.reduce(0) do |result, exponent|
          recruitment_points = result + exponent.calculate(@user)[:user_result]
          @user.matura_results = @user.matura_results
                                     .reject { |result| result.matura_subject == exponent.calculate(@user)[:subject] } if @remove_duplicates
          recruitment_points
        end
      end.max
    end

    private

    def build_exponents
      formula&.split('+')&.map do |exponent|
        Exponent.new(exponent)
      end
    end
  end

  class Exponent
    def initialize(exponent_string)
      @exponent = exponent_string.gsub!(/^[\[]|[\]]$/, '')
      @subjects = build_subjects
    end

    attr_reader :subjects, :exponent

    def calculate(user)
      @subjects.collect { |subject| subject.calculate(user) }
          .max_by { |calculated| calculated[:user_result] }
    end

    private

    def build_subjects
      exponent.split('|').map do |subject|
        Subject.new(subject)
      end
    end
  end

  class Subject
    attr_reader :subject, :level, :multiplier, :name

    def initialize(subject_string)
      subject_string.gsub!(/^[(]|[)]$/, '')
      @name = /(.*)_/.match(subject_string)[1].to_s.capitalize!
      @level = /.*_(..)/.match(subject_string)[1].to_s == 'pp' ? :basic : :advanced
      @multiplier = /.*\*(.*)/.match(subject_string)[1].to_f
      @subject = MaturaSubject.where(name: @name, level: @level).take
    end

    def calculate(user)
      {
          subject: @subject,
          user_result: find_user_result(user) * @multiplier
      }
    end

    private

    def find_user_result(user)
      results = user.matura_results.find_all do |matura_result|
        matura_result.matura_subject == self.subject
      end

      if results.is_a?(Array) && !results.empty?
        results.pluck(:result).max
      else
        0
      end
    end
  end
end
