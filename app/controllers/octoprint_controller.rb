class OctoprintController < ApplicationController
  def print
    @printable = Printable.find_by_id(params[:printable_id])
    @printer = Printer.find_by_id(params[:printing_hub][:printer_id])
  end
end
