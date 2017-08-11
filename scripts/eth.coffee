# Description:
#  Cryptocurrency Price Checker - Ethereum
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   @hal eth price - returns currently hourly price for ETH from Coinbase
#   @hal eth historical - returns last year's price for ETH from Coinbase

module.exports = (robot) ->
    robot.respond /eth price/i, (msg) ->
        url = "https://www.coinbase.com/api/v2/prices/ETH-USD/historic?period=hour";
        msg.http(url).headers(Accept: "application/json").get() (err, res, body) ->
            unless res.statusCode is 200
                msg.send "The Coinbase API did not return a proper response! :rage5:"
                return
            json = JSON.parse body
            msg.send "Current Ethereum Price: $" + json.data.prices[0].price + " " + json.data.currency

    robot.respond /eth historical/i, (msg) ->
        d = new Date();
        date = (d.getFullYear()-1) + "-" + ("0"+(d.getMonth()+1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
        url = "https://api.coinbase.com/v2/prices/ETH-USD/spot?date=" + date

        msg.http(url).headers(Accept: "application/json").get() (err, res, body) ->
            unless res.statusCode is 200
                msg.send "The Coinbase API did not return a proper response! :rage5:"
                return
            json = JSON.parse body
            msg.send "Last Year's Ethereum Price: $" + json.data.amount + " " + json.data.currency