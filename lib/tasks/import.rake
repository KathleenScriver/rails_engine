require 'csv'
require 'time'

description "Imports all CSV data"
task :import_all do
  Rake::Task["import:customers"].invoke
  Rake::Task["import:invoice_items"].invoke
  Rake::Task["import:invoices"].invoke
  Rake::Task["import:items"].invoke
  Rake::Task["import:merchants"].invoke
  Rake::Task["import:transactions"].invoke
end

namespace :import do

  description "Imports Customer CSV data"
  task customers: :environment do
    CSV.foreach('./lib/data/customers.csv', headers: true, header_converters: :symbols) do |row|
      Customer.find_or_create_by!(
                                  id:         row[:id].to_i,
                                  first_name: row[:first_name],
                                  last_name:  row[:last_name],
                                  created_at: Time.parse(row[:created_at]),
                                  updated_at: Time.parse(row[:updated_at])
                                )
    end
  end

  description "Imports invoice_item csv data"
  task invoice_items: :environment do
    CSV.foreach('./lib/data/invoice_items.csv', headers: true, header_converters: :symbols) do |row|
      InvoiceItem.find_or_create_by!(
                                      id:         row[:id].to_i,
                                      item_id:    row[:item_id].to_i,
                                      invoice_id: row[:invoice_id].to_i,
                                      quantity:   row[:quantity].to_i,
                                      unit_price: row[:unit_price].to_i,
                                      created_at: Time.parse(row[:created_at]),
                                      updated_at: Time.parse(row[:updated_at])
                                    )
    end
  end

  description "Imports invoice csv data"
  task invoices: :environment do
    CSV.foreach('./lib/data/invoices.csv', headers: true, header_converters: :symbols) do |row|
      Invoice.find_or_create_by!(
                                      id:          row[:id].to_i,
                                      customer_id: row[:customer_id].to_i,
                                      merchant_id: row[:merchant_id].to_i,
                                      status:      row[:status],
                                      created_at: Time.parse(row[:created_at]),
                                      updated_at: Time.parse(row[:updated_at])
                                    )
    end
  end

  description "Imports item csv data"
  task items: :environment do
    CSV.foreach('./lib/data/items.csv', headers: true, header_converters: :symbols) do |row|
      Item.find_or_create_by!(
                              id:          row[:id].to_i,
                              name:        row[:name],
                              description: row[:description],
                              unit_price:  row[:unit_price].to_i,
                              merchant_id: row[:merchant_id].to_i,
                              created_at:  Time.parse(row[:created_at]),
                              updated_at:  Time.parse(row[:updated_at])
                              )
    end
  end

  description "Imports merchant CSV data"
  task merchants: :environment do
    CSV.foreach('./lib/data/merchants.csv', headers: true, header_converters: :symbols) do |row|
      Merchant.find_or_create_by!(
                                  id:         row[:id].to_i,
                                  name:       row[:name],
                                  created_at: Time.parse(row[:created_at]),
                                  updated_at: Time.parse(row[:updated_at])
                                )
    end
  end

  description "Imports transcation CSV data"
  task transactions: :environment do
    CSV.foreach('./lib/data/transactions.csv', headers: true, header_converters: :symbols) do |row|
      Transaction.find_or_create_by!(
                                  id:         row[:id].to_i,
                                  invoice_id: row[:invoice_id].to_i,
                                  result:     row[:result],
                                  created_at: Time.parse(row[:created_at]),
                                  updated_at: Time.parse(row[:updated_at])
                                )
    end
  end
end
