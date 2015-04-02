class DogsController < ApplicationController

def new
	@mix_array = Mix.to_array
	@mix_json = Mix.to_json_array
end

end