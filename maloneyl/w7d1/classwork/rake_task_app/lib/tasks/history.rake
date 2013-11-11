require "csv" # csv is a native module of ruby (standard-lib), but it's not loaded by default (only core-lib is)

namespace :history do

  desc "Process data for EUR vs USD, GBP, JPY"
  task euro: :environment do # euro is key, environment is value; means euro task depends on environment (environment is rails)
    file_path = File.expand_path("../exchange.csv", __FILE__) # absolute path, starting from our own HD
    # __FILE__ is native ruby constant, with an output of current file path of where this is called (i.e. Users/Maloney/.../lib/tasks/history.rake)
    # and now our file_path var is:
    # Users/Maloney/.../lib/tasks/exchange.csv

    CSV.foreach(file_path) do |date, usd, gbp, jpy| # what's passed: our CSV's column names
      # define RegEx because our exchange.csv has a few useless lines before the real info
      # which means we need to have something to look for and accept only something like 2010-01-01
      # \d: means digits 0-9; \d{4} means 4 of that
      # so /\d{4}-\d{2}-\d{2}/ is something that resembles 2010-01-01
      next unless /\d{4}-\d{2}-\d{2}/ =~ date # next is for our forreach; our regex code returns true or false
      rate = Rate.where(date_value: Date.parse(date)).first_or_create # date is a string, so Date.parse to convert
      # .first_or_create: returns first element found by where, and create an element with that date value if it doesn't exist (so we won't get nil and hence an error)
      rate.update_attributes({
        usd: usd,
        gbp: gbp,
        jpy: jpy
      })
    end
  end

  # result:
  # ➜  rake_task_app git:(w7d1-maloneyl) ✗ rake history:euro
  # ➜  rake_task_app git:(w7d1-maloneyl) ✗ rails c
  # Loading development environment (Rails 3.2.14)
  # irb(main):001:0> Rate.count
  #    (0.3ms)  SELECT COUNT(*) FROM "rates"
  # => 1006


end
