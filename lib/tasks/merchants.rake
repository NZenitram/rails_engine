require 'csv'

namespace :csv do

  desc "Import CSV Data from Merchants data"
  task :import_merchants => :environment do
    Merchant.delete_all
    csv_file_path = 'lib/seeds/merchants.csv'

    CSV.foreach(csv_file_path, :headers => true) do |row|
      Merchant.create!({
        :name => row[1],
        :created_at => row[2],
        :updated_at => row[3]
        })
        puts "Row Added!"
    end
  end
end
