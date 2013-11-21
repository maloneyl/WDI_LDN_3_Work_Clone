require 'mechanize'
require 'pry'
require 'colorize' # for better output

def main
  agent = Mechanize.new
  search_term = "geraudmathe" # what to scrape from site passed below
  page = agent.get("http://www.google.co.uk") # get as in http req
  google_form = page.form("f") # .form("f") is within the giant hash agent.get("...")
  google_form.q = search_term # q is a dynamically-created variable from mechanize for the text input as if it's filling in that google search field (though mechanize has js disabled)
  page = agent.submit(google_form, google_form.buttons.first) # need to reload a page sans js; 2nd arg is the button to hit (we know it's the first button from google_form the object)

  # go past page 1
  links = map_links(page.links, search_term) # page.links: array
  page.links_with(href: Regexp.new("/search\\\?q=#{search_term}&"), text: %r{\d+}).each do |result_page_link| # .links_with is a mechanize method; our regex will get us the pagination links (because they have that ?q=search_term&a_bunch_of_parameters format); %r{\d+} is check with regex that it's not an empty link but one with digits instead
    next_page = result_page_link.click
    links += map_links(next_page.links, search_term)
  end

  links.compact! # get rid of all the nils in the array

  puts "#{links.size} links founds for #{search_term}!"

  # colorize
  links.each{ |link| puts "#{link[:text]}".on_red.green; puts " -> #{link[:uri]}".on_green } # green on red background
end

def map_links(links, search_term)
  links.map do |link|
    if link.text =~ Regexp.new(search_term, :i) && # :i means case-insensitive
      !((matched_uri = /http.*?&/.match(link.uri.to_s).to_s).empty?) # checks it's a proper http; and link.uri.to_s because link.uri is an object and refers to the path past the domain (i.e. google.co.uk/ALLTHISOTHERSTUFF)
      { # if condition not met, return nil; if met, return an array of hash like below, which we can then use to access different values
        text: link.text,
        uri: matched_uri
      }
    end
  end
end

main
