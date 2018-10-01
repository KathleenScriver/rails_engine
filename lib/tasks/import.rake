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
                                  first_name: row[:first_name],
                                  last_name: row[:last_name],
                                  created_at: Time.parse(row[:created_at]),
                                  updated_at: Time.parse(row[:updated_at])
                                )
  end

  description "Imports invoice_item csv data"
  task invoice_items: :environment do
    CSV.foreach('./lib/data/invoice_items.csv', headers: true, header_converters: :symbols) do |row|
      InvoiceItem.find_or_create_by!(
                                      
                                    )
  end
end
