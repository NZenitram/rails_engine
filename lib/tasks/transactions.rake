require 'csv'

namespace :csv do

  desc "Import CSV Data from Transactions data"
  task :import_transactions => :environment do
    Transaction.delete_all
    csv_file_path = 'lib/seeds/transactions.csv'

    CSV.foreach(csv_file_path, :headers => true) do |row|
      Transaction.create!({
        :invoice_id                  => row[1],
        :credit_card_number          => row[2],
        :credit_card_expiration_date => row[3],
        :result                      => row[4],
        :created_at                  => row[5],
        :updated_at                  => row[6]
        })
        puts "Row Added!"
    end
  end
end
