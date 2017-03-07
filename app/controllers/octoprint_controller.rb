class OctoprintController < ApplicationController
  def print
    @printable = Printable.find_by_id(params[:printable_id])
    @printer = Printer.find_by_id(params[:printing_hub][:printer_id])

    #Download gcode from git
    IO.copy_stream(open('https://raw.githubusercontent.com/'+@printable.github_repo+'/master/toolpath.gcode'),
			'public/gcode_temp/'+current_user.id.to_s+'.gcode')

    #Upload gcode to octoprint
		@upload_file_response = RestClient.post('http://'+@printer.ip+'/api/files/local', 
			{:file => File.new('public/gcode_temp/'+current_user.id.to_s+'.gcode', 'rb')},
			{'X-Api-Key' => @printer.api_key})

    #Print
    @print_response = RestClient.post('http://'+@printer.ip+'/api/files/local/'+current_user.id.to_s+'.gcode',
			{'command' => 'select', 'print' => true}.to_json,
			{'Content-Type' => 'application/json', 'X-Api-Key' => @printer.api_key})

  end
end
