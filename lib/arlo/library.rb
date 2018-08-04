module Arlo
  class API
    def get_library(token, from_date, to_date)
      payload = {
        "dateFrom": "20180802",
        "dateTo": "20180803"
      }
      library = post('https://arlo.netgear.com/hmsweb/users/library', payload, token)
      JSON.parse(library.body)
    end
  end
end
