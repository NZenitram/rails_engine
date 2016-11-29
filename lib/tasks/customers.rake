require 'csv'

namespace :csv do

  desc "Import CSV Data from Customers data"
  task :import_customers => :environment do
    Customer.delete_all
    csv_file_path = 'lib/seeds/customers.csv'

    CSV.foreach(csv_file_path, :headers => true) do |row|
      Customer.create!({
        :first_name => row[1],
        :last_name  => row[2],
        :created_at => row[3],
        :updated_at => row[4]
        })
        puts "Row Added!"
    end
  end
end
