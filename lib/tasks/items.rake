require 'csv'

namespace :csv do

  desc "Import CSV Data from Items data"
  task :import_items => :environment do
    Item.delete_all
    csv_file_path = 'lib/seeds/items.csv'

    CSV.foreach(csv_file_path, :headers => true) do |row|
      Item.create!({
        :name        => row[1],
        :description => row[2],
        :unit_price  => row[3],
        :merchant_id => row[4],
        :created_at  => row[5],
        :updated_at  => row[6]
        })
        puts "Row Added!"
    end
  end
end
