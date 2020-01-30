require 'nokogiri'
require 'httparty'
require 'benchmark'

module Scrapers
  class UniWrocFactors
    def initialize
      puts "Connecting to UniWroc recrutation website..."
      doc = HTTParty.get("https://rekrutacja.uni.wroc.pl/?re=letnia&st&po=s1&tr=stacjonarne")
      @uni_page ||= Nokogiri::HTML(doc)
    end

    def get_links
      puts "Collecting links for fields..."
      @uni_page.css('ul').css('.search_results').css('li').children.map { |link| link['href'] }.compact
    end

    def get_data(links)
      puts "Gathering data for each field. It can take some time..."
      fields = []
      threads = []
      # For each link
      links.each_with_index do |link, id|
        threads[id] = Thread.new {
          field_data = {}
          field = HTTParty.get(link)
          raise "Response is empty" if field.body.nil? || field.body.nil?
          field_page = Nokogiri::HTML(field)
          # Extract field_name
          field_data['field_name'] = field_page.css("main > article> header > h1").map(&:text)
          subjects = []
          # Extract table with matura_subjects and exponents
          field_page.css("section[data-id='zasady'] > table > tbody > tr").each do |row|
            subjects << row.css('td').children.map(&:text)
          end
          field_data['matura_subjects'] = subjects
          # Clear results from '\n'
          field_data['matura_subjects'].each { |exp| exp.reject! { |elem| elem == "\n" } }
          field_data['matura_subjects'].each do |row|
            row.each do |cell|
              cell.downcase!
              cell.gsub!("\n", ' ')
              cell.gsub!("–", '0')
            end
          end
          # Remove first row if its just a header
          if !field_data['matura_subjects'][0].nil? && field_data['matura_subjects'][0].include?("współczynnik dla poziomu podstawowego")
            field_data['matura_subjects'].shift
          end
          fields << field_data
        }
      end
      threads.each(&:join)
      fields
    end

    def make_formulas(data)
      puts "Converting data to recrutation formulas..."
      formulas = []
      # For each field
      data.each do |field_data|
        # Create empty formula
        formula = ''
        # For each matura subject
        field_data['matura_subjects'].each do |elem|
            # single subject
            if elem.first&.start_with?("przedmiot ")
              formula << '['
              elem[1].split(',').each do |subject|
                subject = subject.downcase.strip.chomp(" (pisemny)").chomp(" lub fizyka i astronomia")
                subject = validate_subject(subject)
                formula << "(#{subject}_pp*#{elem[2]&.strip})|"
                formula << "(#{subject}_pr*#{elem[3]&.strip})|"
              end
              formula = formula.chomp('|') << ']+'
            elsif elem.first&.start_with?("przedmiot ") && elem[1]&.strip&.start_with?(/\d/)
              formula << '['
              elem[1].gsub(/.*:.*/, '').split(',').each do |subject|
                subject = subject.downcase.strip.chomp(" (pisemny)").chomp(" lub fizyka i astronomia")
                subject = validate_subject(subject)
                formula << "(#{subject}_pp*#{elem[3]&.strip})|"
                formula << "(#{subject}_pr*#{elem[4]&.strip})|"
              end
              formula = formula.chomp('|') << ']+'
              # and multiple subjects
            elsif elem.first&.start_with?(/.*przedmioty.*/)
              2.times do
                formula << '['
                elem[1].split(',').each do |subject|
                  subject = subject.downcase.strip.chomp(" (pisemny)").chomp(" lub fizyka i astronomia")
                  subject = validate_subject(subject)
                  formula << "(#{subject}_pp*#{elem[2]&.strip})|"
                  formula << "(#{subject}_pr*#{elem[3]&.strip})|"
                end
                formula = formula.chomp('|') << ']+'
              end
              # or multiple language subjects
            elsif elem.first&.start_with?("język obcy nowożytny") && elem[1].start_with?("dowolny")
              formula << '['
              formula << "(angielski_pp*#{elem[2]&.strip})|(niemiecki_pp*#{elem[2]&.strip})|(francuski_pp*#{elem[2]&.strip})|(hiszpański_pp*#{elem[2]&.strip})|(rosyjski_pp*#{elem[2]&.strip})|(włoski_pp*#{elem[2]&.strip})"
              formula << '|'
              formula << "(angielski_pr*#{elem[3]&.strip})|(niemiecki_pr*#{elem[3]&.strip})|(francuski_pr*#{elem[3]&.strip})|(hiszpański_pr*#{elem[3]&.strip})|(rosyjski_pr*#{elem[3]&.strip})|(włoski_pr*#{elem[3]&.strip})"
              formula << ']'
            elsif elem.first&.start_with?("język obcy nowożytny ")
              formula << '['
              formula << "(angielski_pp*#{elem[1]&.strip})|(niemiecki_pp*#{elem[1]&.strip})|(francuski_pp*#{elem[1]&.strip})|(hiszpański_pp*#{elem[1]&.strip})|(rosyjski_pp*#{elem[1]&.strip})|(włoski_pp*#{elem[1]&.strip})"
              formula << '|'
              formula << "(angielski_pr*#{elem[2]&.strip})|(niemiecki_pr*#{elem[2]&.strip})|(francuski_pr*#{elem[2]&.strip})|(hiszpański_pr*#{elem[2]&.strip})|(rosyjski_pr*#{elem[2]&.strip})|(włoski_pr*#{elem[2]&.strip})"
              formula << ']'
            else
              subject = elem.first&.downcase&.strip&.gsub(/.pisemny./, '')&.chomp(" lub fizyka i astronomia")
              subject = validate_subject(subject)
              formula << '[' << "(#{subject}_pp*#{elem[1]&.strip})|"
              formula << "(#{subject}_pr*#{elem[2]&.strip})" << ']+'
            end
        end
        rescue StandardError
          $stderr.puts "Error in #{field_data['field_name']}"
        else
          formulas << {'field_name': field_data['field_name'].first, 'formula': formula.gsub(',', '.').gsub('Dowolny przedmiot (pisemny) inny niż wymienione w tabeli', 'dowolny inny').chomp('+')}
      end
      formulas
    end

    def format_subject(subject)
      subject.gsub!(/język /, '')
      subject.gsub!(/\n/, '')
      subject.downcase.strip
    end

    def validate_subject(subject)
      subject = format_subject(subject)
      existing_subject = MaturaSubject.find_by_name(subject.capitalize)
      raise StandardError.new("Wrong subject format") if existing_subject.nil?
      subject
    end

    def get_limit(field)
      limit = ''
      sample_link = HTTParty.get(@uni_page.css('ul').css('.search_results').css('li').children.map { |link| link['href'] }.first)
      limits_page = Nokogiri::HTML(sample_link)
      limits_page.css("section[data-id='limity'] > table > tbody > tr").each do |row|
        if row.at_css('td').text == field
          limit << row.children[3].text
        end
      end
      limit
    end

    scraper = Scrapers::UniWrocFactors.new
    links = scraper.get_links
    data = scraper.get_data(links)
    scraper.make_formulas(data).each do |formula|
      puts formula[:formula]
      field = FieldOfStudy.create(name: formula[:field_name]&.downcase&.capitalize, description: Faker::Lorem.paragraph)
      puts field.errors.full_messages
      academy = AcademyField.create(field_of_study: field,
                          recruitment_formula: formula[:formula],
                          students_limit: scraper.get_limit(formula[:field_name]),
                          academy: Academy.create_with(city: "Wrocław", description: Faker::Lorem.paragraph).find_or_create_by(name: "Uniwersytet Wrocławski"))
      puts academy.errors.full_messages
    end
  end
end
