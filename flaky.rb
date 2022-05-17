require 'httparty'

class FlakyAPI

  include HTTParty
  base_uri 'https://app-homevision-staging.herokuapp.com/api_project'

  def house_page(page) 
    return "method house_page receive integers" unless ( page.is_a?Integer and page > 0)
    begin
      response = self.class.get("/houses",  { query: {  page: page } })
      body = JSON.parse(response.body,symbolize_names: true)
      raise body[:message] unless response.code == 200
      houses = body[:houses]
      return houses
    rescue => error
      puts  "#{error.message} : Page #{page}"
      house_page(page)
    end
  end

  def house_pages(initial = 1, final)
    houses = []
    for i in initial..final
        houses.concat(house_page(i))
    end
    return houses
  end


  def download_photo(house)
    id = house[:id]
    owner = house[:homeowner]
    address = house[:address]  
    url = house[:photoURL]
    ruta = "./img/#{id}-#{owner}-#{address}.jpg"
    Dir.mkdir("./img") unless File.exist?("./img")
    begin 
      File.open(ruta, "w") do |file|
        response = self.class.get(url)
        photo = JSON.parse(response.body)
        file.write(photo)
      end
    rescue
      return "Error download photo : #{url}"
    end 
  end 

  def dowloands(inicio = 1 , final)
    houses = house_pages(inicio,final)
    houses.each do |house|
      download_photo(house)
    end 
  end


end

flaky = FlakyAPI.new()


puts flaky.house_page(3.5)

