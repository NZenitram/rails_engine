require 'csv'

namespace :csv do

  desc "Import CSV Data from invoices data"
  task :import_invoices => :environment do
    Invoice.delete_all
    csv_file_path = 'lib/seeds/invoices.csv'

    CSV.foreach(csv_file_path, :headers => true) do |row|
      Invoice.create!({
        :customer_id => row[1],
        :merchant_id => row[2],
        :status      => row[3],
        :created_at  => row[4],
        :updated_at  => row[5]
        })
        puts "Row Added!"
    end
  end
end
