module Arlo
  class API
    def get_library(from_date, to_date)
      payload = {
        'dateFrom': from_date,
        'dateTo': to_date
      }
      library = post('https://arlo.netgear.com/hmsweb/users/library', payload)
      JSON.parse(library.body)
    end
  end
end
