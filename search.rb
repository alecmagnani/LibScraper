require 'nokogiri'
require 'open-uri'

TEXT_ONLY_URL = 'https://babel.hathitrust.org/cgi/'

unless ARGV.length >= 2
    puts "Required arguments:"
    puts "\t HathiTrust magazine URL, e.g. https://catalog.hathitrust.org/Record/000496214"
    puts "\t 1+ search terms (if more than one, enclose in quotes and separate with commas"
    puts
    puts "Optional arguments:"
    puts "\t Year to start search. Precede with -s"
    puts "\t Year to stop search. Precede with -e"
    puts 'E.g.: URL "SEARCH1, SEARCH2" [-s STARTYEAR] [-e ENDYEAR]'
    puts 'E.g.: URL SEARCH > OUTPUT_FILENAME'
    exit
end

terms = []
ARGV[1].split(',').each { |term| terms << term.downcase.strip }
startYear = ARGV[2] == '-s' ? ARGV[3].to_i : 0
endYear = ARGV[2] == '-e' ? ARGV[3].to_i : 3000
endYear = ARGV[4] == '-e' ? ARGV[5].to_i : 3000

edition_urls = []

homepage = Nokogiri::HTML(open(ARGV[0]))
homepage.css('.rights-Array\ fulltext').each do |link|
    link.content.split(' ').reverse_each do |item|
        item = item.delete('(').delete(')').split('-').first
        if item.to_i.to_s == item and (item.to_i >= startYear and item.to_i <= endYear)
            id = link['href'].split('/')[-1]
            edition_urls << TEXT_ONLY_URL + 'ssd?id=' + id
        end
    end
end

edition_urls.each do |url|
    page = Nokogiri::HTML(open(url))
    page.css('.Text').each do |text|
        puts url if terms.any? { |term| text.content.downcase.include? term }
    end

    subpages = []
    page.xpath('//ul/li/a').each do |link|
        subpages << TEXT_ONLY_URL + link['href']
    end

    subpages.each do |url|
        subpage = Nokogiri::HTML(open(url))
        subpage.css('.Text').each do |text|
            puts url if terms.any? { |term| text.content.downcase.strip.include? term }
        end
    end
end