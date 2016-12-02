require 'csv'

desc "Seed data files"

task :seed_data => [:environment] do

  customer_file_path = 'lib/seeds/customers.csv'
  merchant_file_path = 'lib/seeds/merchants.csv'
  item_file_path = 'lib/seeds/items.csv'
  invoice_file_path = 'lib/seeds/invoices.csv'
  transaction_file_path = 'lib/seeds/transactions.csv'
  invoice_item_file_path = 'lib/seeds/invoice_items.csv'

  CSV.foreach(customer_file_path, :headers => true) do |row|
    Customer.create!({
      :first_name => row[1],
      :last_name  => row[2],
      :created_at => row[3],
      :updated_at => row[4]
      })
      puts "Row Added!"
  end

  CSV.foreach(merchant_file_path, :headers => true) do |row|
    Merchant.create!({
      :name => row[1],
      :created_at => row[2],
      :updated_at => row[3]
      })
      puts "Row Added!"
  end

  CSV.foreach(item_file_path, :headers => true) do |row|
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

    CSV.foreach(invoice_file_path, :headers => true) do |row|
      Invoice.create!({
        :customer_id => row[1],
        :merchant_id => row[2],
        :status      => row[3],
        :created_at  => row[4],
        :updated_at  => row[5]
        })
        puts "Row Added!"
    end

    CSV.foreach(transaction_file_path, :headers => true) do |row|
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

    CSV.foreach(invoice_item_file_path, :headers => true) do |row|
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
