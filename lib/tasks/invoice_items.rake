require 'csv'

namespace :csv do

  desc "Import CSV Data from invoice-items data"
  task :import_invoice_items => :environment do
    InvoiceItem.delete_all
    csv_file_path = 'lib/seeds/invoice_items.csv'

    CSV.foreach(csv_file_path, :headers => true) do |row|
      InvoiceItem.create!({
        :item_id                  => row[1],
        :invoice_id               => row[2],
        :quantity                 => row[3],
        :unit_price               => row[4],
        :created_at               => row[5],
        :updated_at               => row[6]
        })
        puts "Row Added!"
    end
  end
end
