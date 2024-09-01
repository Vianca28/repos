#  > stock_picker([17,3,6,9,15,8,6,1,10])
#                  b, s,b,s,b, s,b,s,b
#=> [1,4]  
# for a profit of $15 - $3 == $12
# 
# compare index and data


def stock_picker(stock)
  lowest_price_day=0
  best_sell_day = nil
  best_profit=0
  best_days=""

    stock.each_with_index do |buy, buy_day|
      stock.each_with_index do |sell, sell_day|

        profit = sell - buy       

        if profit > best_profit && buy_day < sell_day
          best_profit=profit
          best_days=[buy_day, sell_day]
         
        end
      end
    end 
      p best_days         
end

#input = [17,3,6,9,15,8,6,1,10]
input = [20,5,8,3,4,25,17]
p stock_picker(input)


