class Lineitemsprices < ActiveRecord::Migration
  def up
    LineItem.all.each do |line|
      if line.product.nil?
        line.price=nil
      else
        line.price=line.product.price
      end
      line.save!
    end
  end

  def down
    LineItem.all.each do |line|
      line.price=nil
      line.save!
    end
  end
end
