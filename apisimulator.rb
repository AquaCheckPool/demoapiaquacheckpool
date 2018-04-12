require 'net/http'
require 'uri'
require 'json'

#constantes
MINUTES = 1
POOLS = [1,2,3]
APIURL = "http://localhost:3000/api/add_pool_values"

def send_values(pool_id,ph,cl2,temp)

    uri = URI.parse(APIURL)

    header = {'Content-Type': 'application/json'}
    user = {
            pool_id: pool_id,
            ph: ph,
            cl2: cl2,
            temp: temp
                }

    # Create the HTTP objects
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = user.to_json

    # Send the request
    response = http.request(request)
end


while true
    POOLS.each do |pool|
        ph=rand(5.8..8.2).round(2)
        cl2=rand(2.0..4.0).round(2)
        temp=rand(18.0..42.0).round(2)
        send_values(pool, ph, cl2, temp)  
    end
    sleep 60*MINUTES
end
