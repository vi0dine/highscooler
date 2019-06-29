require 'nokogiri'
require 'httparty'

class Scraper

  attr_accessor :parse_page

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
    # For each link
    links.each do |link|
      field_data = {}
      field = HTTParty.get(link)
      field_page = Nokogiri::HTML(field)
      # Extract field name
      field_data['Field Name'] = field_page.css("main > article> header > h1").map(&:text)
      subjects = []
      # Extract table with matura subjects and exponents
      field_page.css("section[data-id='zasady'] > table > tbody > tr").each do |row|
        subjects << row.css('td').children.map(&:text)
      end
      field_data['Matura Subjects'] = subjects
      # Clear results from '\n'
      field_data['Matura Subjects'].each {|exp| exp.reject! { |elem| elem == "\n" } }
      field_data['Matura Subjects'].each do |row| 
        row.each do |cell|
          cell.downcase!
          cell.gsub!("\n", ' ')
          cell.gsub!("–", '0')
        end
      end
      # Remove first row if its just a header
      if (!(field_data['Matura Subjects'][0].nil?) && field_data['Matura Subjects'][0].include?("współczynnik dla poziomu podstawowego"))
        field_data['Matura Subjects'].shift
      end
      fields << field_data
    end
    fields
  end

  def make_formulas(data)
    puts "Converting data to recrutation formulas..."
    formulas = []
    data.each do |field_data|
      formula = ''
      field_data['Matura Subjects'].each do |elem|
        if elem.first&.start_with?("przedmiot ")
          formula << '['
          elem[1].split(',').each do |subject|
            formula << "(#{subject.strip.capitalize}_Pp*#{elem[2]&.strip})|"
            formula << "(#{subject.strip.capitalize}_Pr*#{elem[3]&.strip})|"
          end
          formula.chomp('|') << ']+'
        elsif elem.first&.start_with?("przedmioty ")
          2.times do
            formula << '['
            elem[1].split(',').each do |subject|
              formula << "(#{subject.strip.capitalize}_Pp*#{elem[2]&.strip})|"
              formula << "(#{subject.strip.capitalize}_Pr*#{elem[3]&.strip})|"
            end
            formula.chomp('|') << ']+'
          end
        else
          formula << '[' << "(#{elem.first&.capitalize}_Pp*#{elem[2]&.strip})|"
          formula << "(#{elem.first&.capitalize}_Pr*#{elem[3]&.strip})" << ']+'
        end
      end
      formulas << { 'field_name': field_data['Field Name'].first, 'formula': formula.chomp('+')}
    end
    formulas
  end

  uni_wroc = File.new('uwr.txt', 'a')
  scraper = Scraper.new
  links = scraper.get_links
  data = scraper.get_data(links)
  scraper.make_formulas(data).each do |formula|
    uni_wroc << formula << "\n"
  end 
end
