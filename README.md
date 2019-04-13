# LibScraper
## Installation
LibScraper requires [Ruby](https://www.ruby-lang.org/en/downloads/) and [Nokogiri](https://nokogiri.org/tutorials/installing_nokogiri.html). Ruby is installed by default on macOS.\
To install Nokogiri, copy and paste line-by-line to the console (Terminal).

````
git clone https://github.com/alecmagnani/LibScraper  
cd LibScraper
gem update --system
xcode-select --install
gem install nokogiri
````

## Use
From the LibScraper directory, run as follows for basic functionality:
<code>ruby search.rb [URL] [SEARCH TERM]</code>. \
<code>ruby search.rb https://catalog.hathitrust.org/Record/000496214 [SEARCH TERM]</code>

<code>URL</code> Should be a HathiTrust link to a magazine. [Example](https://catalog.hathitrust.org/Record/000496214).

Multiple terms can be used by enclosing them in quotations and separating by commas:\
<code>ruby search.rb [URL] "Term1, Term2, Term3"</code>

The search can be limited by start year and end year with the <code>-s</code> and <code>-e</code> tags:\
<code>ruby search.rb [URL] [TERM] -s 1830 -e 1847</code>\
<code>ruby search.rb [URL] [TERM] -s 1830</code>\
<code>ruby search.rb [URL] [TERM] -e 1847</code>

Output is in the form of URLs, and can be saved to a file using macOS/Linux redirects:\
<code>ruby search.rb [URL] [TERM] -s 1830 -e 1847 > my_search.txt</code>
By default, URLs containing the one or more of the search terms will be printed to the console.

The program can take a while to run. If you are saving to a file as shown above, there will not be any visual indication of the search being completed. Either way, the search can be stopped early by pressing <code>CTRL+C</code>.
