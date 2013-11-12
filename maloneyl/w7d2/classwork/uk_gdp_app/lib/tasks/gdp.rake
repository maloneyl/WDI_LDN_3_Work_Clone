require "csv"

namespace :gdp do

  desc "Process data for UK's quarter GDP and quarter-on-quarter growth"
  task uk: :environment do
    file_path = File.expand_path("../gdp.csv", __FILE__)

    CSV.foreach(file_path) do |qtr, qoq|
      # Format: 1955 Q2
      #    i.e. \d{4}\s[Q]\d
      # test at http://rubular.com
      next unless /\d{4}\s[Q]\d/ =~ qtr

      gdp = Gdp.where(quarter: qtr).first_or_create

      gdp.update_attributes({
        qoq_growth: qoq
      })
    end
  end

end
