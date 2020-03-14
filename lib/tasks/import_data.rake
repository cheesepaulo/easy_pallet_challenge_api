namespace :easy_pallet do
  desc "Import load data from CSV"
  task import_data: :environment do

    require 'csv'

    order_products = []

    CSV.foreach('sample_data.csv', headers: true) do |row|
      order_products << row.to_h
    end

    order_products.each do |item|

      Load.find_or_create_by!(id: item["load_id"].to_i ,code: item["load_code"],
        delivery_date: item["delivery_date"].to_datetime)

      Order.find_or_create_by!(id: item["order_id"].to_i, load_id: item["load_id"].to_i,
        code: item["order_code"], bay: item["bay"])

      Product.find_or_create_by!(id: item["product_id"].to_i, label: item["product_label"],
        ballast: item["ballast"])

      OrderProduct.find_or_create_by!(id: item["order_product_id"].to_i,
        order_id: item["order_id"].to_i, product_id: item["product_id"].to_i,
        quantity: item["quantity"].to_i)
    end
  end
end
