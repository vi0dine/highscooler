require 'nokogiri'
require 'httparty'
require 'benchmark'

class Scraper
  def initialize
    puts "Connecting to recrutation website..."
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
        field_data['matura_subjects'].each {|exp| exp.reject! { |elem| elem == "\n" } }
        field_data['matura_subjects'].each do |row| 
          row.each do |cell|
            cell.downcase!
            cell.gsub!("\n", ' ')
            cell.gsub!("–", '0')
          end
        end
        # Remove first row if its just a header
        if (!(field_data['matura_subjects'][0].nil?) && field_data['matura_subjects'][0].include?("współczynnik dla poziomu podstawowego"))
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
    threads = []
    # For each field
    data.each do |field_data|
      # Create empty formula
      formula = ''
      # For each matura subject
      field_data['matura_subjects'].each_with_index do |elem, id|
        threads[id] = Thread.new {
          # single subject
          if elem.first&.start_with?("przedmiot ")
            formula << '['
            elem[1].split(',').each do |subject|
              subject = subject.downcase.strip.chomp(" (pisemny)").chomp(" lub fizyka i astronomia")
              formula << "(#{subject.capitalize}_Pp*#{elem[2]&.strip})|"
              formula << "(#{subject.capitalize}_Pr*#{elem[3]&.strip})|"
            end
            formula = formula.chomp('|') << ']+'
          elsif elem.first&.start_with?("przedmiot ") && elem[1]&.strip&.start_with?(/\d/)
            formula << '['
            elem[1].gsub(/.*:.*/, '').split(',').each do |subject|
              subject = subject.downcase.strip.chomp(" (pisemny)").chomp(" lub fizyka i astronomia")
              formula << "(#{subject.capitalize}_Pp*#{elem[3]&.strip})|"
              formula << "(#{subject.capitalize}_Pr*#{elem[4]&.strip})|"
            end
            formula = formula.chomp('|') << ']+'
          # and multiple subjects
          elsif elem.first&.start_with?(/.*przedmioty.*/)
            2.times do
              formula << '['
              elem[1].split(',').each do |subject|
                subject = subject.downcase.strip.chomp(" (pisemny)").chomp(" lub fizyka i astronomia")
                formula << "(#{subject.capitalize}_Pp*#{elem[2]&.strip})|"
                formula << "(#{subject.capitalize}_Pr*#{elem[3]&.strip})|"
              end
              formula = formula.chomp('|') << ']+'
            end
          # or multiple language subjects
          elsif elem.first&.start_with?("język obcy nowożytny ") && elem[1].start_with?("dowolny")
            formula << '['
            formula << "(Język angielski_Pp*#{elem[2]&.strip})|(Język niemiecki_Pp*#{elem[2]&.strip})|(Język francuski_Pp*#{elem[2]&.strip})|(Język hiszpański_Pp*#{elem[2]&.strip})|(Język rosyjski_Pp*#{elem[2]&.strip})|(Język włoski_Pp*#{elem[2]&.strip})"
            formula << '|'
            formula << "(Język angielski_Pr*#{elem[3]&.strip})|(Język niemiecki_Pr*#{elem[3]&.strip})|(Język francuski_Pr*#{elem[3]&.strip})|(Język hiszpański_Pr*#{elem[3]&.strip})|(Język rosyjski_Pr*#{elem[3]&.strip})|(Język włoski_Pr*#{elem[3]&.strip})"
            formula << ']'
          elsif elem.first&.start_with?("język obcy nowożytny ")
            formula << '['
            formula << "(Język angielski_Pp*#{elem[1]&.strip})|(Język niemiecki_Pp*#{elem[1]&.strip})|(Język francuski_Pp*#{elem[1]&.strip})|(Język hiszpański_Pp*#{elem[1]&.strip})|(Język rosyjski_Pp*#{elem[1]&.strip})|(Język włoski_Pp*#{elem[1]&.strip})"
            formula << '|'
            formula << "(Język angielski_Pr*#{elem[2]&.strip})|(Język niemiecki_Pr*#{elem[2]&.strip})|(Język francuski_Pr*#{elem[2]&.strip})|(Język hiszpański_Pr*#{elem[2]&.strip})|(Język rosyjski_Pr*#{elem[2]&.strip})|(Język włoski_Pr*#{elem[2]&.strip})"
            formula << ']'
          else
            subject = elem.first&.downcase&.strip&.gsub(/.pisemny./, '')&.chomp(" lub fizyka i astronomia")
            formula << '[' << "(#{subject&.capitalize}_Pp*#{elem[1]&.strip})|"
            formula << "(#{subject&.capitalize}_Pr*#{elem[2]&.strip})" << ']+'
          end
        }
      end
      threads.each(&:join)
      formulas << {'field_name': field_data['field_name'].first, 'formula': formula.gsub(',', '.').gsub('Dowolny przedmiot (pisemny) inny niż wymienione w tabeli', 'dowolny inny').chomp('+')}
    end
    formulas
  end

  def get_limit(field)
    limit = ''
    sample_link = HTTParty.get(@uni_page.css('ul').css('.search_results').css('li').children.map { |link| link['href'] }.first)
    limits_page = Nokogiri::HTML(sample_link)
    field_row = limits_page.css("section[data-id='limity'] > table > tbody > tr").each do |row|
      if row.at_css('td').text == field
        limit << row.children[3].text
      end
    end
    limit
  end

  Benchmark.bm do |benchmark|
    benchmark.report('Initialize scraper') do
      scraper = Scraper.new
    end

    benchmark.report('Grab links') do
      scraper = Scraper.new
      links = scraper.get_links
    end

    benchmark.report('Grab fields data') do
      scraper = Scraper.new
      links = scraper.get_links
      data = scraper.get_data(links)
    end

    benchmark.report('Make formulas') do
      threads = []
      uni_wroc_fields = File.new('./utils/uwr/uwr_fields.txt', 'a')
      uni_wroc_formulas = File.new('./utils/uwr/uwr_formulas.txt', 'a')
      scraper = Scraper.new
      links = scraper.get_links
      data = scraper.get_data(links)
      scraper.make_formulas(data).each_with_index do |formula, id|
        threads[id] = Thread.new {
          uni_wroc_fields << "#{formula[:field_name]&.downcase&.capitalize} = FieldOfStudy.new(name: '#{formula[:field_name]&.downcase&.capitalize}', field_type: ?)" << "\n" << "#{formula[:field_name]&.downcase&.capitalize}.id = #{id}" << "\n" << "#{formula[:field_name]&.downcase&.capitalize}.save\n"
          uni_wroc_formulas << "FieldDetail.create(students_limit: #{scraper.get_limit(formula[:field_name])},
                    recrutation_formula: '#{formula[:formula]}',
                    academy_id: 1,
                    field_of_study_id: #{id}" << "\n"
        }
      end
      threads.each(&:join)
    end
  end

  # threads = []
  # uni_wroc = File.new('./uwr.txt', 'a')
  # scraper = Scraper.new
  # links = scraper.get_links
  # data = scraper.get_data(links)
  # data.each_with_index do |field, id|
  #   uni_wroc << "FieldOfStudy.create(name: '#{field['field_name']&.first&.downcase&.capitalize}', field_type: ?)" << "\n"
  # end
  # scraper.make_formulas(data).each_with_index do |formula, id|
  #   threads[id] = Thread.new {
  #     uni_wroc << "FieldDetail.create(students_limit: #{scraper.get_limit(formula[:field_name])},
  #               recrutation_formula: '#{formula[:formula]}',
  #               academy_id: 1,
  #               field_of_study_id: #{id})" << "\n"
  #   }
  # end
end
